bash <<'EOF'
echo "🔧  正在安装 Claude MCP 服务器 (最新版本)…"

# 顺序思考 — Claude 的链式思考引擎
claude mcp add sequential-thinking -s user \
  -- npx -y @modelcontextprotocol/server-sequential-thinking || true

# 文件系统 — 允许 Claude 访问本地文件夹
claude mcp add filesystem -s user \
  -- npx -y @modelcontextprotocol/server-filesystem \
     ~/Documents ~/Desktop ~/Downloads ~/Projects || true

# Playwright — 现代多浏览器自动化
claude mcp add playwright -s user \
  -- npx -y @playwright/mcp-server || true

# Puppeteer — 仅限 Chrome (已弃用，但仍然有效)
claude mcp add puppeteer -s user \
  -- npx -y @modelcontextprotocol/server-puppeteer || true

# Fetch — 简单的 HTTP GET/POST
claude mcp add fetch -s user \
  -- npx -y @kazuph/mcp-fetch || true

# 浏览器工具 — DevTools 日志、截图等。
claude mcp add browser-tools -s user \
  -- npx -y @agentdeskai/browser-tools-mcp || true

echo "--------------------------------------------------"
echo "✅  MCP 注册完成。"
echo ""
echo "🔴  要启用浏览器工具，请在*第二个*终端中运行此命令并保持打开状态："
echo "    npx -y @agentdeskai/browser-tools-server"
echo "--------------------------------------------------"
claude mcp list
EOF

