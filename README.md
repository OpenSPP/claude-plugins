# Claude Code Plugins

Claude Code plugins maintained by OpenSPP for Odoo development workflows.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [odoo-lsp](./odoo-lsp/) | Odoo language server integration via [odoo-ls](https://github.com/odoo/odoo-ls) |

## Installation

### Via marketplace (recommended)

Add the marketplace and install plugins by name:

```
/plugin marketplace add OpenSPP/claude-plugins
/plugin install odoo-lsp@openspp-plugins
```

To update plugins later:

```
/plugin marketplace update openspp-plugins
```

### Via project settings

Add the marketplace to your project's `.claude/settings.json` so team members are prompted to install automatically:

```json
{
  "extraKnownMarketplaces": {
    "openspp-plugins": {
      "source": {
        "source": "github",
        "repo": "OpenSPP/claude-plugins"
      }
    }
  },
  "enabledPlugins": {
    "odoo-lsp@openspp-plugins": true
  }
}
```

### Via local path

If you have this repo cloned locally:

```bash
claude --plugin-dir /path/to/claude-plugins/odoo-lsp
```
