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

for (const [path, content] of [
  ['public/faq.html', faqHtml],
  ['public/refresheet-static.css', staticCss],
]) {
  assert(!content.includes('\uFFFD'), `${path} contains Unicode replacement characters`);
}

console.log('static content guard ok');
