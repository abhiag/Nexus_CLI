#!/bin/bash

# Display a welcome message
echo "**********************************************"
echo "* Final Execution *"
echo "**********************************************"
echo "Welcome to the Nexus Prover Node Setup Script!"
echo "Follow us for updates and support:"
echo "Telegram: https://t.me/GaCryptOfficial"
echo "Twitter: https://x.com/GACryptoO"
echo "**********************************************"

echo "Creating a new Nexus project..."
cargo nexus new nexus-project

echo "Prover is Starting"
curl https://cli.nexus.xyz/ | sh
