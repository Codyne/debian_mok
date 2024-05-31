#!/bin/sh

MOK_SCRIPT=$(basename "$0")
MOK_DIR=/var/lib/shim-signed/mok

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

echo "Installing dkms"
apt-get install -y dkms

if [ ! -d "$MOK_DIR" ]; then
	echo "$MOK_DIR does not exist. Creating..."
	mkdir -p $MOK_DIR
fi

cd $MOK_DIR

# setting up the keys
# note: as of this scripts creation, shim doesn't support adding a 4096 RSA key
openssl req -nodes -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -days 36500 -subj "/CN=$MOK_SCRIPT/"
openssl x509 -inform der -in MOK.der -out MOK.pem

# enrolling the new key
echo "Input one time password for MOK enrollment"
mokutil --import $MOK_DIR/MOK.der

mokutil --test-key $MOK_DIR/MOK.der

echo "\nAll done. Reboot and accept the key enrollment using your one time password."
