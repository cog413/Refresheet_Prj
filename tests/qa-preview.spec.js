// @ts-check
/**
 * QA Preview E2E tests — runs against sub.refresheet-prj.pages.dev only.
 * Requires DEV_LOGIN_TOKEN environment variable.
 *
 * Run:
 *   DEV_LOGIN_TOKEN=<token> npx playwright test
 *   # Windows PowerShell:
 *   $env:DEV_LOGIN_TOKEN="<token>"; npx playwright test
 */
import { test, expect } from '@playwright/test';

const PREVIEW_URL = 'https://sub.refresheet-prj.pages.dev';
const TOKEN = process.env.DEV_LOGIN_TOKEN ?? '';

test.beforeAll(() => {
    if (!TOKEN) {
        throw new Error(
            'DEV_LOGIN_TOKEN is not set.\n' +
            'PowerShell: $env:DEV_LOGIN_TOKEN="<token>"; npx playwright test'
        );
    }
});

// --- Test 1: Preview host reachable ---
test('1. preview host is reachable', async ({ page }) => {
    const res = await page.goto(PREVIEW_URL);
    expect(res?.status()).toBeLessThan(500);
    await page.screenshot({ path: 'test-results/01-landing.png' });
});

// --- Test 2: /api/dev-login issues session cookie ---
test('2. /api/dev-login returns 200 and sets session cookie', async ({ page }) => {
    const res = await page.request.post(`${PREVIEW_URL}/api/dev-login`, {
        headers: { Authorization: `Bearer ${TOKEN}` },
    });
    expect(res.status(), 'dev-login status').toBe(200);

    const body = await res.json();
    expect(body.ok, 'response body ok').toBe(true);

    const cookies = await page.context().cookies(PREVIEW_URL);
    const session = cookies.find(c => c.name === 'refresheet_session');
    expect(session, 'session cookie missing').toBeDefined();
    expect(session?.value.length, 'session cookie too short').toBeGreaterThan(10);
});

// --- Tests 3–6: Login → Dashboard → Screenshot → Console/Network audit ---
test('3-6. dashboard after dev-login: screenshot + console + network audit', async ({ page }) => {
    // Login — page.request shares cookie jar with page
    const loginRes = await page.request.post(`${PREVIEW_URL}/api/dev-login`, {
        headers: { Authorization: `Bearer ${TOKEN}` },
    });
    expect(loginRes.ok(), 'dev-login failed').toBeTruthy();

    const consoleErrors = /** @type {string[]} */ ([]);
    const failedRequests = /** @type {{ url: string; error: string | undefined }[]} */ ([]);

    page.on('console', msg => {
        if (msg.type() === 'error') consoleErrors.push(msg.text());
    });
    page.on('requestfailed', req => {
        failedRequests.push({ url: req.url(), error: req.failure()?.errorText });
    });

    // 3. Dashboard navigation
    await page.goto(PREVIEW_URL);
    await page.waitForLoadState('networkidle');

    // 4. Screenshot — full dashboard
    await page.screenshot({ path: 'test-results/03-dashboard.png', fullPage: true });

    // Pattie/chart area
    const chartEl = page.locator('#mp-chart').first();
    if (await chartEl.isVisible()) {
        await chartEl.screenshot({ path: 'test-results/04-pattie-chart.png' });
    }

    // Management sheet tab (if present)
    const mgmtTab = page.locator('.tab', { hasText: '관리시트' }).first();
    if (await mgmtTab.isVisible()) {
        await mgmtTab.click();
        await page.waitForLoadState('networkidle');
        await page.screenshot({ path: 'test-results/04-minime-sheet.png', fullPage: true });
    }

    // 5. Console error output
    console.log('\n=== Console Errors ===');
    if (consoleErrors.length === 0) {
        console.log('  (none)');
    } else {
        consoleErrors.forEach(e => console.error(' ✗', e));
    }

    // 6. Failed request output
    console.log('\n=== Failed Network Requests ===');
    const nonTrivialFailures = failedRequests.filter(r =>
        !r.url.includes('favicon') && !r.url.includes('analytics')
    );
    if (nonTrivialFailures.length === 0) {
        console.log('  (none)');
    } else {
        nonTrivialFailures.forEach(r => console.error(' ✗', r.url, '—', r.error));
    }

    expect(consoleErrors, 'console errors detected').toHaveLength(0);
    expect(nonTrivialFailures, 'network failures detected').toHaveLength(0);
});
