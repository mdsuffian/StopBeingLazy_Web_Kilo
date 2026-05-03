#!/usr/bin/env node
/**
 * SmartWeb Mode Agent Installer — Node.js (cross-platform)
 * Installs the SmartWeb Mode agent into your Kilo Code configuration.
 * Usage: node install.js [--global] [--project /path/to/project]
 */
const fs = require('fs');
const path = require('path');
const os = require('os');
const { execSync } = require('child_process');
const readline = require('readline');

// ─── Parse arguments ──────────────────────────────────────────────────

const args = process.argv.slice(2);
let globalInstall = false;
let projectPath = '';

for (let i = 0; i < args.length; i++) {
  if (args[i] === '--global') { globalInstall = true; }
  else if (args[i] === '--project' && args[i + 1]) { projectPath = args[++i]; }
  else if (args[i] === '--help' || args[i] === '-h') {
    console.log('Usage: node install.js [--global] [--project <path>]');
    console.log('  --global   Install to global Kilo config (~/.config/kilo)');
    console.log('  --project  Install to a specific project (.kilo/)');
    console.log('  (no flags) Auto-detect: git repo → project, else → global');
    process.exit(0);
  }
}

// ─── Determine paths ──────────────────────────────────────────────────

const scriptDir = __dirname;
const projectRoot = path.resolve(scriptDir, '..');
const agentSource = path.join(projectRoot, '.kilo', 'agent', 'smartweb.md');

if (!fs.existsSync(agentSource)) {
  console.error('\x1b[31m[ERROR] Agent file not found: %s\x1b[0m', agentSource);
  process.exit(1);
}

let targetDir;
let targetType;

if (projectPath) {
  targetDir = path.join(projectPath, '.kilo', 'agent');
  targetType = `project (${projectPath})`;
} else if (globalInstall) {
  targetDir = path.join(os.homedir(), '.config', 'kilo', 'agent');
  targetType = `global (${os.homedir()}/.config/kilo)`;
} else {
  // Auto-detect: use git root if available
  try {
    const gitRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf8' }).trim();
    if (gitRoot) {
      targetDir = path.join(gitRoot, '.kilo', 'agent');
      targetType = `project (${gitRoot})`;
    }
  } catch {
    targetDir = path.join(os.homedir(), '.config', 'kilo', 'agent');
    targetType = `global (${os.homedir()}/.config/kilo)`;
  }
}

const targetFile = path.join(targetDir, 'smartweb.md');

// ─── Display info ─────────────────────────────────────────────────────

console.log('');
console.log('\x1b[36m╔══════════════════════════════════════════╗');
console.log('║  SmartWeb Mode Agent Installer v6.2.0   ║');
console.log('╚══════════════════════════════════════════╝\x1b[0m');
console.log('');
console.log('Source : %s', agentSource);
console.log('Target : %s  (%s)', targetDir, targetType);
console.log('');

// ─── Confirm ──────────────────────────────────────────────────────────

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
rl.question('Proceed with installation? [Y/n] ', (answer) => {
  rl.close();

  if (answer !== '' && answer.toLowerCase() !== 'y') {
    console.log('\x1b[33mInstallation cancelled.\x1b[0m');
    process.exit(0);
  }

  // ─── Backup existing ────────────────────────────────────────────────

  if (fs.existsSync(targetFile)) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '');
    const backup = `${targetFile}.bak.${timestamp}`;
    fs.copyFileSync(targetFile, backup);
    console.log('\x1b[33m[BACKUP] Existing agent saved to: %s\x1b[0m', backup);
  }

  // ─── Copy agent ─────────────────────────────────────────────────────

  fs.mkdirSync(targetDir, { recursive: true });
  fs.copyFileSync(agentSource, targetFile);

  console.log('\x1b[32m[SUCCESS] SmartWeb Mode agent installed!');
  console.log('         %s\x1b[0m', targetFile);
  console.log('');
  console.log('The SmartWeb Mode will activate on your next session.');

  // ─── Verify config ──────────────────────────────────────────────────

  const parent = path.dirname(targetDir);
  const jsonFiles = [path.join(parent, 'kilo.json'), path.join(parent, 'kilo.jsonc')];
  const found = jsonFiles.find(f => fs.existsSync(f));

  if (found) {
    console.log('\n\x1b[36m[INFO] Existing config: %s\x1b[0m', found);
    console.log('       Ensure it references: "smartweb": { "file": ".kilo/agent/smartweb.md", "mode": "primary" }');
  } else {
    console.log('\n\x1b[36m[TIP] Create %s/kilo.json:\x1b[0m', parent);
    console.log('      { "agent": { "smartweb": { "file": ".kilo/agent/smartweb.md", "mode": "primary" } } }');
  }

  console.log('');
});
