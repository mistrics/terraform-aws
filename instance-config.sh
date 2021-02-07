#!/bin/bash

sleep 1m

set -x
set -o

touch /etc/database
cat > /etc/database << EOF
export DB_HOST=${DB_HOST}
export DB_USER=${DB_USER}
export DB_PASSWORD=${DB_PASSWORD}
export DB_NAME=${DB_NAME}
EOF

cat /etc/database

# Install AWS EFS Utilities
sudo apt-get update
sudo apt-get -y install git binutils
git clone https://github.com/aws/efs-utils
cd ./efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

# Mount EFS
mkdir /efs
efs_dns_name="${efs_dns_name}"
#mount -t efs $efs_id:/ /efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $efs_dns_name:/ /efs

# Edit fstab so EFS automatically loads on reboot
echo $efs_dns_name:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab

systemctl restart apache2

echo "Instance Provisioning Complete."