#!/bin/bash
echo "########################################################################"
echo "PACKER - LINUX - UBUNTU TEMPLATE"
echo "########################################################################"

echo "### Clone repository from $PROVISIONER_SCRIPT_REPOSITORY_URL"
git clone $PROVISIONER_SCRIPT_REPOSITORY_URL
cd $PWD/$PROVISIONER_SCRIPT_REPOSITORY_NAME

echo "### Execute template base configuration scripts"
sh ./linux/os/distro/debian-based/generic/apt/apt-dist-upgrade.sh
sh ./linux/os/generic/grub/net-ifnames.sh

echo "### Execute template hardening scripts"
sh ./linux/os/generic/security/hardening/apparmor/enforce-ping.sh
sh ./linux/os/generic/security/hardening/apparmor/enforce-traceroute.sh
sh ./linux/os/generic/security/hardening/etc/fail2ban.sh
sh ./linux/os/generic/security/hardening/etc/fstab.sh
sh ./linux/os/generic/security/hardening/etc/host.sh
sh ./linux/os/generic/security/hardening/etc/irqbalance.sh
sh ./linux/os/generic/security/hardening/etc/issue.sh
sh ./linux/os/generic/security/hardening/etc/motd.sh
sh ./linux/os/generic/security/hardening/etc/modprobe.sh
sh ./linux/os/generic/security/hardening/etc/sysctl.sh
sh ./linux/os/generic/security/hardening/ssh/sshd_config.sh

echo "### Template cleanup"
sh ./linux/os/generic/crontab/cleanup-root.sh
sh ./linux/os/generic/crontab/cleanup-user.sh $PROVISIONER_USERNAME
sh ./linux/os/distro/debian-based/ubuntu/packages/cloud-init/cleanup.sh
sh ./linux/os/distro/debian-based/generic/apt/apt-autoremove.sh
sh ./linux/os/distro/debian-based/generic/apt/apt-autoclean.sh


echo "########################################################################"
echo " "