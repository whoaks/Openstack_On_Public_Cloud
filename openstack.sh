#!/bin/bash

yum update -y

yum install -y python3

pip3 install gdown

gdown   --id   1aS5WPyv7n-NdUEJsTed4KxQ3WwN6JlLA    --output    rhel-7-server-additional-20180628.iso

gdown   --id   1bXeoQp0D0So-rk1XgPXo1MeYHmXoFcSV   --output    rhel-7.5-server-updates-20180628.iso

gdown   --id   1kkBG-Oa5sRhAZHDSEaIRsrxM0GxEv3gf    --output    RHEL7OSP-13.0-20180628.2-x86_64.iso

mkdir /iso  /iso1  /iso2

mount -o loop rhel-7.5-server-updates-20180628.iso  /iso/

mount -o loop rhel-7-server-additional-20180628.iso  /iso1/

mount -o loop RHEL7OSP-13.0-20180628.2-x86_64.iso /iso2/

mkdir /softwares

cp -rvf /iso/  /softwares/

cp -rvf /iso1/  /softwares/

cp -rvf /iso2/  /softwares/

yum install createrepo  -y

createrepo -v /softwares/.

cat <<EOF > /etc/yum.repos.d/openstack.repo
[Openstack]
name=Openstack
baseurl=file:///softwares
gpgcheck=0
EOF

yum install openstack-packstack -y

packstack --gen-answer-file=aks.txt

packstack  --answer-file=aks.txt
