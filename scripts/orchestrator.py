import os
import sys
import json
import subprocess
import argparse
from datetime import datetime

def load_config():
    config_path = os.path.join(".agent", "config.json")
    if os.path.exists(config_path):
        with open(config_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    return {
        "backend": "cli",
        "api_fallback_enabled": True,
        "agents": {
            "claude": {"command": ["claude", "-p"], "input_mode": "argument", "stdin_fallback": True},
            "codex": {"command": ["codex", "exec"], "input_mode": "argument", "stdin_fallback": True}
        }
    }

def update_status(task_dir, agent_name, exit_code):
    status_path = os.path.join(task_dir, "status.json")
    status = {}
    if os.path.exists(status_path):
        try:
            with open(status_path, 'r', encoding='utf-8') as f:
                status = json.load(f)
        except:
            pass
    
    status[f"{agent_name}_exit_code"] = exit_code
    status["last_updated"] = datetime.now().isoformat()
    status["mode"] = status.get("mode", "orchestrated")
    
    with open(status_path, 'w', encoding='utf-8') as f:
        json.dump(status, f, indent=2, ensure_ascii=False)

def run_cli_backend(agent_name, prompt_file, task_dir, config, dry_run=False):
    agent_cfg = config.get("agents", {}).get(agent_name, {})
    base_cmd = agent_cfg.get("command", [])
    input_mode = agent_cfg.get("input_mode", "argument")
    stdin_fallback = agent_cfg.get("stdin_fallback", True)

    if not base_cmd:
        print(f"Error: No command defined for agent '{agent_name}' in config.", file=sys.stderr)
        return 1

    with open(prompt_file, 'r', encoding='utf-8') as f:
        prompt = f.read().strip()

    cmd = list(base_cmd)
    stdin_data = None

    if input_mode == "argument":
        # Windows command line limit is 8191. 8000 is a safe threshold.
        if len(prompt) > 8000 and stdin_fallback:
            stdin_data = prompt
        else:
            # Safely quote the prompt for shell execution if using powershell command
            cmd.append(prompt)
    else:
        stdin_data = prompt

    if dry_run:
        print(f"[DRY-RUN] Agent: {agent_name}")
        print(f"[DRY-RUN] Backend: CLI")
        print(f"[DRY-RUN] Command: {' '.join(cmd)}")
        if stdin_data:
            print(f"[DRY-RUN] Stdin: (First 100 chars) {stdin_data[:100]}...")
        return 0

    try:
        # Use shell=True on Windows if necessary, but list args are safer
        result = subprocess.run(cmd, input=stdin_data, text=True, capture_output=True, encoding='utf-8', errors='replace')
        
        # Save logs
        with open(os.path.join(task_dir, f"{agent_name}_stdout.txt"), 'w', encoding='utf-8') as f:
            f.write(result.stdout)
        with open(os.path.join(task_dir, f"{agent_name}_stderr.txt"), 'w', encoding='utf-8') as f:
            f.write(result.stderr)
            
        update_status(task_dir, agent_name, result.returncode)
        
        if result.returncode == 0:
            print(f"Success: {agent_name} output saved to {task_dir}")
        else:
            print(f"Error: {agent_name} failed with exit code {result.returncode}. Check logs in {task_dir}", file=sys.stderr)
            
        return result.returncode
    except Exception as e:
        error_msg = f"Fatal error executing CLI agent '{agent_name}': {str(e)}"
        print(error_msg, file=sys.stderr)
        with open(os.path.join(task_dir, f"{agent_name}_stderr.txt"), 'w', encoding='utf-8') as f:
            f.write(error_msg)
        update_status(task_dir, agent_name, -1)
        return -1

def run_api_backend(agent_name, prompt_file, task_dir, dry_run=False):
    # Mapping for vendor models
    model_map = {
        "claude": {"provider": "anthropic", "model": "claude-3-5-sonnet-20241022", "env": "ANTHROPIC_API_KEY"},
        "codex": {"provider": "openai", "model": "gpt-4o", "env": "OPENAI_API_KEY"}
    }
    
    info = model_map.get(agent_name)
    if not info:
        print(f"Error: Unknown agent '{agent_name}' for API backend.", file=sys.stderr)
        return 1

    api_key = os.environ.get(info["env"])
    if not dry_run and not api_key:
        print(f"Error: {info['env']} is missing. Required for API backend.", file=sys.stderr)
        return 1

    if dry_run:
        print(f"[DRY-RUN] Agent: {agent_name}")
        print(f"[DRY-RUN] Backend: API ({info['provider']})")
        print(f"[DRY-RUN] Model: {info['model']}")
        print(f"[DRY-RUN] Prompt File: {prompt_file}")
        print(f"[DRY-RUN] API Key: {'SET' if api_key else 'NOT SET'} (Hidden)")
        return 0

    try:
        from anthropic import Anthropic
        from openai import OpenAI

        with open(prompt_file, 'r', encoding='utf-8') as f:
            prompt = f.read().strip()

        response_text = ""

        if info["provider"] == "anthropic":
            client = Anthropic(api_key=api_key)
            message = client.messages.create(
                model=info["model"],
                max_tokens=4096,
                system="You are an expert Refresheet AI agent.",
                messages=[{"role": "user", "content": prompt}]
            )
            for block in message.content:
                if hasattr(block, 'text'): response_text += block.text
                else: response_text += str(block)

        elif info["provider"] == "openai":
            client = OpenAI(api_key=api_key)
            completion = client.chat.completions.create(
                model=info["model"],
                messages=[
                    {"role": "system", "content": "You are an expert Refresheet AI agent."},
                    {"role": "user", "content": prompt}
                ]
            )
            response_text = completion.choices[0].message.content

        # Save to stdout.txt for consistency with CLI backend
        with open(os.path.join(task_dir, f"{agent_name}_stdout.txt"), 'w', encoding='utf-8') as f:
            f.write(response_text)
        
        update_status(task_dir, agent_name, 0)
        print(f"Success: API response for {agent_name} saved to {task_dir}")
        return 0

    except Exception as e:
        error_msg = f"Error in API bridge: {str(e)}"
        print(error_msg, file=sys.stderr)
        with open(os.path.join(task_dir, f"{agent_name}_stderr.txt"), 'w', encoding='utf-8') as f:
            f.write(error_msg)
        update_status(task_dir, agent_name, -1)
        return -1

def main():
    parser = argparse.ArgumentParser(description="Refresheet Multi-Agent Orchestrator")
    parser.add_argument("task_type", help="Task type token (e.g. #PLAN#, #EXEC#)")
    parser.add_argument("prompt_file", help="Path to the prompt text file")
    parser.add_argument("--agent", required=True, choices=["claude", "codex"], help="Target agent")
    parser.add_argument("--backend", choices=["cli", "api"], help="Override default backend")
    parser.add_argument("--task-dir", help="Directory for logs (default: directory of prompt_file)")
    parser.add_argument("--dry-run", action="store_true", help="Print command without executing")

    args = parser.parse_args()

    config = load_config()
    backend = args.backend or config.get("backend", "cli")
    
    task_dir = args.task_dir or os.path.dirname(args.prompt_file) or "."
    if not os.path.exists(task_dir):
        os.makedirs(task_dir, exist_ok=True)

    if backend == "cli":
        sys.exit(run_cli_backend(args.agent, args.prompt_file, task_dir, config, args.dry_run))
    else:
        sys.exit(run_api_backend(args.agent, args.prompt_file, task_dir, args.dry_run))

if __name__ == "__main__":
    main()
