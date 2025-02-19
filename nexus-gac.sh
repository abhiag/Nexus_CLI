#!/bin/bash

# Display a welcome message
echo "**********************************************"
echo "* Run Nexus Prover Node With GA Crypto       *"
echo "**********************************************"
echo "Welcome to the Nexus Prover Node Setup Script!"
echo "Follow us for updates and support:"
echo "Telegram: https://t.me/GaCryptOfficial"
echo "Twitter: https://x.com/GACryptoO"
echo "**********************************************"

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages
echo "Installing build-essential, pkg-config, libssl-dev, git-all..."
sudo apt install -y build-essential pkg-config libssl-dev git-all

echo "Installing protobuf-compiler..."
sudo apt install -y protobuf-compiler

# Exit on error
set -e

echo "🚀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Load Rust environment
source $HOME/.cargo/env

echo "✅ Rust installed: $(rustc --version)"

echo "🔧 Adding RISC-V target..."
rustup target add riscv32i-unknown-none-elf
echo "✅ RISC-V target added."

echo "🌍 Installing Nexus CLI..."
curl -fsSL https://cli.nexus.xyz/ | sh

echo "✅ Nexus CLI installed: $(nexus-cli --version 2>/dev/null || echo 'Installation completed')"

echo "🎉 Installation complete!"

# Final message
echo "**********************************************"
echo "* Setup Complete! Nexus Prover Node is Ready *"
echo "**********************************************"
echo "Join our community on Telegram and Twitter for support and updates!"
echo "Telegram: https://t.me/GaCryptOfficial"
echo "Twitter: https://x.com/GACryptoO"
