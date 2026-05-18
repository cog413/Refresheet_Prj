import { SnackAction } from './snackInteractionState.js';
import { getSnackApproachTarget } from './snackCollision.js';

export function planPathToSnack(controller, appleState) {
    const petSize = controller.config?.movement?.spriteSize || 32;
    const maxJump = controller.config?.movement?.maxJumpDistancePx || 80;
    const surfaces = controller.getChartSurfaces().map(surface => ({
        id: surface.id === 'chart-floor' ? 'base_floor' : surface.id,
        kind: surface.kind,
        minX: surface.minX,
        maxX: surface.maxX,
        petY: surface.y,
    }));
    const snackSurface = {
        id: appleState.surface.id,
        kind: appleState.surface.kind,
        minX: appleState.surface.minX - appleState.size / 2,
        maxX: appleState.surface.maxX - appleState.size / 2,
        petY: appleState.surface.petY,
    };
    const allSurfaces = upsertSurface(surfaces, snackSurface);
    const currentSurface = findCurrentSurface(controller, allSurfaces);
    const target = getSnackApproachTarget({
        x: controller.x,
        y: controller.y,
        size: petSize,
    }, appleState);
    const targetSurface = allSurfaces.find(s => s.id === snackSurface.id) || snackSurface;
    const targetX = clamp(target.x, targetSurface.minX, targetSurface.maxX);

    if (!currentSurface) return { ok: false, actions: [], reason: 'no_current_surface' };
    const actions = [];

    if (currentSurface.id === targetSurface.id) {
        actions.push({ type: SnackAction.RUN_TO, x: targetX, y: targetSurface.petY, surface: targetSurface });
        actions.push({ type: SnackAction.TURN, direction: target.direction });
        return { ok: true, actions, target };
    }

    const launchX = clamp(targetX, currentSurface.minX, currentSurface.maxX);
    const landingX = clamp(launchX, targetSurface.minX, targetSurface.maxX);
    if (Math.abs(landingX - launchX) > maxJump) {
        const adjustedLaunchX = clamp(landingX + (landingX > controller.x ? -maxJump : maxJump), currentSurface.minX, currentSurface.maxX);
        if (Math.abs(landingX - adjustedLaunchX) > maxJump) {
            return { ok: false, actions: [], reason: 'jump_too_far' };
        }
        actions.push({ type: SnackAction.RUN_TO, x: adjustedLaunchX, y: currentSurface.petY, surface: currentSurface });
        actions.push({ type: SnackAction.JUMP_TO, x: landingX, y: targetSurface.petY, surface: targetSurface });
    } else {
        actions.push({ type: SnackAction.RUN_TO, x: launchX, y: currentSurface.petY, surface: currentSurface });
        actions.push({ type: SnackAction.JUMP_TO, x: landingX, y: targetSurface.petY, surface: targetSurface });
    }
    if (Math.abs(targetX - landingX) > 2) {
        actions.push({ type: SnackAction.RUN_TO, x: targetX, y: targetSurface.petY, surface: targetSurface });
    }
    actions.push({ type: SnackAction.TURN, direction: target.direction });
    return { ok: true, actions, target };
}

function findCurrentSurface(controller, surfaces) {
    const y = controller.y;
    const x = controller.x;
    return [...surfaces].sort((a, b) => {
        const ax = clamp(x, a.minX, a.maxX);
        const bx = clamp(x, b.minX, b.maxX);
        return Math.hypot(x - ax, y - a.petY) - Math.hypot(x - bx, y - b.petY);
    })[0] || null;
}

function upsertSurface(surfaces, surface) {
    const next = surfaces.filter(item => item.id !== surface.id);
    next.push(surface);
    return next;
}

function clamp(value, min, max) {
    return Math.max(min, Math.min(max, value));
}
