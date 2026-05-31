export function initExcelLayout() {
    // 1. Generate Column Headers (A to Z, AA, AB...)
    const colHeaders = document.getElementById('col-headers');
    if (colHeaders) {
        for (let i = 0; i < 50; i++) {
            const header = document.createElement('div');
            header.className = 'col-header';
            let name = '';
            let temp = i;
            while (temp >= 0) {
                name = String.fromCharCode(65 + (temp % 26)) + name;
                temp = Math.floor(temp / 26) - 1;
            }
            header.textContent = name;
            colHeaders.appendChild(header);
        }
    }

    // 2. Generate Row Headers — enough to fill viewport, not a fixed 100
    const rowHeaders = document.getElementById('row-headers');
    if (rowHeaders) {
        const rowCount = Math.ceil(window.innerHeight / 22) + 4;
        for (let i = 1; i <= rowCount; i++) {
            const header = document.createElement('div');
            header.className = 'row-header';
            header.textContent = i;
            rowHeaders.appendChild(header);
        }
    }

    // Sync row/column header scroll with grid content
    const gridContent = document.getElementById('grid-content');
    if (gridContent && rowHeaders) {
        gridContent.addEventListener('scroll', () => {
            rowHeaders.scrollTop = gridContent.scrollTop;
            if (colHeaders) colHeaders.scrollLeft = gridContent.scrollLeft;
        });
    }

    initMobileSpreadsheetZoom();

    // 3. View tab toggles dark mode.
    const fileMenuTab = document.getElementById('file-menu-tab');
    const homeMenuTab = document.getElementById('home-menu-tab');
    const reviewMenuTab = document.getElementById('review-menu-tab');
    const viewMenuTab = document.getElementById('view-menu-tab');
    if (viewMenuTab) {
        viewMenuTab.addEventListener('click', () => {
            document.body.classList.toggle('dark-mode');
            viewMenuTab.classList.toggle('active', document.body.classList.contains('dark-mode'));
        });
    }

    // 4. Tab Switching logic
    const tabs = document.querySelectorAll('.tab:not(.add-tab)');
    const sheetViews = document.querySelectorAll('.sheet-view');
    refreshUnlockableTabs();
    document.addEventListener('refresheet:auth', refreshUnlockableTabs);
    
    tabs.forEach(tab => {
        tab.addEventListener('click', async () => {
            if (tab.dataset.unlockableKey && tab.dataset.locked === 'true') {
                showSheetLockToast(tab.dataset.lockReason || '잠금 해제 조건이 필요합니다');
                return;
            }
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            reviewMenuTab?.classList.remove('active');
            fileMenuTab?.classList.remove('active');
            showAppWorkspace();
            homeMenuTab?.classList.add('active');
            
            const targetSheet = tab.dataset.sheet;
            sheetViews.forEach(sheet => {
                if (sheet.id === `${targetSheet}-sheet`) {
                    sheet.style.display = 'block';
                    sheet.classList.add('active');
                } else {
                    sheet.style.display = 'none';
                    sheet.classList.remove('active');
                }
            });
            updateFormulaBarForSheet(targetSheet);
        });
    });

    if (homeMenuTab) {
        homeMenuTab.addEventListener('click', () => {
            document.querySelectorAll('.menu-tabs .menu-tab').forEach(t => {
                if (t !== viewMenuTab) t.classList.remove('active');
            });
            showAppWorkspace();
            homeMenuTab.classList.add('active');
            const activeTab = document.querySelector('.tab.active:not(.add-tab)');
            const targetSheet = activeTab?.dataset.sheet || 'readme';
            sheetViews.forEach(sheet => {
                const isTarget = sheet.id === `${targetSheet}-sheet`;
                sheet.style.display = isTarget ? 'block' : 'none';
                sheet.classList.toggle('active', isTarget);
            });
            updateFormulaBarForSheet(targetSheet);
            window.dispatchEvent(new Event('resize'));
        });
    }

    if (fileMenuTab) {
        fileMenuTab.addEventListener('click', () => {
            document.querySelectorAll('.menu-tabs .menu-tab').forEach((tab) => {
                if (tab !== viewMenuTab) tab.classList.remove('active');
            });
            fileMenuTab.classList.add('active');
            sheetViews.forEach(sheet => {
                const isFile = sheet.id === 'file-sheet';
                sheet.style.display = isFile ? 'block' : 'none';
                sheet.classList.toggle('active', isFile);
            });
            updateFormulaBarForSheet('file');
        });
    }

    if (reviewMenuTab) {
        reviewMenuTab.addEventListener('click', () => {
            document.querySelectorAll('.menu-tabs .menu-tab').forEach((tab) => {
                if (tab !== viewMenuTab) tab.classList.remove('active');
            });
            showAppWorkspace();
            reviewMenuTab.classList.add('active');
            sheetViews.forEach(sheet => {
                const isReview = sheet.id === 'review-sheet';
                sheet.style.display = isReview ? 'block' : 'none';
                sheet.classList.toggle('active', isReview);
            });
            document.dispatchEvent(new CustomEvent('refresheet:review-open'));
            updateFormulaBarForSheet('review');
        });
    }

    function updateFormulaBarForSheet(sheetId) {
        const formulaInput = document.getElementById('formula-input');
        const currentCell = document.getElementById('current-cell');
        if (!formulaInput || !currentCell) return;

        if (sheetId === 'readme') {
            formulaInput.value = '=DECLARATION("RIGHT_TO_REST")';
            currentCell.textContent = 'A1';
        } else if (sheetId === 'sudoku') {
            formulaInput.value = '=SUDOKU.INIT(A1:I9)';
            currentCell.textContent = 'A1';
        } else if (sheetId === 'newgame') {
            formulaInput.value = '=NEWGAME.LOCKED("친구추천 2명")';
            currentCell.textContent = 'A1';
        } else if (sheetId === 'game2048') {
            formulaInput.value = '=SUM(A1:D4)*2048';
            currentCell.textContent = 'A1';
        } else if (sheetId === 'mini-pet') {
            formulaInput.value = '=MANAGE.PET.STATUS(B2:F22)';
            currentCell.textContent = 'B2';
        } else if (sheetId === 'review') {
            formulaInput.value = '=REVIEW.COMMENTS(A1:A100)';
            currentCell.textContent = 'R1';
        } else if (sheetId === 'file') {
            formulaInput.value = '=GUIDE.INDEX("서비스_안내")';
            currentCell.textContent = 'A1';
        }
    }

    function showAppWorkspace() {
        // all chrome elements remain visible at all times — no-op
    }

    // Initialize formula bar for first sheet
    updateFormulaBarForSheet('readme');

    async function refreshUnlockableTabs() {
        try {
            const res = await fetch('/api/unlockables?item_type=sheet', { credentials: 'include' });
            if (!res.ok) return;
            const data = await res.json();
            const items = new Map((data.items || []).map(item => [item.item_key, item]));
            document.querySelectorAll('.tab[data-unlockable-key]').forEach(tab => {
                const item = items.get(tab.dataset.unlockableKey);
                const locked = Boolean(item?.is_locked);
                const reason = item?.lock_reason || tab.title || '';
                tab.dataset.locked = locked ? 'true' : 'false';
                tab.dataset.lockReason = reason;
                tab.classList.toggle('tab-locked', locked);
                tab.title = locked ? reason : '';
                const icon = tab.querySelector('.tab-lock-icon');
                if (icon) icon.style.display = locked ? 'inline' : 'none';
            });
        } catch {
            /* Keep default locked markup when offline. */
        }
    }

    function showSheetLockToast(message) {
        let toast = document.getElementById('sheet-lock-toast');
        if (!toast) {
            toast = document.createElement('div');
            toast.id = 'sheet-lock-toast';
            toast.className = 'sheet-lock-toast';
            document.body.appendChild(toast);
        }
        toast.textContent = message;
        toast.classList.add('visible');
        clearTimeout(showSheetLockToast.timer);
        showSheetLockToast.timer = setTimeout(() => {
            toast.classList.remove('visible');
        }, 2200);
    }

    function initMobileSpreadsheetZoom() {
        const container = document.querySelector('.spreadsheet-container');
        const gridContent = document.getElementById('grid-content');
        if (!container || !gridContent) return;

        const mobileQuery = window.matchMedia('(max-width: 768px)');
        const MIN_FALLBACK_SCALE = 0.72;
        const MAX_SCALE = 1.6;
        const STEP = 0.1;
        let scale = 1;
        let pinchStartDistance = 0;
        let pinchStartScale = 1;

        const controls = document.createElement('div');
        controls.className = 'mobile-zoom-controls';
        controls.innerHTML = `
            <button type="button" class="mobile-zoom-btn" data-zoom="out" aria-label="Zoom out">-</button>
            <span class="mobile-zoom-value">100%</span>
            <button type="button" class="mobile-zoom-btn" data-zoom="in" aria-label="Zoom in">+</button>
        `;
        container.appendChild(controls);

        controls.addEventListener('click', (event) => {
            const action = event.target?.dataset?.zoom;
            if (!action || !mobileQuery.matches) return;
            setScale(scale + (action === 'in' ? STEP : -STEP), true);
        });

        gridContent.addEventListener('touchstart', (event) => {
            if (!mobileQuery.matches || event.touches.length !== 2) return;
            pinchStartDistance = getTouchDistance(event.touches);
            pinchStartScale = scale;
        }, { passive: true });

        gridContent.addEventListener('touchmove', (event) => {
            if (!mobileQuery.matches || event.touches.length !== 2 || !pinchStartDistance) return;
            event.preventDefault();
            const nextDistance = getTouchDistance(event.touches);
            setScale(pinchStartScale * (nextDistance / pinchStartDistance), false);
        }, { passive: false });

        gridContent.addEventListener('touchend', (event) => {
            if (event.touches.length < 2) pinchStartDistance = 0;
        }, { passive: true });

        window.addEventListener('resize', () => {
            if (mobileQuery.matches) setScale(scale, false);
            else resetMobileZoom();
        });

        document.addEventListener('click', (event) => {
            const tab = event.target?.closest?.('.tab[data-sheet]');
            if (tab) setTimeout(() => setScale(scale, false), 0);
        });

        resetMobileZoom();

        function setScale(nextScale, centerViewport) {
            if (!mobileQuery.matches) {
                resetMobileZoom();
                return;
            }

            const previous = scale;
            scale = clamp(nextScale, getMinScale(), MAX_SCALE);
            applyScale();
            updateControls();

            if (centerViewport && previous !== scale) {
                const ratio = scale / previous;
                gridContent.scrollLeft = (gridContent.scrollLeft + gridContent.clientWidth / 2) * ratio - gridContent.clientWidth / 2;
                gridContent.scrollTop = (gridContent.scrollTop + gridContent.clientHeight / 2) * ratio - gridContent.clientHeight / 2;
            }
        }

        function resetMobileZoom() {
            if (mobileQuery.matches) {
                setScale(scale, false);
                return;
            }
            scale = 1;
            applyScale();
            updateControls();
        }

        function applyScale() {
            document.querySelectorAll('.mobile-zoom-content').forEach(el => {
                el.classList.remove('mobile-zoom-content');
                el.style.zoom = '';
            });

            if (!mobileQuery.matches || scale === 1) return;

            getZoomTargets().forEach(el => {
                el.classList.add('mobile-zoom-content');
                el.style.zoom = String(scale);
            });
        }

        function getZoomTargets() {
            const activeSheet = gridContent.querySelector('.sheet-view.active');
            if (!activeSheet) return [];
            return activeSheet.querySelectorAll([
                ':scope > .rm-sheet',
                ':scope > .review-sheet-wrap',
                ':scope > .mp-scene',
                ':scope > .fg-hero',
                ':scope > .fg-link-grid',
                ':scope .fake-dashboard',
                ':scope .game-grid'
            ].join(','));
        }

        function getMinScale() {
            const activeSheet = gridContent.querySelector('.sheet-view.active');
            if (!activeSheet) return MIN_FALLBACK_SCALE;

            const targets = Array.from(getZoomTargets());
            const contentWidth = Math.max(...targets.map(el => el.offsetLeft + el.scrollWidth), activeSheet.scrollWidth, 1);
            const contentHeight = Math.max(...targets.map(el => el.offsetTop + el.scrollHeight), activeSheet.scrollHeight, 1);
            const widthLimit = gridContent.clientWidth / contentWidth;
            const heightLimit = gridContent.clientHeight / contentHeight;
            return clamp(Math.max(MIN_FALLBACK_SCALE, Math.min(widthLimit, heightLimit, 1)), MIN_FALLBACK_SCALE, 1);
        }

        function updateControls() {
            controls.hidden = !mobileQuery.matches;
            controls.querySelector('.mobile-zoom-value').textContent = `${Math.round(scale * 100)}%`;
        }

        function getTouchDistance(touches) {
            const dx = touches[0].clientX - touches[1].clientX;
            const dy = touches[0].clientY - touches[1].clientY;
            return Math.hypot(dx, dy);
        }

        function clamp(value, min, max) {
            return Math.min(max, Math.max(min, value));
        }
    }
}
