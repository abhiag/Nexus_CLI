#!/bin/bash

echo "Creating a new Nexus project..."
cargo nexus new nexus-project

echo "Prover is Starting"
curl https://cli.nexus.xyz/ | sh
