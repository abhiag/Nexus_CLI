#!/bin/bash

# Display a welcome message
echo "**********************************************"
echo "* Run Nexus Prover Node With GA Crypto       *"
echo "**********************************************"
echo "Welcome to the Nexus Prover Node Setup Script!"
echo "Follow us for updates and support:"
echo "Telegram: https://t.me/NexusCommunity"
echo "Twitter: https://twitter.com/NexusXYZ"
echo "**********************************************"

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages
echo "Installing build-essential, pkg-config, libssl-dev, git-all..."
sudo apt install -y build-essential pkg-config libssl-dev git-all

echo "Installing protobuf-compiler..."
sudo apt install -y protobuf-compiler

# Install screen
echo "Installing screen..."
sudo apt install -y screen

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Sourcing Rust environment..."
. "$HOME/.cargo/env"

echo "Adding RISC-V target..."
rustup target add riscv32i-unknown-none-elf

echo "Installing Nexus cargo tools..."
cargo install --git https://github.com/nexus-xyz/nexus-zkvm cargo-nexus --tag 'v0.2.4'

# Start a new screen session named "nexusgac"
echo "Starting screen session nexusgac..."
screen -S nexusgac

# Final message
echo "**********************************************"
echo "* Setup Complete! Nexus Prover Node is Ready *"
echo "**********************************************"
echo "Join our community on Telegram and Twitter for support and updates!"
echo "Telegram: https://t.me/NexusCommunity"
echo "Twitter: https://twitter.com/NexusXYZ"