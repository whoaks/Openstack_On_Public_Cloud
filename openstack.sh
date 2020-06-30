#!/bin/bash

yum update -y

yum install -y python3

pip3 install gdown

gdown   --id   1Djig-XDIkvD6VWfVwVgBqQpaBmaLWWPt    --output    rhel-7-server-additional-20180628.iso

gdown   --id   1uj1BTHHlUX7Oe2fjpElPPZgTZc9cjJMO   --output    rhel-7.5-server-updates-20180628.iso

gdown   --id   1ElVE3GsiW8j3Su9tb5HJpjXXo4lg1Yv8    --output    RHEL7OSP-13.0-20180628.2-x86_64.iso

mkdir /iso  /iso1  /iso2

mount -o loop rhel-7.5-server-updates-20180628.iso  /iso/

mount -o loop rhel-7-server-additional-20180628.iso  /iso1/

mount -o loop RHEL7OSP-13.0-20180628.2-x86_64.iso /iso2/

mkdir /softwares

cp -rvf /updates/  /softwares/

cp -rvf /additional/  /softwares/

cp -rvf /RHOSP/  /softwares/

yum install createrepo  -y

createrepo -v /softwares/.

cat <<EOF > /etc/yum.repos.d/openstack.repo
[Openstack]
name=Openstack
baseurl=file:///RHOSP13
gpgcheck=0
EOF

yum install openstack-packstack -y

packstack --gen-answer-file=aks.txt

packstack  --answer-file=aks.txt
