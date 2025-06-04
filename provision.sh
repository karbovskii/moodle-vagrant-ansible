#!/bin/bash
set -e

VENV_DIR=".venv"

# Ensure python3 and pip are installed
if ! command -v python3 &>/dev/null; then
    echo "Error: python3 is not installed."
    exit 1
fi

if ! python3 -m venv --help &>/dev/null; then
    echo "python3-venv not installed, attempting to install it..."
    if command -v apt &>/dev/null; then
        sudo apt update
        sudo apt install -y python3-venv
    else
        echo "Unsupported package manager. Please install python3-venv manually."
        exit 1
    fi
fi

# Create venv if needed
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

# Activate and install requirements
source "$VENV_DIR/bin/activate"
pip install --upgrade pip

# Install Ansible if not already
if ! command -v ansible-playbook &>/dev/null; then
    echo "Installing Ansible..."
    pip install ansible
fi

# Install collections
if [ -f requirements.yml ]; then
    echo "Installing Ansible collections..."
    ansible-galaxy collection install -r requirements.yml
fi

# Run playbook
echo "Running Ansible playbook..."
ansible-playbook -i inventory/inventory.ini site.yml "$@"
