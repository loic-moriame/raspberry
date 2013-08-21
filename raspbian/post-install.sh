#!/bin/bash

#=============================================================================

# Variables globales
#-------------------

HOME_PATH=`grep $USERNAME /etc/passwd | cut -d: -f6`
APT_GET="apt-get -q -y --force-yes"
WGET="wget -m --no-check-certificate"
DATE=`date +"%Y%m%d%H%M%S"`
LOG_FILE="/tmp/raspbian_postinstall-$DATE.log"

# Ajouter la liste de vos logiciels séparés par des espaces
LISTE=""

# Tools
LISTE=$LISTE" vim screen aptitude"
LISTE=$LISTE" samba cifs-utils ntfs-3g"
LISTE=$LISTE" minidlna"

# Update & Upgrade
echo -n "[en cours] $APT_GET update"
shift
shift
$APT_GET update
echo -n "[en cours] $APT_GET upgrade"
shift
shift
$APT_GET upgrade

# Installation des différents packages
echo -n "[en cours] $APT_GET install $LISTE"
shift
shift
$APT_GET install $LISTE

# CHANGE TIMEZONE
sh -c "/usr/bin/tzselect"

# CHANGE HOSTNAME
sh -c "sed -i 's/raspberrypi/raspbian/g' /etc/hostname"
sh -c "sed -i 's/raspberrypi/raspbian/g' /etc/hosts"
sh -c "/etc/init.d/hostname.sh start"

# SAMBA
echo -n "[en cours] Configuring SAMBA"
shift
shift
sh -c "adduser guest --home=/home/public --shell=/bin/false --disabled-password"
sh -c "chmod -R 0700 /home/public"
sh -c "chown -R guest.guest /home/public"
sh -c "mkdir /media/data"
sh -c "mount -t ntfs-3g /dev/sda1 /media/data"
sh -c "cp /etc/samba/smb.conf /etc/samba/smb.conf.origin"
# wget config file
wget -q https://raw.github.com/moriame/raspberry/master/raspbian/config/smb.conf -O /etc/samba/smb.conf
sh -c "/etc/init.d/samba restart"
# add automount samba's share folder
echo "/dev/sda1 /media/data ntfs defaults 0 0" >> /etc/fstab 

# DLNA
echo -n "[en cours] Configuring DLNA"
shift
shift
sh -c "cp /etc/minidlna.conf /etc/minidlna.conf.origin"
#wget config file
wget -q https://raw.github.com/moriame/raspberry/master/raspbian/config/minidlna.conf -O /etc/minidlna.conf
sh -c "service minidlna force-reload"

# GET PROFILE FILES
wget -q https://raw.github.com/moriame/raspberry/master/raspbian/dotfiles/.bash_aliases -O /home/pi/.bash_aliases
wget -q https://raw.github.com/moriame/raspberry/master/raspbian/dotfiles/.vimrc -O /home/pi/.vimrc
