const fs = require('fs');

function readUtf8(path) {
  return fs.readFileSync(path, 'utf8');
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

const faqHtml = readUtf8('public/faq.html');
const staticCss = readUtf8('public/refresheet-static.css');
const minimeSetup = readUtf8('src/minime/minimeSetup.js');
const appCss = readUtf8('style.css');
const workerJs = readUtf8('src/worker/index.js');
const excelLayoutJs = readUtf8('src/layout/excelLayout.js');
const unlockMigration = readUtf8('docs/migrations/008_unlockables_referrals.sql');
const handoff = readUtf8('HANDOFF.md');

const requiredFaqFragments = [
  ['friend referral anchor', 'id="friend-referral"'],
  ['referral card class', 'referral-card'],
  ['animated mockup root', 'id="mock-window"'],
  ['mock mouse pointer', 'id="mock-mouse"'],
  ['settings modal', 'id="mock-settings-modal"'],
  ['referral input', 'id="mock-referral-input"'],
  ['referral save button', 'id="mock-btn-referral-save"'],
  ['success overlay', 'id="mock-success-screen"'],
  ['referral FAQ copy', '친구 추천 기능은 어떻게 이용하나요?'],
  ['immutable referral copy', '추천계정은 한 번 저장하면 수정할 수 없습니다.'],
  ['animation loop script', 'runAnimationLoop'],
];

for (const [label, fragment] of requiredFaqFragments) {
  assert(faqHtml.includes(fragment), `FAQ is missing ${label}: ${fragment}`);
}

const requiredCssFragments = [
  '.article-grid .note.referral-card',
  '.mockup-container',
  '.mock-mouse',
  '.mock-modal-overlay.show',
  '.mock-success-overlay.show',
];

for (const fragment of requiredCssFragments) {
  assert(staticCss.includes(fragment), `Referral FAQ CSS is missing: ${fragment}`);
}

assert(
  minimeSetup.includes("'/faq#friend-referral'") || minimeSetup.includes('"/faq#friend-referral"'),
  'Kitty lock help link must point to /faq#friend-referral'
);

assert(
  workerJs.includes("const ALWAYS_LOCKED_UNLOCKABLES = new Set(['new_game'])"),
  'NewGame must be protected by the always-locked backend policy'
);
assert(
  workerJs.includes('ALWAYS_LOCKED_UNLOCKABLES.has(row.item_key)') &&
    workerJs.indexOf('ALWAYS_LOCKED_UNLOCKABLES.has(row.item_key)') < workerJs.indexOf("row.lock_type === 'none'"),
  'NewGame always-locked check must run before generic unlock exemptions'
);
assert(
  unlockMigration.includes("'new_game',") &&
    unlockMigration.includes("'disabled',") &&
    unlockMigration.includes('NULL,') &&
    !unlockMigration.includes("'new_game',\n  'sheet',\n  'NewGame',\n  'referral'"),
  'Migration 008 must seed NewGame as disabled, not referral-unlocked'
);
assert(
  excelLayoutJs.includes('=NEWGAME.LOCKED("준비중")'),
  'NewGame formula bar copy must not describe referral unlocks'
);
assert(
  handoff.includes('NewGame is always locked for every user') &&
    !handoff.includes('NewGame is locked by backend unlock state until the signed-in user has at least 2 valid referrals'),
  'Handoff must document the current NewGame always-locked policy'
);

const mobileMediaStart = appCss.indexOf('@media (max-width: 768px)');
assert(mobileMediaStart >= 0, 'App CSS must keep the mobile media query');
const mobileCss = appCss.slice(mobileMediaStart);
for (const fragment of [
  '#file-sheet',
  'min-width: 0',
  'max-width: 100vw',
  'overflow-x: hidden',
  '.fg-hero',
  'grid-template-columns: 1fr',
  '.fg-link-grid',
]) {
  assert(mobileCss.includes(fragment), `File-tab mobile CSS is missing: ${fragment}`);
}

for (const [path, content] of [
  ['public/faq.html', faqHtml],
  ['public/refresheet-static.css', staticCss],
  ['style.css', appCss],
  ['src/worker/index.js', workerJs],
  ['src/layout/excelLayout.js', excelLayoutJs],
  ['docs/migrations/008_unlockables_referrals.sql', unlockMigration],
  ['HANDOFF.md', handoff],
]) {
  assert(!content.includes('\uFFFD'), `${path} contains Unicode replacement characters`);
}

console.log('static content guard ok');
