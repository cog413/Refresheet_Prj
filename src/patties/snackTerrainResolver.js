import { buildChartSurfaceModel } from './chartSurfaceModel.js';

export function getMapLocalPointFromMouse(event, mapEl) {
    const rect = mapEl.getBoundingClientRect();
    return {
        x: event.clientX - rect.left,
        y: event.clientY - rect.top,
        width: rect.width,
        height: rect.height,
    };
}

export function clampPointToMap(point, mapEl, size) {
    const width = mapEl.clientWidth || point.width || 0;
    const height = mapEl.clientHeight || point.height || 0;
    const half = size / 2;
    return {
        x: clamp(point.x, half, Math.max(half, width - half)),
        y: clamp(point.y, half, Math.max(half, height - half)),
    };
}

export function getSolidSurfaces({ controller, mapEl, appleSize }) {
    return buildChartSurfaceModel({ controller, mapEl, appleSize }).map(surface => ({
        id: surface.snackId,
        kind: surface.kind,
        minX: surface.snackMinX,
        maxX: surface.snackMaxX,
        surfaceY: surface.surfaceY,
        petY: surface.petY,
        appleY: surface.appleY,
    }));
}

export function resolveSnackLandingPoint({ controller, mapEl, dropX, dropY, appleSize }) {
    if (isSnackDebugEnabled()) console.log('[PattieSnack] snack dropStart:', { x: Math.round(dropX), y: Math.round(dropY) });
    const surfaces = getSolidSurfaces({ controller, mapEl, appleSize });
    const fallback = surfaces.find(s => s.kind === 'floor') || {
        id: 'base_floor',
        minX: appleSize / 2,
        maxX: (mapEl.clientWidth || 0) - appleSize / 2,
        surfaceY: (mapEl.clientHeight || appleSize) - 15,
        petY: (mapEl.clientHeight || appleSize) - appleSize - 15,
        appleY: (mapEl.clientHeight || appleSize) - appleSize - 13,
    };
    const candidates = surfaces
        .filter(surface => dropX >= surface.minX && dropX <= surface.maxX)
        .filter(surface => surface.surfaceY >= dropY)
        .sort((a, b) => a.surfaceY - b.surfaceY);
    const surface = candidates[0] || fallback;
    if (isSnackDebugEnabled()) console.log('[PattieSnack] selectedSurface:', { id: surface.id, y: Math.round(surface.surfaceY) });
    const centerX = clamp(dropX, surface.minX, surface.maxX);
    const point = {
        x: centerX - appleSize / 2,
        y: surface.appleY ?? surface.surfaceY - appleSize + 2,
        centerX,
        centerY: surface.surfaceY - appleSize / 2,
        surface,
    };
    if (isSnackDebugEnabled()) console.log('[PattieSnack] landingPoint:', { x: Math.round(point.x), y: Math.round(point.y) });
    debugSnackSurface(point);
    return point;
}

export function debugSnackSurface(point) {
    if (!isSnackDebugEnabled()) return;
    console.debug('[PattieSnack] landing', {
        landedOn: point.surface?.id,
        kind: point.surface?.kind,
        x: Math.round(point.x),
        y: Math.round(point.y),
        surfaceY: Math.round(point.surface?.surfaceY || 0),
    });
}

export function isSnackDebugEnabled() {
    try {
        return localStorage.getItem('refresheetSnackDebug') === '1';
    } catch {
        return false;
    }
}

function clamp(value, min, max) {
    return Math.max(min, Math.min(max, value));
}
