#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "Checking and installing applications..."

# Update apt once at the beginning
echo "Updating package lists..."
sudo apt update -y
sleep 3

# Brave Browser
command -v brave-browser &> /dev/null || { echo "Installing Brave..."; sudo apt install curl -y && sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list && sudo apt update -y && sudo apt install brave-browser -y; }
sleep 3

# VS Code
command -v code &> /dev/null || { echo "Installing VS Code..."; sudo apt install wget gpg -y && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null && rm -f packages.microsoft.gpg && sudo apt update -y && sudo apt install code -y; }
sleep 3

# Zsh
command -v zsh &> /dev/null || { echo "Installing Zsh..."; sudo apt install zsh -y && echo "$USER" | chsh -s $(which zsh); }
sleep 3

# Oh-My-Zsh
[ -d "$HOME/.oh-my-zsh" ] || { command -v zsh &> /dev/null && { echo "Installing Oh-My-Zsh..."; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; } || echo "Zsh required for Oh-My-Zsh"; }
sleep 3

# 7-Zip
command -v 7z &> /dev/null || { echo "Installing 7-Zip..."; sudo apt install p7zip-full p7zip-rar -y; }
sleep 3

# Rust
command -v rustc &> /dev/null || { echo "Installing Rust..."; curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source "$HOME/.cargo/env"; }
sleep 3

# Koompi-CLI
command -v koompi-cli &> /dev/null || { echo "Installing koompi-cli..."; mkdir -p $HOME/koompi-linux-application-install/koompi-tmp-install && cd $HOME/koompi-linux-application-install/koompi-tmp-install/ && git clone https://github.com/koompi/koompi-cli.git && cd $HOME/koompi-linux-application-install/koompi-tmp-install/koompi-cli && cargo build --release; }
sleep 3

echo "Done!"