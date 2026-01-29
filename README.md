# Claude Code Plugins

Claude Code plugins maintained by OpenSPP for Odoo development workflows.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [odoo-lsp](./odoo-lsp/) | Odoo language server integration via [odoo-ls](https://github.com/odoo/odoo-ls) |

## Usage

Install a plugin by passing its directory to Claude Code:

```bash
claude --plugin-dir /path/to/claude-plugins/odoo-lsp
```

Or add it to your project's `.claude/settings.json`:

```json
{
  "plugins": [
    "/path/to/claude-plugins/odoo-lsp"
  ]
}
```
