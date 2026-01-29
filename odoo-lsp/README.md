# odoo-lsp — Claude Code Plugin

Integrates the [odoo-ls](https://github.com/odoo/odoo-ls) language server with Claude Code, giving Claude real-time Odoo-aware diagnostics, completions, and code navigation.

## What Claude Gains

- **Diagnostics**: Model/field validation, import resolution, manifest issues, XML validation (~50 Odoo-specific error codes)
- **Code navigation**: Go-to-definition for models, fields, compute methods; find-references; hover info; workspace symbol search (including XML IDs)
- **Completions**: Model names, fields, method signatures, `self.env["model"]` patterns

## Prerequisites

### 1. Build and install `odoo_ls_server`

The server is a Rust binary. You need [Cargo](https://rustup.rs/) installed.

```bash
git clone https://github.com/odoo/odoo-ls.git
cd odoo-ls/server
cargo build --release
cp target/release/odoo_ls_server ~/.local/bin/
```

Ensure `~/.local/bin` is in your `PATH`.

### 2. Local Odoo source checkout

odoo-ls needs access to Odoo source code on disk. Clone the version matching your project:

```bash
# Official Odoo repository
git clone --depth 1 --branch 17.0 https://github.com/odoo/odoo.git /path/to/odoo

# Or OCA/OCB (community backports, often used by OpenSPP)
git clone --depth 1 --branch 19.0 https://github.com/OCA/OCB.git /path/to/odoo
```

Either source works — odoo-ls only needs a checkout that contains the `odoo/` directory and `addons/`.

### 3. Create `odools.toml` in your project root

The server reads its configuration from `odools.toml` files found in the workspace directory and its parents. Create one at the root of your Odoo project:

```toml
[[config]]
name = "default"
odoo_path = "/path/to/odoo"
addons_paths = [
    "/path/to/odoo/addons",
    "/path/to/your/custom/addons",
]
python_path = "python3"
```

#### Configuration fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Profile name (defaults to `"default"`) |
| `odoo_path` | Yes | Path to Odoo source root (contains `odoo/` directory) |
| `addons_paths` | Yes | Paths to addons directories |
| `python_path` | No | Python interpreter (defaults to auto-detected `python3`) |
| `additional_stubs` | No | Extra type stub directories |
| `diag_missing_imports` | No | Missing import diagnostics: `"all"`, `"only_odoo"`, or `"none"` |

Paths can be absolute or relative to the `odools.toml` file location.

## Plugin Structure

```
odoo-lsp/
├── .claude-plugin/
│   └── plugin.json        # Plugin metadata
├── .lsp.json              # LSP server configuration
├── hooks/
│   ├── hooks.json         # Session start hook
│   └── check-odoo-ls.sh   # Checks for odoo_ls_server in PATH
└── README.md
```

## How It Works

- **`.lsp.json`** tells Claude Code to launch `odoo_ls_server` via stdio for `.py`, `.xml`, and `.csv` files
- **`hooks/check-odoo-ls.sh`** runs on session start and warns if the binary is missing (does not block the session)
- The server auto-discovers `odools.toml` from the workspace root and parent directories
- No `initializationOptions` are needed — configuration is filesystem-based

## Troubleshooting

**"odoo_ls_server not found"** — Build and install the binary per the prerequisites above.

**No diagnostics appearing** — Verify `odools.toml` exists in your project root (or a parent directory) and that `odoo_path` points to a valid Odoo source checkout.

**Server crashes on startup** — Check that `odoo_path` contains the `odoo/` subdirectory (not just `addons/`). Run `odoo_ls_server --parse -c /path/to/ocb` to test parsing outside Claude Code.

**Wrong Odoo version** — Make sure your local Odoo checkout matches your project's version. odoo-ls validates against the source it's pointed at.
