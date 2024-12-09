#!/bin/bash
apt-get update
apt-get install -y gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc | gpg -o /usr/share/keyrings/mongodb-server-5.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-5.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | tee /etc/apt/sources.list.d/focal-security.list
apt-get update
apt-get install libssl1.1
apt-get install -y mongodb-org=5.0.29 mongodb-org-database=5.0.29 mongodb-org-server=5.0.29 mongodb-org-shell=5.0.29 mongodb-org-mongos=5.0.29 mongodb-org-tools=5.0.29
sed -i 's/^\(\s*bindIp:\s*\).*/\10.0.0.0/' /etc/mongod.conf
systemctl start mongod
systemctl enable mongodb
mongosh --eval "use crud-nodejs"
