#!/bin/bash

# Step 1: Create an APT keyring (if one doesn’t already exist):
sudo install -d -m 0755 /etc/apt/keyrings

# Step 2: Import the Mozilla APT repo signing key (if wget is missing install it first):
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# Step 3: Add the Mozilla signing key to your sources.list:
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# Step 4: Set the Firefox package priority to ensure Mozilla’s Deb version is always preferred. If you don’t do this the Ubuntu transition package could replace it, reinstalling the Firefox Snap:
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

# Step 5: Finally, install the Firefox DEB in Ubuntu:
sudo apt update && sudo apt install firefox
