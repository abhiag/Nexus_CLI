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

#!/bin/bash

# Exit on any error
set -e

echo "🔧 Updating package list and installing dependencies..."
if command -v apt &>/dev/null; then
    apt update && apt install -y build-essential clang curl gcc libssl-dev pkg-config protobuf-compiler
elif command -v yum &>/dev/null; then
    yum groupinstall -y "Development Tools"
    yum install -y clang curl gcc openssl-devel pkg-config protobuf-devel
elif command -v pacman &>/dev/null; then
    pacman -S --needed base-devel clang curl gcc openssl pkg-config protobuf
else
    echo "❌ Unsupported package manager. Install dependencies manually."
    exit 1
fi

# Verify required tools
if ! command -v cc &>/dev/null || ! command -v gcc &>/dev/null || ! command -v pkg-config &>/dev/null; then
    echo "❌ Error: 'cc', 'gcc', or 'pkg-config' not found after installation!"
    exit 1
fi

# Verify `protoc` installation
if ! command -v protoc &>/dev/null; then
    echo "❌ Error: 'protoc' (Protocol Buffers Compiler) not found!"
    exit 1
fi
echo "✅ Protobuf installed: $(protoc --version)"

# Set OpenSSL environment variables
export OPENSSL_DIR=$(pkg-config --variable=prefix openssl)
export OPENSSL_LIB_DIR=$(pkg-config --variable=libdir openssl)
export OPENSSL_INCLUDE_DIR=$(pkg-config --variable=includedir openssl)
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$OPENSSL_DIR/lib/pkgconfig

echo "🚀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Load Rust environment
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env

echo "✅ Rust installed: $(rustc --version)"

echo "🔧 Adding RISC-V target..."
rustup target add riscv32i-unknown-none-elf
echo "✅ RISC-V target added."

echo "🌍 Installing Nexus CLI (Automatically Accepting Terms)..."
printf "y\n" | curl -fsSL https://cli.nexus.xyz/ | sh   # Automatically accept terms

# Ensure cargo is accessible
if ! command -v cargo &>/dev/null; then
    echo "⚠️ Cargo not found. Manually adding to PATH."
    export PATH="$HOME/.cargo/bin:$PATH"
    source $HOME/.cargo/env
fi

# Verify installation
echo "✅ Nexus CLI installed: $(nexus-cli --version 2>/dev/null || echo 'Installation completed')"

# Start Nexus CLI in a screen session
echo "🖥️ Creating a screen session for Nexus CLI..."
screen -dmS nexuscli bash -c "source $HOME/.cargo/env && nexus-cli"

echo "✅ Screen session 'nexuscli' created."
echo "To attach to the session, run: screen -r nexuscli"

echo "🎉 Installation complete!"

# Final message
echo "**********************************************"
echo "* Setup Complete! Nexus Prover Node is Ready *"
echo "**********************************************"
echo "Join our community on Telegram and Twitter for support and updates!"
echo "Telegram: https://t.me/GaCryptOfficial"
echo "Twitter: https://x.com/GACryptoO"
