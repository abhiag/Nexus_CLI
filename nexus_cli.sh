#!/bin/bash

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

# Start a new screen session named "nexusgac"
echo "Starting screen session nexusgac..."
screen -S nexusgac
