// @ts-check
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
    testDir: './tests',
    timeout: 45_000,
    reporter: [['list'], ['html', { open: 'never', outputFolder: 'test-results/report' }]],
    outputDir: 'test-results/artifacts',
    use: {
        baseURL: 'https://sub.refresheet-prj.pages.dev',
        screenshot: 'on',
        video: 'retain-on-failure',
        trace: 'retain-on-failure',
    },
    projects: [
        { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    ],
});
