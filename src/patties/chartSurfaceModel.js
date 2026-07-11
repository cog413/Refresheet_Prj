const FLOOR_BOTTOM_INSET = 15;
const BAR_PET_FOOT_INSET = 4;
const FLOOR_APPLE_BOTTOM_INSET = 2;
const BAR_APPLE_BOTTOM_INSET = 6;

export function buildChartSurfaceModel({ controller, mapEl, appleSize = 24 } = {}) {
    const petSize = controller?.config?.movement?.spriteSize || 32;
    const bounds = controller?.getLocalChartBounds?.() || {
        left: 0,
        top: 0,
        right: mapEl?.clientWidth || 0,
        bottom: mapEl?.clientHeight || 0,
    };
    const floorSurfaceY = bounds.bottom - FLOOR_BOTTOM_INSET;
    const floorPetY = floorSurfaceY - petSize;
    const maxBarHeight = controller?.config?.movement?.maxBarHeightFromFloorPx || 160;
    const floor = {
        id: 'chart-floor',
        snackId: 'base_floor',
        kind: 'floor',
        minX: bounds.left + 14,
        maxX: bounds.right - petSize - 14,
        snackMinX: bounds.left + appleSize / 2,
        snackMaxX: bounds.right - appleSize / 2,
        surfaceY: floorSurfaceY,
        petY: floorPetY,
        appleY: floorSurfaceY - appleSize + FLOOR_APPLE_BOTTOM_INSET,
    };

    const groupedBars = controller?.getGroupedChartBars?.() || [];
    const bars = groupedBars.map((bar, index) => {
        const surfaceY = bar.top;
        return {
            id: `bar-${index}`,
            snackId: `bar-${index}`,
            kind: 'bar',
            minX: bar.left + 1,
            maxX: bar.left + bar.width - petSize - 1,
            snackMinX: bar.left + appleSize / 2,
            snackMaxX: bar.left + bar.width - appleSize / 2,
            surfaceY,
            petY: surfaceY - petSize + BAR_PET_FOOT_INSET,
            appleY: surfaceY - appleSize + BAR_APPLE_BOTTOM_INSET,
        };
    }).filter((surface) => {
        const heightFromFloor = Math.abs(surface.petY - floorPetY);
        return surface.maxX >= surface.minX
            && surface.snackMaxX > surface.snackMinX
            && heightFromFloor <= maxBarHeight;
    });

    return [floor, ...bars];
}
