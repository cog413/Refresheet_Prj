document.addEventListener('DOMContentLoaded', () => {
    const grid = document.getElementById('game2048-grid');
    const formulaInput = document.getElementById('formula-input');
    const currentCellBox = document.getElementById('current-cell');
    
    let board = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ];
    let score = 0;

    // Helper to convert row/col to Excel ref
    function getCellRef(row, col) {
        return String.fromCharCode(65 + col) + (row + 1);
    }

    // Initialize DOM cells
    const cells = [];
    for (let row = 0; row < 4; row++) {
        for (let col = 0; col < 4; col++) {
            const cell = document.createElement('div');
            cell.className = 'excel-cell';
            cell.dataset.row = row;
            cell.dataset.col = col;
            
            // Click to select
            cell.addEventListener('click', () => {
                document.querySelectorAll('.g2048 .excel-cell').forEach(c => c.classList.remove('selected'));
                cell.classList.add('selected');
                
                currentCellBox.textContent = getCellRef(row, col);
                formulaInput.value = cell.textContent || '';
            });

            grid.appendChild(cell);
            cells.push({ row, col, element: cell });
        }
    }

    function addRandomTile() {
        let emptyCells = [];
        for (let r = 0; r < 4; r++) {
            for (let c = 0; c < 4; c++) {
                if (board[r][c] === 0) emptyCells.push({r, c});
            }
        }
        if (emptyCells.length > 0) {
            const randomCell = emptyCells[Math.floor(Math.random() * emptyCells.length)];
            board[randomCell.r][randomCell.c] = Math.random() < 0.9 ? 2 : 4;
        }
    }

    function updateBoard() {
        cells.forEach(cellObj => {
            const val = board[cellObj.row][cellObj.col];
            const el = cellObj.element;
            
            // Clear old classes
            el.className = 'excel-cell';
            if (el.classList.contains('selected')) el.classList.add('selected');

            if (val !== 0) {
                el.textContent = val;
                el.classList.add(`val-${val}`);
            } else {
                el.textContent = '';
            }
        });

        // Update formula bar to show score masquerading as a formula
        if (document.getElementById('game2048-sheet').style.display !== 'none') {
            formulaInput.value = `=SUM(A1:D4)*${score}`;
        }
    }

    // Logic for sliding and merging
    function slide(row) {
        let arr = row.filter(val => val);
        let missing = 4 - arr.length;
        let zeros = Array(missing).fill(0);
        return arr.concat(zeros);
    }

    function combine(row) {
        for (let i = 0; i < 3; i++) {
            if (row[i] !== 0 && row[i] === row[i + 1]) {
                row[i] *= 2;
                score += row[i];
                row[i + 1] = 0;
            }
        }
        return row;
    }

    function operate(row) {
        row = slide(row);
        row = combine(row);
        row = slide(row);
        return row;
    }

    // Keydown for 2048
    document.addEventListener('keydown', (e) => {
        if (document.body.classList.contains('safe-mode')) return;
        if (document.getElementById('game2048-sheet').style.display === 'none') return;
        
        let moved = false;

        if (['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(e.key)) {
            e.preventDefault(); // Prevent scrolling
        }

        if (e.key === 'ArrowLeft') {
            for (let r = 0; r < 4; r++) {
                let row = board[r];
                let newRow = operate(row);
                if (row.toString() !== newRow.toString()) moved = true;
                board[r] = newRow;
            }
        } else if (e.key === 'ArrowRight') {
            for (let r = 0; r < 4; r++) {
                let row = board[r].slice().reverse();
                let newRow = operate(row);
                newRow.reverse();
                if (board[r].toString() !== newRow.toString()) moved = true;
                board[r] = newRow;
            }
        } else if (e.key === 'ArrowUp') {
            for (let c = 0; c < 4; c++) {
                let col = [board[0][c], board[1][c], board[2][c], board[3][c]];
                let newCol = operate(col);
                if (col.toString() !== newCol.toString()) moved = true;
                for (let r = 0; r < 4; r++) board[r][c] = newCol[r];
            }
        } else if (e.key === 'ArrowDown') {
            for (let c = 0; c < 4; c++) {
                let col = [board[0][c], board[1][c], board[2][c], board[3][c]].reverse();
                let newCol = operate(col);
                newCol.reverse();
                let oldCol = [board[0][c], board[1][c], board[2][c], board[3][c]];
                if (oldCol.toString() !== newCol.toString()) moved = true;
                for (let r = 0; r < 4; r++) board[r][c] = newCol[r];
            }
        }

        if (moved) {
            addRandomTile();
            updateBoard();
        }
    });

    // Start game
    addRandomTile();
    addRandomTile();
    updateBoard();
});
