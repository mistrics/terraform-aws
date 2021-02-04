#!/bin/bash

set -x
set -o

touch /etc/database
cat > /etc/database << EOF
export DB_HOST=${DB_HOST}
export DB_USERNAME=${DB_USERNAME}
export DB_PASSWORD=${DB_PASSWORD}
export DB_NAME=${DB_NAME}
EOF

cat /etc/database