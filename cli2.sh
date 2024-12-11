#!/bin/bash

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Sourcing Rust environment..."
source "$HOME/.cargo/env"

echo "Adding RISC-V target..."
rustup target add riscv32i-unknown-none-elf

echo "Installing Nexus cargo tools..."
sudo cargo install --git https://github.com/nexus-xyz/nexus-zkvm cargo-nexus --tag 'v0.2.4'

echo "Creating a new Nexus project..."
cargo nexus new nexus-project

if [ -d "nexus-project" ]; then
  echo "Navigating into the Nexus project directory..."
  cd nexus-project
else
  echo "Failed to create Nexus project directory!"
fi

echo "Nexus project setup is complete!"
