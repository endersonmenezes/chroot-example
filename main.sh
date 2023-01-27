###
# Example of CHRoot Usage
# Author : Enderson Menezes <endersonster@gmail.com>
# Date   : 25/01/2023
###

# Input name of User
echo "Enter the name of user: "
read user

# Create user if not exists
sudo useradd $user

# Create a directory for the user
rm -rf /home/$user
mkdir -p /home/$user
mkdir -p /home/$user/jail
mkdir -p /home/$user/jail/{bin,lib64}

# Copy the necessary files to the user's directory
cp /bin/{bash,ls} /home/$user/jail/bin 

# Required libraries
ldd /bin/bash | grep -o '/lib64/.*' | awk '{print $1}' | xargs -I {} cp {} /home/$user/jail/lib64
ldd /bin/ls | grep -o '/lib64/.*' | awk '{print $1}' | xargs -I {} cp {} /home/$user/jail/lib64

# Chroot on user's directory
sudo chroot /home/$user/jail /bin/bash
