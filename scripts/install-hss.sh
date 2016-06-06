#!/bin/bash
ctx logger info "installing OpenImsCore HSS..."
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java6-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java6-installer subversion ant
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get install -y mysql-server-5.6

cd /home/ubuntu
svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS
cd FHoSS
ant compile
ant deploy

FHOSS_PATH=`pwd`
HSS_DIAMETER_FILE=$FHOSS_PATH"/deploy/DiameterPeerHSS.xml"
HSS_PROPERTY_FILE=$FHOSS_PATH"/deploy/hss.properties"
HIBERNATE_PROPERTY_FILE=$FHOSS_PATH"/deploy/hibernate.properties"

sed -i -e 's/open-ims.test/example.com/' $HSS_DIAMETER_FILE
sed -i -e 's/open-ims.test/example.com/' $HSS_DIAMETER_FILE
sed -i -e 's/127.0.0.1/0.0.0.0/' $HSS_DIAMETER_FILE
sed -i -e 's/127.0.0.1/0.0.0.0/' $HSS_PROPERTY_FILE
sed -i -e 's/hibernate.connection.username=hss/hibernate.connection.username=root/' $HIBERNATE_PROPERTY_FILE
sed -i -e 's/hibernate.connection.password=hss/hibernate.connection.password=root/' $HIBERNATE_PROPERTY_FILE

ctx instance runtime_properties public_ip ${public_ip}
ctx instance runtime_properties fhoss_path ${FHOSS_PATH}
echo ${public_ip} > /home/ubuntu/public_ip
