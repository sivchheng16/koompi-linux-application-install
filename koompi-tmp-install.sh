#!/bin/bash

#Every install or update Doesn't input password every time

echo "All the script install application. Doesn't need to input password every time"
sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &
keep_sudo_alive_pid=$!

# Check for directory only
if [ -d "$HOME/koompi-tmp-install" ]; then
    rm -rf "$HOME/koompi-tmp-install"
fi

if [ ! -e "$HOME/koompi-tmp-install" ]; then
    # File or folder does not exist, perform an action
    echo "File or folder does not exist."
fi



# Install Rust 
echo "Next, install Rust, first"


#Check if Rush installed

if ! command -v rustc &> /dev/null; then
    echo "Rust is not installed. Installing now..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    . "$HOME/.cargo/env" 
else
    echo "Rust is already installed."
fi


sleep 5

# Install zsh and oh-my-zsh

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing now..."
    sudo pacman -Sy zsh
else 
    echo "zsh is already installed."
fi


sleep 5
# Check if Oh My Zsh is installed
if [ ! -d "$ZSH" ]; then
    echo "Oh My Zsh is not installed. Installing now..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    source ~/.zshrc
else 
    echo "oh-my-zsh is already installed"
fi


sleep 5
#Install zip
if ! command -v zip &> /dev/null; then
    echo "zip is not installed. Let's Install..."
    sudo pacman -Sy zip
else
    echo "Zip is already installed."
fi

sleep 5


#Install Telegram
if ! command -v telegram-desktop &> /dev/null; then
    echo "Telegram is not installed. Installing now..."
    sudo pacman -Sy telegram-desktop
else
    echo "Telegram is already installed."
fi


sleep 5

#Install libroffice

if ! command -v libreoffice &> /dev/null; then
    echo "LibreOffice is not installed. Installing now..."
    sudo pacman -Sy --noconfirm libreoffice-fresh
else
    echo "LibreOffice is already installed."
fi


sleep 5

# Install koompi-cli from Github

mkdir $HOME/koompi-tmp-install

cd koompi-tmp-install


git clone https://github.com/koompi/koompi-cli.git

cd $HOME/koompi-tmp-install/koompi-cli

cargo build --release

sleep 5

sudo cp target/release/koompi /usr/local/bin

cd $HOME

sleep 10

#Install visual studio code

if ! command -v code &> /dev/null; then
    echo "Visual Studio Code is not installed. Installing now..."
    koompi install visual-studio-code-bin

else
    echo "Visual Studio Code is already installed."
fi

echo "Success Install, Let's Test"

sleep 5

echo "Successfull installed"


#Kill the sudo input password

kill "$keep_sudo_alive_pid"

sleep 3

echo "Update System By KOOMPI Shell!!...."

koompi update

reboot



