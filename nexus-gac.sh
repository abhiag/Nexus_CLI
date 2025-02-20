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

#!/bin/sh

# -----------------------------------------------------------------------------
# 1) Ensure Rust is installed.
# -----------------------------------------------------------------------------
rustc --version || curl -sSf https://sh.rustup.rs | sh -s -- -y

# -----------------------------------------------------------------------------
# 2) Define environment variables and colors for terminal output.
# -----------------------------------------------------------------------------
NEXUS_HOME="$HOME/.nexus"
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
NC='\033[0m'  # No Color

# Ensure the $NEXUS_HOME directory exists.
[ -d "$NEXUS_HOME" ] || mkdir -p "$NEXUS_HOME"

# -----------------------------------------------------------------------------
# 3) Check for 'git' availability. If not found, exit.
# -----------------------------------------------------------------------------
git --version 2>&1 >/dev/null
if [ $? -ne 0 ]; then
  echo "Unable to find git. Please install it and try again."
  exit 1
fi

# -----------------------------------------------------------------------------
# 4) Clone or update the network-api repository in $NEXUS_HOME.
# -----------------------------------------------------------------------------
REPO_PATH="$NEXUS_HOME/network-api"
if [ -d "$REPO_PATH" ]; then
  echo "$REPO_PATH exists. Updating."
  (
    cd "$REPO_PATH" || exit
    git stash push -u "update_stash" > /dev/null 2>&1  # Stash changes, suppress output
    git fetch --tags
  )
else
  (
    cd "$NEXUS_HOME" || exit
    git clone https://github.com/nexus-xyz/network-api
  )
fi

# -----------------------------------------------------------------------------
# 5) Check out the latest tagged commit in the repository.
# -----------------------------------------------------------------------------
(
  cd "$REPO_PATH" || exit
  git -c advice.detachedHead=false checkout "$(git describe --tags --abbrev=0 2>/dev/null || git rev-list --tags --max-count=1)"
)

# -----------------------------------------------------------------------------
# 6) Run the Rust CLI in an infinite loop (auto-restart if killed), auto-confirming prompts.
# -----------------------------------------------------------------------------
while true; do
  echo "Starting Nexus CLI..."

  # Trap SIGINT (Ctrl+C) to gracefully exit the loop
  trap "echo 'Exiting...'; exit 0" INT

  (
    cd "$REPO_PATH/clients/cli" || exit 1  # Exit with error code if cd fails
    yes "y" | cargo run -r -- start --env beta
  ) < /dev/tty

  # Check the exit code of the cargo run command.
  exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo "Nexus CLI exited normally."
    break # Exit the loop if the command exited cleanly (not killed)
  elif [ $exit_code -eq 130 ]; then  # Check if it was interrupted (Ctrl+C)
    echo "Nexus CLI interrupted. Exiting..."
    exit 0
  else
    echo "Nexus CLI crashed (exit code: $exit_code). Restarting in 5 seconds..."
    sleep 5
  fi
done

echo "🎉 Installation complete!"

# Final message
echo "**********************************************"
echo "* Setup Complete! Nexus Prover Node is Ready *"
echo "**********************************************"
echo "Join our community on Telegram and Twitter for support and updates!"
echo "Telegram: https://t.me/GaCryptOfficial"
echo "Twitter: https://x.com/GACryptoO"
