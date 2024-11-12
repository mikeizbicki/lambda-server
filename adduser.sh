#!/bin/sh
set -e

# initialize username/password variables
email=$1
username=$(echo "$email" | sed 's/@.*$//')
password=$(openssl rand -base64 8)

# initialize the primary group
if [ "$2" = '' ]; then
    echo "must specify a primary group in the second command line arg"
    exit
fi

# delete a user that already exists
if id -u $username; then
    echo "$username exists..."
    echo "enter [Y] to delete"
    read reallydelete
    if [ "$reallydelete" = "Y" ]; then
        echo "deleted"
        userdel $username
    else
        exit 0
    fi
fi

# create the user
echo "creating user $username"
useradd -m -p "$(mkpasswd $password)" -s /bin/bash "$username" -g "students"
chage -d0 "$username"
quotatool -u "$username" -b -q 100M -l 200M /
chown -R "$username" "/home/$username"
chgrp -R "students" "/home/$username"

# create the data structures settings
if [ "$2" = 'csci046' ]; then
    echo 'modifying account permissions for csci046'
    usermod -a -G csci046 "$username"
fi

# create the bigdata settings
if [ "$2" = 'csci143' ]; then
    echo 'modifying account permissions for csci143'
    usermod -a -G csci143 "$username"
    quotatool -u "$username" -b -q 10G -l 11G /
    quotatool -u "$username" -b -q 200G -l 250G /data
    bigdata_dir="/data/users_bigdata/$username/"
    mkdir "$bigdata_dir"
    chown "$username" "$bigdata_dir"
    chgrp "students" "$bigdata_dir"
    ln -s "$bigdata_dir" "/home/$username/bigdata"
fi

# compose the email message
message=$(cat <<EOF
To: $email
Subject: lambda server credentials

I've created an account for you on the lambda server.

your username: $username
your password: $password

The server is located at lambda.compute.cmc.edu:5055 inside CMC's VPN.  You should receive separate instructions from the CMC IT staff for logging into the VPN.

After logging into the VPN, you can login to the lambda server by running the following terminal command:

$ ssh $username@lambda.compute.cmc.edu -p 5055

You will be required to change your password on the first login.

Do not share your password with anyone else.  Sharing of passwords will be treated as an academic integrity violation.
EOF
)

# send the email using msmtp
if ! printf "%s" "$message" | msmtp --account default --read-recipients; then
    echo "Error: Failed to send email."
    echo "Make sure the .msmtp.env file exists and contains SMTP_PASSWORD"
    exit 1
fi

echo "Email sent successfully to $email."

#echo "Account limitations:"
#echo " * You currently don't have access to any of the GPUs on the server.  If you need access to the GPUs, let me know and I'll give you permission."
#echo " * Your home directory has 20GB allocated to it.  If you need more space, let me know and I'll give you more."
#echo
#echo "You can find all of the datasets in the /data directory.  The Twitter data is located at /data/Twitter\ dataset and the reddit data is located at /data/files.pushshift.io/reddit "

