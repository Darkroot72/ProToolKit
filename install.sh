```bash
#!/usr/bin/env bash
set -euo pipefail


echo "Installing ProToolkit..."
mkdir -p "$HOME/ProToolkit"
cp -r . "$HOME/ProToolkit/"
chmod +x "$HOME/ProToolkit/protoolkit.sh"
chmod +x "$HOME/ProToolkit"/scans/*.sh
chmod +x "$HOME/ProToolkit"/export/*.sh


echo "Installed to $HOME/ProToolkit"
