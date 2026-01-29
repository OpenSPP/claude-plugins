#!/usr/bin/env bash
# Check if odoo-ls-server is available in PATH.
# Prints install instructions if missing; exits 0 either way
# so the session is not blocked.

if command -v odoo_ls_server &>/dev/null; then
    echo "odoo_ls_server found: $(command -v odoo_ls_server)"
    exit 0
fi

cat <<'EOF'
[odoo-lsp] odoo_ls_server not found in PATH.

To install, build from source:

  git clone https://github.com/odoo/odoo-ls.git
  cd odoo-ls/server
  cargo build --release
  cp target/release/odoo_ls_server ~/.local/bin/

Then ensure ~/.local/bin is in your PATH.

The plugin also requires an odools.toml config file in your Odoo
project root. See https://github.com/odoo/odoo-ls for details.
EOF

exit 0
