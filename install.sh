#!/bin/bash
function add_newuser () {
    echo "Enter New Username:"
    read username
    sudo mkdir /samba/${username}
    sudo adduser --home /samba/${username} --no-create-home --shell /usr/sbin/nologin --ingroup sambashare ${username}
    sudo chown ${username}:sambashare /samba/${username}/
    sudo chmod 2770 /samba/${username}/
    sudo smbpasswd -a ${username}
    sudo smbpasswd -e ${username}
    sudo echo "[${username}]" >> /etc/samba/smb.conf
    sudo echo "        path = /samba/${username}" >> /etc/samba/smb.conf
    sudo echo "        browseable = no" >> /etc/samba/smb.conf
    sudo echo "        read only = no" >> /etc/samba/smb.conf
    sudo echo "        force create mode = 0660" >> /etc/samba/smb.conf
    sudo echo "        force directory mode = 2770" >> /etc/samba/smb.conf
    sudo echo "        valid users = ${username} @admins" >> /etc/samba/smb.conf

}
function create_admin () {
    sudo mkdir /samba/everyone
    sudo adduser --home /samba/everyone --no-create-home --shell /usr/sbin/nologin --ingroup sambashare admin
    sudo chown admin:sambashare /samba/everyone/
    sudo chmod 2770 /samba/everyone/
    sudo smbpasswd -a admin
    sudo smbpasswd -e admin
    sudo groupadd admins
    sudo usermod -G admins admin
    sudo echo "[everyone]" >> /etc/samba/smb.conf
    sudo echo "        path = /samba/everyone" >> /etc/samba/smb.conf
    sudo echo "        browseable = yes" >> /etc/samba/smb.conf
    sudo echo "        read only = no" >> /etc/samba/smb.conf
    sudo echo "        force create mode = 0660" >> /etc/samba/smb.conf
    sudo echo "        force directory mode = 2770" >> /etc/samba/smb.conf
    sudo echo "        valid users = @sambashare @admins" >> /etc/samba/smb.conf
    testparm
    sudo systemctl start smbd.service

}
sudo apt-get update
sudo apt-get install samba
sudo systemctl stop nmbd.service
sudo systemctl disable nmbd.service
sudo systemctl stop smbd.service
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.orig
ip link
echo "Enter the Server Interfaces from above after 'lo'. EXAMPLE 'eth0 eth1'..."
read interface
sudo echo "[global]" > /etc/samba/smb.conf
sudo echo "        server string = samba_server" >>/etc/samba/smb.conf
sudo echo "        server role = standalone server" >>/etc/samba/smb.conf
sudo echo "        interfaces = lo ${interface}" >>/etc/samba/smb.conf
sudo echo "        bind interfaces only = yes" >>/etc/samba/smb.conf
sudo echo "        disable netbios = yes" >>/etc/samba/smb.conf
sudo echo "        smb ports = 445" >>/etc/samba/smb.conf
sudo echo "        log file = /var/log/samba/smb.log" >>/etc/samba/smb.conf
sudo echo "        max log size = 10000" >>/etc/samba/smb.conf
testparm
sudo mkdir /samba/
sudo chown :sambashare /samba/
PS3='Please enter your choice: (1 to Add user) or (2 to complete setup) '
options=("Add Cloud User" "Setup Admin" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add Cloud User")
            add_newuser
            ;;
        "Setup Admin")
            echo "you chose Setup Admin"
            create_admin
            echo "Setup Complete"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
#stop
