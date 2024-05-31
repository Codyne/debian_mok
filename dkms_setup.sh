#!/bin/sh

MOK_DIR=/var/lib/shim-signed/mok
MOK_KEY=$MOK_DIR/MOK.priv
MOK_CERT=$MOK_DIR/MOK.der

DKMS_FW=/etc/dkms/framework.conf

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

update_dkms_fw() {
	if [ "$1" -eq 1 ]; then
		echo "Updating $DKMS_FW..."
		echo "mok_signing_key=\"$MOK_KEY\"" >> $DKMS_FW
		echo "mok_certificate=\"$MOK_CERT\"" >> $DKMS_FW
		echo "Done\n"
	else
		echo "Not updating..."
		echo "Please append the following lines to $DKMS_FW"
		echo "mok_signing_key=\"$MOK_KEY\""
		echo "mok_certificate=\"$MOK_CERT\"\n"
	fi
}

read -p "$DKMS_FW must be updated, would you like this done for you automatically? [Y/n] " choice

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
	update_dkms_fw 1
else
	update_dkms_fw 0
fi
