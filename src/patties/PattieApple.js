import { SnackState } from './snackInteractionState.js';
import {
    clampPointToMap,
    getMapLocalPointFromMouse,
    resolveSnackLandingPoint,
} from './snackTerrainResolver.js';
import { getSnackApproachTarget } from './snackCollision.js';
import { SNACK_ANIMATION_MS } from './snackAnimations.js';

const APPLE_IDLE_SRC = '/public/assets/apple/apple_idle..png';
const APPLE_SIZE = 24;

export class PattieApple {
    constructor({ mapEl, roamingController, onFed }) {
        this.mapEl = mapEl;
        this.ctrl = roamingController;
        this.onFed = onFed;

        this.state = SnackState.IDLE;
        this.feedMode = false;
        this.processing = false;
        this.previewEl = null;
        this.landedEl = null;
        this.popEl = null;
        this.appleState = null;
        this.timers = new Set();

        this._boundMouseMove = this._onMouseMove.bind(this);
        this._boundClick = this._onClick.bind(this);
        this._boundContextMenu = this._onContextMenu.bind(this);
        this._boundKeyDown = this._onKeyDown.bind(this);
    }

    startFeedMode() {
        if (this.state !== SnackState.IDLE || this.processing) return false;
        this.transition(SnackState.AIMING_SNACK);
        this.feedMode = true;
        this._createPreview();
        document.addEventListener('mousemove', this._boundMouseMove);
        this.mapEl.addEventListener('click', this._boundClick);
        this.mapEl.addEventListener('contextmenu', this._boundContextMenu);
        document.addEventListener('keydown', this._boundKeyDown);
        this.mapEl.style.cursor = 'none';
        return true;
    }

    stopFeedMode() {
        if (this.state !== SnackState.AIMING_SNACK) return;
        this.cancel();
    }

    cancel() {
        this.transition(SnackState.CANCELLED);
        this.feedMode = false;
        this.processing = false;
        this._removePreview();
        this._removeApple();
        this._removeListeners();
        this.ctrl?.clearSnackMovement?.();
        this.transition(SnackState.IDLE);
        this._resetFeedButton();
    }

    _createPreview() {
        if (this.previewEl) return;
        const el = document.createElement('img');
        el.src = APPLE_IDLE_SRC;
        el.className = 'pattie-apple-cursor';
        el.width = APPLE_SIZE;
        el.height = APPLE_SIZE;
        this.mapEl.appendChild(el);
        this.previewEl = el;

        const rect = this.mapEl.getBoundingClientRect();
        this._setPreviewPoint({ x: rect.width / 2, y: rect.height / 2 });
    }

    _removePreview() {
        this.previewEl?.remove();
        this.previewEl = null;
    }

    _removeApple() {
        this.landedEl?.remove();
        this.popEl?.remove();
        this.landedEl = null;
        this.popEl = null;
        this.appleState = null;
    }

    _removeListeners() {
        document.removeEventListener('mousemove', this._boundMouseMove);
        this.mapEl.removeEventListener('click', this._boundClick);
        this.mapEl.removeEventListener('contextmenu', this._boundContextMenu);
        document.removeEventListener('keydown', this._boundKeyDown);
        this.mapEl.style.cursor = '';
    }

    _onMouseMove(event) {
        if (this.state !== SnackState.AIMING_SNACK || !this.previewEl) return;
        const point = getMapLocalPointFromMouse(event, this.mapEl);
        const clamped = clampPointToMap(point, this.mapEl, APPLE_SIZE);
        this._setPreviewPoint(clamped);
    }

    _setPreviewPoint(point) {
        if (!this.previewEl) return;
        const x = point.x - APPLE_SIZE / 2;
        const y = point.y - APPLE_SIZE / 2;
        this.previewEl.style.left = `${Math.round(x)}px`;
        this.previewEl.style.top = `${Math.round(y)}px`;
        this.lastAimPoint = { x: point.x, y: point.y };
    }

    _onClick(event) {
        if (this.state !== SnackState.AIMING_SNACK || this.processing) return;
        if (event.target.closest('.mp-map-actions')) return;
        if (!this.mapEl.contains(event.target)) return;
        event.preventDefault();
        event.stopPropagation();

        const point = clampPointToMap(getMapLocalPointFromMouse(event, this.mapEl), this.mapEl, APPLE_SIZE);
        this._dropSnack(point);
    }

    _onContextMenu(event) {
        if (this.state !== SnackState.AIMING_SNACK) return;
        event.preventDefault();
        this.cancel();
    }

    _onKeyDown(event) {
        if (event.key === 'Escape' && this.state === SnackState.AIMING_SNACK) {
            event.preventDefault();
            this.cancel();
        }
    }

    _dropSnack(point) {
        this.transition(SnackState.DROPPING_SNACK);
        this.feedMode = false;
        this.processing = true;
        this._removePreview();
        this._removeListeners();

        const landing = resolveSnackLandingPoint({
            controller: this.ctrl,
            mapEl: this.mapEl,
            dropX: point.x,
            dropY: point.y,
            appleSize: APPLE_SIZE,
        });
        this.appleState = {
            x: landing.x,
            y: landing.y,
            size: APPLE_SIZE,
            surface: landing.surface,
        };

        const el = document.createElement('img');
        el.src = APPLE_IDLE_SRC;
        el.className = 'pattie-apple-landed pattie-apple-landed--falling';
        el.width = APPLE_SIZE;
        el.height = APPLE_SIZE;
        // 클릭한 위치에서 낙하 시작: 프리뷰 위치와 일치시킴
        const dropStartTop = Math.round(point.y - APPLE_SIZE / 2);
        el.style.left = `${Math.round(landing.x)}px`;
        el.style.top = `${dropStartTop}px`;
        this.mapEl.appendChild(el);
        this.landedEl = el;

        // 낙하 거리 = 클릭 위치 → 착지 위치 (위로 이동하는 경우 MIN 적용)
        const fallDistance = Math.max(0, landing.y - dropStartTop);
        const fallDuration = Math.max(
            SNACK_ANIMATION_MS.DROP_MIN,
            fallDistance * SNACK_ANIMATION_MS.DROP_PER_PX,
        );
        el.style.transitionDuration = `${fallDuration}ms`;
        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                if (this.landedEl) this.landedEl.style.top = `${Math.round(landing.y)}px`;
            });
        });

        this._setTimer(() => this._onLanded(), fallDuration + 40);
    }

    async _onLanded() {
        if (!this.landedEl || !this.appleState) return;
        this.transition(SnackState.SNACK_LANDED);
        this.landedEl.classList.remove('pattie-apple-landed--falling');
        this.landedEl.classList.add('pattie-apple-landed--settled');

        this.transition(SnackState.PET_SURPRISE);
        await this.ctrl.holdSnackAnimation('surprise', SNACK_ANIMATION_MS.SURPRISE);

        if (this.state !== SnackState.PET_SURPRISE || !this.appleState) {
            this.ctrl.actionLock = false;
            this.ctrl.setMode?.('idle');
            return;
        }

        this.ctrl.actionLock = false;
        this._movePetToSnack();
    }

    _movePetToSnack() {
        this.transition(SnackState.PET_MOVING_TO_SNACK);
        const ok = this.ctrl?.moveToSnack?.(this.appleState, {
            onArrive: () => this._beginEating(),
            onFail: reason => this._fail(`간식 위치로 이동하지 못했어요 (${reason})`),
        });
        if (!ok) this._fail('간식 위치로 이동하지 못했어요');
    }

    async _beginEating() {
        if (!this.appleState || !this.landedEl) return;
        this.transition(SnackState.PET_EATING_SNACK);
        const approach = getSnackApproachTarget(this.ctrl.getPetState(), this.appleState);
        this.ctrl.freezeForSnack(approach.direction);

        const fed = await this.onFed?.();
        if (!fed?.ok) {
            this._fail(fed?.message || '사과를 사용할 수 없어요');
            return;
        }

        const landedLeft = this.landedEl.style.left;
        const landedTop = this.landedEl.style.top;
        this.landedEl.remove();
        this.landedEl = null;

        await this._playApplePop(landedLeft, landedTop);

        this.transition(SnackState.PET_HAPPY_AFTER_SNACK);
        const happyDuration = this._happyDurationMs();
        for (let i = 0; i < 2; i += 1) {
            await this.ctrl.holdSnackAnimation('happy', happyDuration, {
                direction: approach.direction,
            });
        }

        this.transition(SnackState.DONE);
        this.processing = false;
        this.ctrl.completeSnackSequence();
        this._removeApple();
        this.transition(SnackState.IDLE);
        this._resetFeedButton();
    }

    // apple_pop.png: 450×66, 7프레임(64×64 content), sourcePadX/Y=1
    // PattieSprite와 동일한 방식으로 background-position 스텝핑
    _playApplePop(left, top) {
        const FRAME_COUNT = 7;
        const FRAME_W = 64;
        const FRAME_H = 64;
        const PAD_X = 1;
        const PAD_Y = 1;
        const IMAGE_W = 450;
        const IMAGE_H = 66;
        const FRAME_MS = 300;
        const scale = APPLE_SIZE / FRAME_W; // 24/64 = 0.375

        return new Promise(resolve => {
            const outer = document.createElement('div');
            outer.className = 'pattie-apple-pop';
            outer.style.left = left;
            outer.style.top = top;
            outer.style.width = `${APPLE_SIZE}px`;
            outer.style.height = `${APPLE_SIZE}px`;

            const inner = document.createElement('div');
            inner.style.cssText = [
                `width:${FRAME_W}px`,
                `height:${FRAME_H}px`,
                `transform-origin:0 0`,
                `transform:scale(${scale})`,
                `background-image:url('/public/assets/apple/apple_pop.png')`,
                `background-size:${IMAGE_W}px ${IMAGE_H}px`,
                `background-repeat:no-repeat`,
                `image-rendering:pixelated`,
            ].join(';');
            outer.appendChild(inner);
            this.mapEl.appendChild(outer);
            this.popEl = outer;

            let frame = 0;
            const applyFrame = () => {
                inner.style.backgroundPosition = `-${PAD_X + frame * FRAME_W}px -${PAD_Y}px`;
            };
            applyFrame();

            const advance = () => {
                if (!this.popEl) return; // cancel됨
                frame += 1;
                if (frame < FRAME_COUNT) {
                    applyFrame();
                    this._setTimer(advance, FRAME_MS);
                } else {
                    outer.remove();
                    if (this.popEl === outer) this.popEl = null;
                    resolve();
                }
            };
            this._setTimer(advance, FRAME_MS);
        });
    }

    _happyDurationMs() {
        const anim = this.ctrl?.sprite?.animation;
        if (anim?.frameCount && anim?.frameDurationMs && this.ctrl?.mode === 'happy') {
            return anim.frameCount * anim.frameDurationMs;
        }
        return 3600;
    }

    _fail(message) {
        console.warn('[PattieSnack]', message);
        this.processing = false;
        this.ctrl?.clearSnackMovement?.();
        this._removeApple();
        this.transition(SnackState.IDLE);
        this._resetFeedButton();
        if (message) alert(message);
    }

    _setTimer(fn, ms) {
        const id = setTimeout(() => {
            this.timers.delete(id);
            fn();
        }, ms);
        this.timers.add(id);
        return id;
    }

    _clearTimers() {
        for (const id of this.timers) clearTimeout(id);
        this.timers.clear();
    }

    _resetFeedButton() {
        const btn = document.getElementById('mp-feed-btn');
        if (!btn) return;
        btn.textContent = '간식주기';
        btn.classList.remove('mp-feed-btn--active');
    }

    transition(next) {
        this.state = next;
        if (next === SnackState.IDLE || next === SnackState.CANCELLED || next === SnackState.DONE) {
            this.feedMode = false;
        }
        if (this._debugEnabled()) console.debug('[PattieSnack] state', next);
    }

    _debugEnabled() {
        try {
            return localStorage.getItem('refresheetSnackDebug') === '1';
        } catch {
            return false;
        }
    }

    destroy() {
        this._clearTimers();
        this._removeListeners();
        this._removePreview();
        this._removeApple();
        this.ctrl?.clearSnackMovement?.();
        this.state = SnackState.IDLE;
        this.processing = false;
    }
}
