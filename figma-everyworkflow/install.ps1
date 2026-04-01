# ============================================================
#  figma-everyworkflow Windows 一键安装脚本
#  One-Click Installer for figma-everyworkflow (Windows)
#
#  作者 Author: shiki
#  项目 Project: https://github.com/shiki/figma-everyworkflow
#  支持系统 Supports: Windows (PowerShell 5.1+)
# ============================================================

#Requires -Version 5.1
$ErrorActionPreference = "Stop"

# ── 颜色输出 Color Output ─────────────────────────────────────
function Write-Info    { param($msg) Write-Host "[figma-everyworkflow] $msg" -ForegroundColor Cyan }
function Write-Success { param($msg) Write-Host "✓  $msg" -ForegroundColor Green }
function Write-Warn    { param($msg) Write-Host "⚠  $msg" -ForegroundColor Yellow }
function Write-Err     { param($msg) Write-Host "✗  $msg" -ForegroundColor Red }
function Write-Step    { param($msg) Write-Host "`n▸ $msg" -ForegroundColor Blue }

# ── Banner ───────────────────────────────────────────────────
Write-Host ""
Write-Host "  figma-everyworkflow installer" -ForegroundColor Cyan
Write-Host "  by shiki  |  github.com/shiki" -ForegroundColor Cyan
Write-Host ""

# ── MCP 配置 MCP Config ───────────────────────────────────────
$McpConfig = @{
    mcpServers = @{
        figma = @{
            url = "https://mcp.figma.com/mcp"
        }
    }
} | ConvertTo-Json -Depth 4

# ── 检测编辑器 Detect Editors ────────────────────────────────
Write-Step "检测已安装的编辑器 Detecting installed editors..."

$EditorsFound = @()

# Cursor
$CursorPath = "$env:APPDATA\Cursor\User\globalStorage\cursor.mcp"
if (Test-Path "$env:APPDATA\Cursor") {
    $EditorsFound += "cursor"
    Write-Success "Cursor 已检测到 / Cursor detected"
}

# VS Code
if (Test-Path "$env:APPDATA\Code") {
    $EditorsFound += "vscode"
    Write-Success "VS Code 已检测到 / VS Code detected"
}

if ($EditorsFound.Count -eq 0) {
    Write-Warn "未检测到支持的编辑器，将仅生成配置文件。"
    Write-Warn "No supported editor detected. Config files will be generated only."
}

# ── 安装到 Cursor ─────────────────────────────────────────────
function Install-Cursor {
    Write-Step "配置 Cursor MCP / Configuring Cursor MCP..."

    $ConfigDir = "$env:APPDATA\Cursor\User\globalStorage\cursor.mcp"
    $ConfigFile = "$ConfigDir\mcp.json"

    if (-not (Test-Path $ConfigDir)) {
        New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null
    }

    if (Test-Path $ConfigFile) {
        $BackupFile = "$ConfigFile.backup.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $ConfigFile $BackupFile
        Write-Info "已备份原配置 / Original config backed up: $BackupFile"

        $Existing = Get-Content $ConfigFile -Raw | ConvertFrom-Json
        if ($Existing.mcpServers.figma) {
            Write-Warn "Figma MCP 已在 Cursor 中配置，跳过 / Already configured, skipping"
            return
        }

        if (-not $Existing.mcpServers) {
            $Existing | Add-Member -MemberType NoteProperty -Name mcpServers -Value @{}
        }
        $Existing.mcpServers | Add-Member -MemberType NoteProperty -Name figma -Value @{ url = "https://mcp.figma.com/mcp" }
        $Existing | ConvertTo-Json -Depth 4 | Set-Content $ConfigFile -Encoding UTF8
        Write-Success "已合并到现有 Cursor 配置 / Merged into existing Cursor config"
    } else {
        $McpConfig | Set-Content $ConfigFile -Encoding UTF8
        Write-Success "Cursor MCP 配置已写入 / Cursor MCP config written: $ConfigFile"
    }
}

# ── 安装到 VS Code ────────────────────────────────────────────
function Install-VSCode {
    Write-Step "配置 VS Code MCP / Configuring VS Code MCP..."

    $VsCodeMcp = ".\.mcp.json"
    if (Test-Path $VsCodeMcp) {
        Write-Warn ".mcp.json 已存在 / .mcp.json already exists"
    } else {
        @{
            servers = @{
                figma = @{
                    type = "http"
                    url  = "https://mcp.figma.com/mcp"
                }
            }
        } | ConvertTo-Json -Depth 4 | Set-Content $VsCodeMcp -Encoding UTF8
        Write-Success "VS Code .mcp.json 已生成 / VS Code .mcp.json generated"
    }
}

# ── 生成本地配置 Generate Local Config ───────────────────────
function Install-LocalConfig {
    Write-Step "生成本地 MCP 配置 / Generating local MCP config..."
    $LocalConfig = ".\.mcp.json"
    if (-not (Test-Path $LocalConfig)) {
        $McpConfig | Set-Content $LocalConfig -Encoding UTF8
        Write-Success "本地 .mcp.json 已生成 / Local .mcp.json generated"
    } else {
        Write-Info "本地 .mcp.json 已存在 / Local .mcp.json already exists"
    }
}

# ── 执行安装 Run Installation ────────────────────────────────
foreach ($editor in $EditorsFound) {
    switch ($editor) {
        "cursor" { Install-Cursor }
        "vscode" { Install-VSCode }
    }
}

Install-LocalConfig

# ── 完成提示 Completion ───────────────────────────────────────
Write-Step "安装完成！Installation Complete!"
Write-Host ""
Write-Host "下一步 Next Steps:" -ForegroundColor Green
Write-Host ""
Write-Host "  1. 重启你的编辑器 / Restart your editor"
Write-Host "  2. 在聊天框中输入以下内容验证 / Verify by typing:"
Write-Host "       #get_design_context" -ForegroundColor Cyan
Write-Host ""
Write-Host "  3. 在 Figma 中复制帧链接，然后说 / Copy a Figma frame link and say:"
Write-Host '       "帮我实现这个 Figma 设计: [粘贴链接]"' -ForegroundColor Cyan
Write-Host ""
Write-Host "  4. 完整使用指南 / Full guide:"
Write-Host "       https://github.com/shiki/figma-everyworkflow" -ForegroundColor Cyan
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host "  figma-everyworkflow by shiki — 让 Figma 融入每个工作流" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
Write-Host ""
