### Scripts to automate setting up MOK and automatic kernel module signing with DKMS

After installing Debian with secure boot enabled, run:\
`mok_setup.sh`\
You will be prompted for a one time user password.\
Once done, reboot your machine. If successful, it will boot into the MOK manager where you can select to enroll the new key created by the script. To enroll, it will ask for the one time password you put during the setup.\
When the key has been successfully enrolled, reboot once again to boot into Debian.

Once back on Debian, run:\
`dkms_setup.sh`\
If you don't want the script to automatically edit your dkms framework.conf, select `n` and the script will output what you need to append and where so that you may edit it yourself.

It should now be safe to `apt-get update` and `apt-get upgrade` without breaking your system.