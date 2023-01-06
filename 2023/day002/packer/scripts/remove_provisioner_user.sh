#!/bin/bash
echo "########################################################################"
echo "PACKER - LINUX - PROVISIONER CLEANUP"
echo "########################################################################"
echo "#                                                                      #"

echo "@reboot /usr/sbin/deluser $PROVISIONER_USERNAME --remove-home && crontab -u root -r && passwd -l root" | crontab -u root -

echo "#                                                                      #"
echo "########################################################################"
echo " "