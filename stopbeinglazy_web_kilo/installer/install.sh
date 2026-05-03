#!/usr/bin/env bash
# SmartWeb Mode Agent Installer — Bash (macOS / Linux)
# Installs the SmartWeb Mode agent into your Kilo Code configuration.
# Usage: ./install.sh [--global] [--project /path/to/project]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AGENT_SOURCE="$PROJECT_ROOT/.kilo/agent/smartweb.md"

GLOBAL=false
TARGET_PROJECT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global) GLOBAL=true; shift ;;
    --project) TARGET_PROJECT="$2"; shift 2 ;;
    *) echo "[ERROR] Unknown option: $1"; exit 1 ;;
  esac
done

if [[ ! -f "$AGENT_SOURCE" ]]; then
  echo -e "\033[31m[ERROR] Agent file not found: $AGENT_SOURCE\033[0m"
  exit 1
fi

# ─── Determine install target ──────────────────────────────────────────

if [[ -n "$TARGET_PROJECT" ]]; then
  TARGET_DIR="$TARGET_PROJECT/.kilo/agent"
  TARGET_TYPE="project ($TARGET_PROJECT)"
elif $GLOBAL; then
  TARGET_DIR="$HOME/.config/kilo/agent"
  TARGET_TYPE="global ($HOME/.config/kilo)"
else
  # Auto-detect: prefer project-level if in a git repo
  GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
  if [[ -n "$GIT_ROOT" ]]; then
    TARGET_DIR="$GIT_ROOT/.kilo/agent"
    TARGET_TYPE="project ($GIT_ROOT)"
  else
    TARGET_DIR="$HOME/.config/kilo/agent"
    TARGET_TYPE="global ($HOME/.config/kilo)"
  fi
fi

TARGET_FILE="$TARGET_DIR/smartweb.md"

echo ""
echo -e "\033[36m╔══════════════════════════════════════════╗"
echo -e "║  SmartWeb Mode Agent Installer v6.2.0   ║"
echo -e "╚══════════════════════════════════════════╝\033[0m"
echo ""
echo "Source : $AGENT_SOURCE"
echo "Target : $TARGET_DIR  ($TARGET_TYPE)"
echo ""

# Confirm
read -r -p "Proceed with installation? [Y/n] " CONFIRM
if [[ "$CONFIRM" != "" && "$CONFIRM" != "Y" && "$CONFIRM" != "y" ]]; then
  echo -e "\033[33mInstallation cancelled.\033[0m"
  exit 0
fi

# ─── Backup existing agent ─────────────────────────────────────────────

if [[ -f "$TARGET_FILE" ]]; then
  BACKUP="$TARGET_FILE.bak.$(date +%Y%m%d%H%M%S)"
  cp "$TARGET_FILE" "$BACKUP"
  echo -e "\033[33m[BACKUP] Existing agent saved to: $BACKUP\033[0m"
fi

# ─── Copy agent ────────────────────────────────────────────────────────

mkdir -p "$TARGET_DIR"
cp "$AGENT_SOURCE" "$TARGET_FILE"

echo -e "\033[32m[SUCCESS] SmartWeb Mode agent installed!"
echo "         $TARGET_FILE\033[0m"
echo ""
echo "The SmartWeb Mode will activate on your next session."

# ─── Verify kilo.json ──────────────────────────────────────────────────

JSON_P="$TARGET_DIR/../kilo.json"
JSON_C="$TARGET_DIR/../kilo.jsonc"
if [[ -f "$JSON_P" ]]; then echo -e "\n\033[36m[INFO] Existing config: $JSON_P\033[0m"; fi
if [[ -f "$JSON_C" ]]; then echo -e "\033[36m[INFO] Existing config: $JSON_C\033[0m"; fi
if [[ ! -f "$JSON_P" && ! -f "$JSON_C" ]]; then
  echo -e "\n\033[36m[TIP] Create $(dirname "$TARGET_DIR")/kilo.json:\033[0m"
  echo '      { "agent": { "smartweb": { "file": ".kilo/agent/smartweb.md", "mode": "primary" } } }'
fi

echo ""
