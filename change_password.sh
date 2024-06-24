#!/bin/bash
set -e

# initialize username/password variables
email=$1
username=$(echo "$email" | sed 's/@.*$//')
password=$(openssl rand -base64 8)

# create the user
echo "newpassword=$password"
passwd "$username"
chage -d0 "$username"
usermod -a -G students "$username"

# print the contents of the email to send to the new users
echo '=================================='
echo "I've reset your password on the lambda server to the following values."
echo 
echo "new password: $password"
echo
echo "You will be required to change your password on the first login.  Do not share your password with anyone else."

