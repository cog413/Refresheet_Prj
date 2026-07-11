import os
import argparse
import sys
from anthropic import Anthropic
from openai import OpenAI

def main():
    parser = argparse.ArgumentParser(description="LLM Bridge for Multi-Agent Orchestration")
    parser.add_argument("--provider", required=True, choices=["anthropic", "openai"], help="LLM Provider")
    parser.add_argument("--model", required=True, help="Model name")
    parser.add_argument("--system-prompt-file", required=True, help="Path to system prompt file")
    parser.add_argument("--user-prompt-file", required=True, help="Path to user prompt file")
    parser.add_argument("--output-file", required=True, help="Path to save the output")

    args = parser.parse_args()

    try:
        # Read prompts from files
        with open(args.system_prompt_file, 'r', encoding='utf-8') as f:
            system_prompt = f.read().strip()
        with open(args.user_prompt_file, 'r', encoding='utf-8') as f:
            user_prompt = f.read().strip()

        response_text = ""

        if args.provider == "anthropic":
            api_key = os.environ.get("ANTHROPIC_API_KEY")
            if not api_key:
                raise ValueError("ANTHROPIC_API_KEY environment variable is missing.")
            
            client = Anthropic(api_key=api_key)
            message = client.messages.create(
                model=args.model,
                max_tokens=4096,
                system=system_prompt,
                messages=[
                    {"role": "user", "content": user_prompt}
                ]
            )
            # Handle different content types in Anthropic response
            for block in message.content:
                if hasattr(block, 'text'):
                    response_text += block.text
                else:
                    response_text += str(block)

        elif args.provider == "openai":
            api_key = os.environ.get("OPENAI_API_KEY")
            if not api_key:
                raise ValueError("OPENAI_API_KEY environment variable is missing.")
            
            client = OpenAI(api_key=api_key)
            completion = client.chat.completions.create(
                model=args.model,
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": user_prompt}
                ]
            )
            response_text = completion.choices[0].message.content

        # Write output to file
        with open(args.output_file, 'w', encoding='utf-8') as f:
            f.write(response_text)
        
        print(f"Success: Response written to {args.output_file}")

    except Exception as e:
        error_msg = f"Error in LLM Bridge: {str(e)}"
        print(error_msg, file=sys.stderr)
        with open(args.output_file, 'w', encoding='utf-8') as f:
            f.write(error_msg)
        sys.exit(1)

if __name__ == "__main__":
    main()
