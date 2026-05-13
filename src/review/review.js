import { refreshAuthState } from '../auth/authState.js';
import { goToLogin, showLoginPopup } from '../ui/loginPopup.js';

let initialized = false;
let loadedOnce = false;
let comments = [];
let replyParentId = null;

export function initReview() {
    if (initialized) return;
    initialized = true;

    const input = document.getElementById('review-comment-input');
    const submit = document.getElementById('review-comment-submit');
    const feedback = document.getElementById('review-feedback-open');

    input?.addEventListener('input', () => updateCounter(input, 'review-comment-counter', 100));
    submit?.addEventListener('click', submitComment);
    feedback?.addEventListener('click', openFeedbackModal);

    document.addEventListener('refresheet:review-open', async () => {
        await loadComments();
        scrollCommentsToBottom();
    });
}

async function loadComments() {
    const list = document.getElementById('review-comments-list');
    if (!list) return;
    list.innerHTML = '<div class="review-loading">댓글을 불러오는 중...</div>';
    try {
        const res = await fetch('/api/review/comments', { credentials: 'include' });
        const data = await res.json();
        comments = data.comments || [];
        renderComments();
        if (!loadedOnce) {
            loadedOnce = true;
            scrollCommentsToBottom();
        }
    } catch {
        list.innerHTML = '<div class="review-empty">댓글을 불러오지 못했습니다.</div>';
    }
}

function renderComments() {
    const list = document.getElementById('review-comments-list');
    if (!list) return;
    list.innerHTML = '';

    const top = comments.filter(comment => !comment.parent_comment_id);
    const replies = comments.reduce((map, comment) => {
        if (comment.parent_comment_id) {
            const arr = map.get(comment.parent_comment_id) || [];
            arr.push(comment);
            map.set(comment.parent_comment_id, arr);
        }
        return map;
    }, new Map());

    if (!comments.length) {
        list.append(el('div', 'review-empty', '아직 댓글이 없습니다.'));
        return;
    }

    top.forEach(comment => {
        list.append(renderComment(comment, false));
        // 부모가 inactive 유저이면 top에 없으므로 replies도 자동으로 미렌더링됨
        (replies.get(comment.id) || []).forEach(reply => {
            list.append(renderComment(reply, true));
        });
    });
}

function renderComment(comment, isReply) {
    const item = el('div', `review-comment${isReply ? ' is-reply' : ''}${comment.is_deleted ? ' is-deleted' : ''}`);
    item.dataset.id = comment.id;

    const body = el('div', 'review-comment-body');
    const text = el('div', 'review-comment-text');

    if (!comment.is_deleted) {
        const authorWrap = el('span', 'review-author');
        authorWrap.append(el('span', 'review-author-name', comment.employee_name || '사용자'));
        if (comment.company) {
            authorWrap.append(el('span', 'review-author-company', comment.company));
        }
        text.append(authorWrap);
        text.append(document.createTextNode(` ${comment.body}`));
    } else {
        text.textContent = '삭제된 댓글입니다';
    }

    const meta = el('div', 'review-comment-meta');
    meta.append(el('span', '', formatDateTime(comment.created_at)));
    if (!comment.is_deleted) {
        const like = button('review-action', `좋아요 ${comment.like_count || 0}`);
        like.classList.toggle('liked', comment.liked_by_me);
        like.addEventListener('click', () => toggleLike(comment.id));
        meta.append(like);

        if (!isReply) {
            const reply = button('review-action', '답글 달기');
            reply.addEventListener('click', () => setReplyTarget(comment));
            meta.append(reply);
        }
        if (comment.can_edit) {
            const edit = button('review-action', '수정');
            edit.addEventListener('click', () => startEdit(item, comment));
            meta.append(edit);
        }
        if (comment.can_delete) {
            const del = button('review-action', '삭제');
            del.addEventListener('click', () => deleteComment(comment.id));
            meta.append(del);
        }
    }

    body.append(text, meta);
    item.append(body);
    return item;
}

function setReplyTarget(comment) {
    replyParentId = comment.id;
    const input = document.getElementById('review-comment-input');
    const name = comment.employee_name || '댓글';
    input.placeholder = `${name}님에게 답글 달기...`;
    input.focus();
}

async function submitComment() {
    const input = document.getElementById('review-comment-input');
    const body = input?.value.trim() || '';
    if (!body) return showMessage('댓글을 입력해주세요');
    if (body.length > 100) return showMessage('댓글은 100자까지 입력할 수 있습니다');
    if (!(await ensureReadyToPost())) return;

    const res = await fetch('/api/review/comments', {
        method: 'POST',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ body, parent_comment_id: replyParentId }),
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) return handleApiError(data);

    input.value = '';
    input.placeholder = '댓글 추가...';
    replyParentId = null;
    updateCounter(input, 'review-comment-counter', 100);
    await loadComments();
    scrollCommentsToBottom();
}

function startEdit(item, comment) {
    const body = item.querySelector('.review-comment-body');
    body.innerHTML = '';
    const textarea = document.createElement('textarea');
    textarea.className = 'review-edit-input';
    textarea.maxLength = 100;
    textarea.value = comment.body;
    const actions = el('div', 'review-edit-actions');
    const save = button('review-action strong', '저장');
    const cancel = button('review-action', '취소');
    save.addEventListener('click', async () => {
        const next = textarea.value.trim();
        if (!next) return showMessage('댓글을 입력해주세요');
        const res = await fetch(`/api/review/comments/${comment.id}`, {
            method: 'PATCH',
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ body: next }),
        });
        const data = await res.json().catch(() => ({}));
        if (!res.ok) return handleApiError(data);
        await loadComments();
    });
    cancel.addEventListener('click', renderComments);
    actions.append(save, cancel);
    body.append(textarea, actions);
    textarea.focus();
}

async function deleteComment(id) {
    const res = await fetch(`/api/review/comments/${id}`, {
        method: 'DELETE',
        credentials: 'include',
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) return handleApiError(data);
    await loadComments();
}

async function toggleLike(id) {
    if (!(await ensureReadyToPost({ requireEmployeeName: false }))) return;
    const res = await fetch(`/api/review/comments/${id}/like`, {
        method: 'POST',
        credentials: 'include',
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) return handleApiError(data);
    await loadComments();
}

function openFeedbackModal() {
    ensureReadyToPost().then(ok => {
        if (!ok) return;
        const modal = buildModal('운영자에게 의견 보내기');
        const textarea = document.createElement('textarea');
        textarea.className = 'review-feedback-input';
        textarea.maxLength = 200;
        textarea.placeholder = '운영자에게 전달할 의견을 입력해주세요.';
        const counter = el('div', 'review-modal-counter', '0/200');
        textarea.addEventListener('input', () => {
            counter.textContent = `${textarea.value.length}/200`;
        });
        const submit = button('modal-btn retry', '접수');
        submit.addEventListener('click', async () => {
            const body = textarea.value.trim();
            if (!body) return showModalMessage(modal, '의견을 입력해주세요');
            const res = await fetch('/api/review/feedback', {
                method: 'POST',
                credentials: 'include',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ body }),
            });
            const data = await res.json().catch(() => ({}));
            if (!res.ok) return showModalMessage(modal, data.message || '접수하지 못했습니다');
            modal.remove();
            openSuccessModal();
        });
        modal.querySelector('.review-modal-body').append(textarea, counter, el('div', 'review-modal-message'), submit);
        document.body.appendChild(modal);
        textarea.focus();
    });
}

function openSuccessModal() {
    const modal = buildModal('확인');
    modal.querySelector('.review-modal-body').append(
        el('div', 'review-success-text', '정상 접수되었습니다. 감사합니다'),
        button('modal-btn retry review-success-ok', '확인')
    );
    modal.querySelector('.review-success-ok').addEventListener('click', () => modal.remove());
    document.body.appendChild(modal);
}

async function ensureReadyToPost({ requireEmployeeName = true } = {}) {
    const auth = window.refresheetAuth;
    if (!auth?.authenticated) {
        showLoginPopup({
            message: '검토 기능은 로그인 후 이용할 수 있습니다.',
            onLogin: goToLogin,
            onSkip: () => {},
        });
        return false;
    }
    if (requireEmployeeName && !auth.employee_name) {
        const { showAlertPopup, showUserSettings } = window.loginPopupModule || {};
        if (showAlertPopup) {
            showAlertPopup('댓글을 작성하려면 사원명을 먼저 설정해주세요.', () => {
                if (showUserSettings) showUserSettings();
            });
        }
        return false;
    }
    return true;
}

function buildModal(title) {
    const overlay = el('div', 'modal-overlay review-modal-overlay');
    const modal = el('div', 'excel-modal review-modal');
    const header = el('div', 'modal-header');
    header.append(el('span', '', title));
    const close = el('span', 'modal-close', '×');
    close.addEventListener('click', () => overlay.remove());
    header.append(close);
    modal.append(header, el('div', 'review-modal-body'));
    overlay.append(modal);
    return overlay;
}

function showModalMessage(modal, text) {
    const target = modal.querySelector('.review-modal-message');
    if (target) target.textContent = text;
}

function handleApiError(data) {
    if (data.error === 'employee_name_required' || data.error === 'nickname_required') {
        const { showAlertPopup, showUserSettings } = window.loginPopupModule || {};
        if (showAlertPopup) {
            showAlertPopup('댓글을 작성하려면 사원명을 먼저 설정해주세요.', () => {
                if (showUserSettings) showUserSettings();
            });
        }
        return;
    }
    showMessage(data.message || (data.error === 'daily_limit' ? '하루 등록 가능 댓글은 3개입니다' : '처리하지 못했습니다'));
}

function showMessage(text) {
    const message = document.getElementById('review-message');
    if (!message) return;
    message.textContent = text;
    clearTimeout(showMessage.timer);
    showMessage.timer = setTimeout(() => {
        message.textContent = '';
    }, 2400);
}

function updateCounter(input, id, max) {
    const counter = document.getElementById(id);
    if (counter) counter.textContent = `${input.value.length}/${max}`;
}

function scrollCommentsToBottom() {
    requestAnimationFrame(() => {
        const list = document.getElementById('review-comments-list');
        if (list) list.scrollTop = list.scrollHeight;
    });
}

function formatDateTime(value) {
    if (!value) return '';
    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return value;
    return date.toLocaleString('ko-KR', {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
    });
}

function button(className, text) {
    const node = document.createElement('button');
    node.type = 'button';
    node.className = className;
    node.textContent = text;
    return node;
}

function el(tag, className = '', text = '') {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (text) node.textContent = text;
    return node;
}
