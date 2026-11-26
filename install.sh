#!/usr/bin/env bash

# sysprobe Universal 1-Line Installer
# Author: Aman Kumar (@aman179102)
# Website: https://aman179102.netlify.app/
# Repo: https://github.com/aman179102/sysprobe

set -eo pipefail

C_RESET='\033[0m'
C_BOLD='\033[1m'
C_CYAN='\033[38;2;125;207;255m'
C_PURPLE='\033[38;2;187;154;247m'
C_GREEN='\033[38;2;158;206;106m'
C_YELLOW='\033[38;2;224;175;104m'
C_MUTED='\033[38;2;86;95;137m'
C_MAGENTA='\033[38;2;247;118;142m'

echo -e "${C_PURPLE}"
cat << 'EOF'
  ███████╗██╗   ██╗███████╗██████╗ ██████╗  ██████╗ ██████╗ ███████╗
  ██╔════╝╚██╗ ██╔╝██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝
  ███████╗ ╚████╔╝ ███████╗██████╔╝██████╔╝██║   ██║██████╔╝█████╗  
  ╚════██║  ╚██╔╝  ╚════██║██╔═══╝ ██╔══██╗██║   ██║██╔══██╗██╔══╝  
  ███████║   ██║   ███████║██║     ██║  ██║╚██████╔╝██████╔╝███████╗
  ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
EOF
echo -e "${C_CYAN}  ⚡ sysprobe: Universal Latency & Kernel Gateway Diagnostic Tool${C_RESET}"
echo -e "${C_MUTED}  Crafted by ${C_BOLD}Aman Kumar${C_RESET}${C_MUTED} (@aman179102) | https://aman179102.netlify.app${C_RESET}\n"

# Verify runtime dependencies
echo -e "${C_BOLD}🔍 Checking environment prerequisites...${C_RESET}"

if ! command -v node >/dev/null 2>&1; then
  echo -e "${C_MAGENTA}✘ Node.js is not installed.${C_RESET}"
  echo -e "  Please install Node.js (v18+) to run sysprobe:"
  echo -e "  ${C_YELLOW}https://nodejs.org/${C_RESET} or via nvm/apt/brew."
  exit 1
fi

NODE_VER=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VER" -lt 18 ]; then
  echo -e "${C_YELLOW}⚠ Warning: Node.js v18+ is recommended (found $(node -v)).${C_RESET}"
fi

INSTALL_DIR="${HOME}/.local/bin"
mkdir -p "${INSTALL_DIR}"

TARGET_BIN="${INSTALL_DIR}/sysprobe"
SOURCE_URL="https://raw.githubusercontent.com/aman179102/sysprobe/master/bin/sysprobe.js"

echo -e "⬇ Fetching latest sysprobe binary from GitHub..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "${SOURCE_URL}" -o "${TARGET_BIN}"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "${TARGET_BIN}" "${SOURCE_URL}"
else
  echo -e "${C_MAGENTA}✘ Error: Neither curl nor wget was found on host system.${C_RESET}"
  exit 1
fi

chmod +x "${TARGET_BIN}"

# Check PATH
PATH_UPDATED=0
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo -e "\n${C_YELLOW}ℹ Adding ${INSTALL_DIR} to your shell profile PATH...${C_RESET}"
  if [ -f "${HOME}/.bashrc" ]; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "${HOME}/.bashrc"
    PATH_UPDATED=1
  fi
  if [ -f "${HOME}/.zshrc" ]; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "${HOME}/.zshrc"
    PATH_UPDATED=1
  fi
fi

echo -e "\n${C_GREEN}${C_BOLD}✔ sysprobe installed successfully!${C_RESET} -> ${C_CYAN}${TARGET_BIN}${C_RESET}\n"

# Verify execution
"${TARGET_BIN}" version

echo -e "\n${C_BOLD}🚀 Quick Start Commands:${C_RESET}"
echo -e "  ${C_CYAN}sysprobe http https://aman179102.netlify.app/ -c 10 -n 100${C_RESET}"
echo -e "  ${C_CYAN}sysprobe kernel${C_RESET}"
echo -e "  ${C_CYAN}sysprobe --help${C_RESET}\n"

if [ "$PATH_UPDATED" -eq 1 ]; then
  echo -e "${C_MUTED}Note: Run ${C_BOLD}source ~/.bashrc${C_RESET}${C_MUTED} (or restart terminal) to activate sysprobe globally.${C_RESET}\n"
fi
