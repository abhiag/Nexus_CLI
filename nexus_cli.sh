#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install necessary packages
sudo apt install -y build-essential pkg-config libssl-dev git-all screen protobuf-compiler

# Start a screen session named "nexusgac"
screen -dmS nexusgac bash -c '
# Install Rust
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source Rust environment
. "$HOME/.cargo/env"

# Add RISC-V target
rustup target add riscv32i-unknown-none-elf

# Install Nexus cargo tools
cargo install --git https://github.com/nexus-xyz/nexus-zkvm cargo-nexus --tag "v0.2.4"

# Create a new Nexus project
cargo nexus new nexus-project

# Navigate into the project directory
cd nexus-project

# Installation complete
echo "Nexus project setup complete!"
'
