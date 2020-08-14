#!/bin/bash
# Script to add a user to Linux system
sudo yum install -y perl
if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
            echo "$username exists!"
            exit 1
        else
			pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
            useradd -m -p $pass $username
            [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                sudo yum install -y wget
                sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
                sudo rpm -ivh epel-release-latest-8.noarch.rpm
                sudo yum --enablerepo=epel install -y ansible
                sudo echo 'ansible         ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
                sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
                sudo service sshd restart
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi
