# Claude Analysis: UI Alignment Drift

## Impact Analysis
- **Scope**: SDK and 2048 game sheets (sidebars and game grids).
- **Symptom**: Cumulative misalignment where table rows in the sidebar drift away from the background grid (Row 12).
- **Risk**: Low risk of layout breakage; high visual impact on "Excel disguise".

## Target Files
- style.css
- src/games/game2048/ui.js
- src/games/sudoku/sudoku.js

## Root Cause Hypothesis
1. **Inconsistent Row Heights**: Base Excel grid uses 22px (21px content + 1px border), but game grids (Sudoku/2048) use 25px.
2. **Cumulative Drift**: .fake-table-cell.note uses height: auto and line-height: 22px. With a 1px border, the total height becomes 23px, causing a 1px drift per row compared to the 22px background grid.
3. **Border Box vs Content Box**: Borders are adding to the height instead of being contained within it.

## Implementation Plan
1. **Standardize Heights**: Set all row heights (SDK/2048) to 22px to match the base grid.
2. **Box-Shadow Borders**: Switch sidebar table borders from border to box-shadow: inset to keep height at exactly 22px.
3. **Explicit Height**: Force height: 22px on all fake-table cells that aren't intended to wrap.

## Codex Execution Prompt
### #EXEC#
Task: Fix UI alignment drift in SDK and 2048 sheets.

Instructions:
1. In style.css:
   - Find .sudoku and .g2048 grid-template-rows and change 25px to 22px.
   - Find .fake-table-cell and .fake-table-cell.note. Ensure height or min-height is exactly 22px.
   - Update table borders to use box-shadow: inset 0 0 0 1px #e1e1e1 instead of border: 1px solid #e1e1e1 to prevent pixel expansion.
   - Adjust .row-headers and .column-headers to strictly adhere to the 22px/80px grid.
2. In src/games/game2048/ui.js:
   - Update any hardcoded cell height variables (likely 25px) to 22px.
3. Verify:
   - Check SDK Difficulty Selector at Row 12; it should sit perfectly on the row line.
   - Ensure the total height of sidebar tables is a multiple of 22px.