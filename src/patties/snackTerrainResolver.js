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
    const petSize = controller?.config?.movement?.spriteSize || 32;
    const bounds = controller?.getLocalChartBounds?.() || {
        left: 0,
        top: 0,
        right: mapEl.clientWidth,
        bottom: mapEl.clientHeight,
    };
    const floorPetSurface = controller?.getChartSurfaces?.().find(s => s.kind === 'floor');
    const floorPetY = floorPetSurface?.y ?? Math.max(0, bounds.bottom - petSize - 16);
    const floorY = floorPetY + petSize;

    const surfaces = [{
        id: 'base_floor',
        kind: 'floor',
        minX: bounds.left + appleSize / 2,
        maxX: bounds.right - appleSize / 2,
        surfaceY: floorY,
        petY: floorPetY,
    }];

    const bars = controller?.getSortedBars?.() || [];
    bars.forEach((bar, index) => {
        if (bar.width <= 0 || bar.height <= 2) return;
        const petY = bar.top - petSize + 6;
        const heightFromFloor = Math.abs(petY - floorPetY);
        if (heightFromFloor > (controller.config?.movement?.maxBarHeightFromFloorPx || 132)) return;
        // 개별 bar가 아닌 pair 범위를 사용 (개별 bar가 너무 좁으면 appleSize/2 패딩으로 minX>maxX가 됨)
        const halfApple = appleSize / 2;
        const pairLeft = bar.pairLeft ?? bar.left;
        const pairWidth = bar.pairWidth ?? bar.width;
        const pairMinX = pairLeft + halfApple;
        const pairMaxX = pairLeft + pairWidth - halfApple;
        if (pairMaxX <= pairMinX) return;
        surfaces.push({
            id: `bar-${index}`,
            kind: 'bar',
            minX: pairMinX,
            maxX: pairMaxX,
            surfaceY: bar.top,
            petY,
        });
    });

    return surfaces;
}

export function resolveSnackLandingPoint({ controller, mapEl, dropX, dropY, appleSize }) {
    if (isSnackDebugEnabled()) console.log('[PattieSnack] snack dropStart:', { x: Math.round(dropX), y: Math.round(dropY) });
    const surfaces = getSolidSurfaces({ controller, mapEl, appleSize });
    const fallback = surfaces.find(s => s.kind === 'floor') || {
        id: 'base_floor',
        minX: appleSize / 2,
        maxX: (mapEl.clientWidth || 0) - appleSize / 2,
        surfaceY: (mapEl.clientHeight || appleSize) - 16,
        petY: (mapEl.clientHeight || appleSize) - appleSize - 16,
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
        y: surface.surfaceY - appleSize + 2,
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
