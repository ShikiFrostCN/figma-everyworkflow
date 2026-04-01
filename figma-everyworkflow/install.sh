#!/usr/bin/env bash
# ============================================================
#  figma-everyworkflow 一键安装脚本
#  One-Click Installer for figma-everyworkflow
#
#  作者 Author: shiki
#  项目 Project: https://github.com/shiki/figma-everyworkflow
#  支持系统 Supports: macOS, Linux
# ============================================================

set -euo pipefail

# ── 颜色 Colors ──────────────────────────────────────────────
RESET="\033[0m"
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"

# ── 工具函数 Helpers ─────────────────────────────────────────
info()    { echo -e "${CYAN}${BOLD}[figma-everyworkflow]${RESET} $*"; }
success() { echo -e "${GREEN}${BOLD}✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}${BOLD}⚠${RESET}  $*"; }
error()   { echo -e "${RED}${BOLD}✗${RESET}  $*" >&2; }
step()    { echo -e "\n${BLUE}${BOLD}▸ $*${RESET}"; }

# ── Banner ───────────────────────────────────────────────────
echo ""
echo -e "${CYAN}${BOLD}"
echo "  ███████╗██╗ ██████╗ ███╗   ███╗ █████╗ "
echo "  ██╔════╝██║██╔════╝ ████╗ ████║██╔══██╗"
echo "  █████╗  ██║██║  ███╗██╔████╔██║███████║"
echo "  ██╔══╝  ██║██║   ██║██║╚██╔╝██║██╔══██║"
echo "  ██║     ██║╚██████╔╝██║ ╚═╝ ██║██║  ██║"
echo "  ╚═╝     ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝"
echo ""
echo "       figma-everyworkflow installer"
echo "       by shiki  |  github.com/shiki"
echo -e "${RESET}"

# ── 检测操作系统 Detect OS ───────────────────────────────────
step "检测运行环境 Detecting environment..."
OS="$(uname -s)"
case "$OS" in
  Darwin) info "检测到 macOS / macOS detected" ;;
  Linux)  info "检测到 Linux / Linux detected" ;;
  *)      error "不支持的操作系统: $OS / Unsupported OS: $OS"; exit 1 ;;
esac

# ── 检测编辑器 Detect Editor ─────────────────────────────────
step "检测已安装的编辑器 Detecting installed editors..."

EDITORS_FOUND=()
CURSOR_CONFIG=""
VSCODE_CONFIG=""

# Cursor
if command -v cursor &>/dev/null || [ -d "$HOME/.cursor" ]; then
  EDITORS_FOUND+=("cursor")
  if [[ "$OS" == "Darwin" ]]; then
    CURSOR_CONFIG="$HOME/Library/Application Support/Cursor/User/globalStorage/cursor.mcp/mcp.json"
    CURSOR_SETTINGS="$HOME/Library/Application Support/Cursor/User/settings.json"
  else
    CURSOR_CONFIG="$HOME/.config/cursor/User/globalStorage/cursor.mcp/mcp.json"
    CURSOR_SETTINGS="$HOME/.config/cursor/User/settings.json"
  fi
  success "Cursor 已检测到 / Cursor detected"
fi

# VS Code
if command -v code &>/dev/null || [ -d "$HOME/.vscode" ]; then
  EDITORS_FOUND+=("vscode")
  if [[ "$OS" == "Darwin" ]]; then
    VSCODE_CONFIG="$HOME/Library/Application Support/Code/User/.mcp.json"
  else
    VSCODE_CONFIG="$HOME/.config/Code/User/.mcp.json"
  fi
  success "VS Code 已检测到 / VS Code detected"
fi

if [ ${#EDITORS_FOUND[@]} -eq 0 ]; then
  warn "未检测到支持的编辑器，将仅生成配置文件。"
  warn "No supported editor detected. Config files will be generated only."
fi

# ── 检测依赖 Check Dependencies ──────────────────────────────
step "检查依赖 Checking dependencies..."

check_cmd() {
  if command -v "$1" &>/dev/null; then
    success "$1 已安装 / $1 found ($(command -v "$1"))"
    return 0
  else
    warn "$1 未安装 / $1 not found"
    return 1
  fi
}

check_cmd "git" || true
check_cmd "curl" || true
check_cmd "node" || true

# ── MCP 配置内容 MCP Config Content ─────────────────────────
MCP_CONFIG='{
  "mcpServers": {
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}'

# ── 安装到 Cursor ─────────────────────────────────────────────
install_cursor() {
  step "配置 Cursor MCP / Configuring Cursor MCP..."
  local config_dir
  config_dir="$(dirname "$CURSOR_CONFIG")"

  mkdir -p "$config_dir"

  if [ -f "$CURSOR_CONFIG" ]; then
    cp "$CURSOR_CONFIG" "${CURSOR_CONFIG}.backup.$(date +%Y%m%d%H%M%S)"
    info "已备份原配置 / Original config backed up"

    # 尝试合并 — 若已存在 figma 条目则跳过
    if grep -q '"figma"' "$CURSOR_CONFIG" 2>/dev/null; then
      warn "Figma MCP 已在 Cursor 中配置，跳过 / Figma MCP already configured in Cursor, skipping"
      return 0
    fi

    # 简单追加合并（使用 node 合并 JSON）
    if command -v node &>/dev/null; then
      node -e "
        const fs = require('fs');
        const existing = JSON.parse(fs.readFileSync('$CURSOR_CONFIG', 'utf8'));
        const addition = { mcpServers: { figma: { url: 'https://mcp.figma.com/mcp' } } };
        existing.mcpServers = Object.assign({}, existing.mcpServers || {}, addition.mcpServers);
        fs.writeFileSync('$CURSOR_CONFIG', JSON.stringify(existing, null, 2));
      " && success "已合并到现有 Cursor 配置 / Merged into existing Cursor config"
      return 0
    fi
  fi

  echo "$MCP_CONFIG" > "$CURSOR_CONFIG"
  success "Cursor MCP 配置已写入 / Cursor MCP config written: $CURSOR_CONFIG"
}

# ── 安装到 VS Code ────────────────────────────────────────────
install_vscode() {
  step "配置 VS Code MCP / Configuring VS Code MCP..."
  local ws_mcp="./.mcp.json"

  if [ -f "$ws_mcp" ]; then
    warn ".mcp.json 已存在于当前目录 / .mcp.json already exists in current directory"
  else
    echo '{
  "servers": {
    "figma": {
      "type": "http",
      "url": "https://mcp.figma.com/mcp"
    }
  }
}' > "$ws_mcp"
    success "VS Code .mcp.json 已生成 / VS Code .mcp.json generated: $ws_mcp"
  fi
}

# ── 复制 Skills 文件 Copy Skills ──────────────────────────────
install_skills() {
  step "安装 Agent Skills / Installing Agent Skills..."

  local skills_src
  skills_src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"

  if [ ! -d "$skills_src" ]; then
    warn "Skills 目录不存在，跳过 / Skills directory not found, skipping"
    return 0
  fi

  # Cursor skills
  if [[ " ${EDITORS_FOUND[*]} " == *" cursor "* ]]; then
    local cursor_skills
    if [[ "$OS" == "Darwin" ]]; then
      cursor_skills="$HOME/.cursor/skills"
    else
      cursor_skills="$HOME/.cursor/skills"
    fi
    mkdir -p "$cursor_skills"
    cp -r "$skills_src"/. "$cursor_skills/figma-everyworkflow/"
    success "Skills 已安装到 Cursor / Skills installed to Cursor: $cursor_skills/figma-everyworkflow"
  fi
}

# ── 生成本地 .mcp.json ────────────────────────────────────────
generate_local_config() {
  step "生成本地 MCP 配置 / Generating local MCP config..."
  local dest="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.mcp.json"
  if [ ! -f "$dest" ]; then
    echo "$MCP_CONFIG" > "$dest"
    success "本地 .mcp.json 已生成 / Local .mcp.json generated"
  else
    info "本地 .mcp.json 已存在 / Local .mcp.json already exists"
  fi
}

# ── 执行安装 Run Installation ────────────────────────────────
for editor in "${EDITORS_FOUND[@]:-}"; do
  case "$editor" in
    cursor) install_cursor ;;
    vscode) install_vscode ;;
  esac
done

install_skills
generate_local_config

# ── 验证提示 Verification Tips ───────────────────────────────
step "安装完成！Installation Complete!"
echo ""
echo -e "${GREEN}${BOLD}下一步 Next Steps:${RESET}"
echo ""
echo -e "  ${BOLD}1.${RESET} 重启你的编辑器 / Restart your editor"
echo -e "  ${BOLD}2.${RESET} 在聊天框中输入以下内容验证 / Verify by typing in chat:"
echo -e "       ${CYAN}#get_design_context${RESET}"
echo ""
echo -e "  ${BOLD}3.${RESET} 在 Figma 中复制一个帧的链接，然后对 AI 说："
echo -e "     Copy a frame link in Figma, then tell your AI:"
echo -e "       ${CYAN}\"帮我实现这个 Figma 设计: [粘贴链接]\"${RESET}"
echo -e "       ${CYAN}\"Implement this Figma design: [paste link]\"${RESET}"
echo ""
echo -e "  ${BOLD}4.${RESET} 查看完整使用指南 / See full guide:"
echo -e "       ${CYAN}https://github.com/shiki/figma-everyworkflow${RESET}"
echo ""
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${BOLD}figma-everyworkflow${RESET} by ${CYAN}shiki${RESET} — 让 Figma 融入每个工作流"
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
