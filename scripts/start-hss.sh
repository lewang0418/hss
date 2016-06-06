#!/bin/bash
ctx logger info "starting OpenImsCore HSS..."
export JAVA_HOME=/usr/lib/jvm/java-6-oracle
FHOSS_PATH=$(ctx instance runtime_properties fhoss_path)
cd ${FHOSS_PATH}/deploy/
COMMAND="sh startup.sh"

ctx logger info "${COMMAND}"
nohup ${COMMAND} > /dev/null 2>&1 &
PID=$!

mysql -uroot -proot -hlocalhost < $FHOSS_PATH"/scripts/hss_db.sql"
mysql -uroot -proot -hlocalhost < $FHOSS_PATH"/scripts/userdata.sql"
curl  https://raw.githubusercontent.com/lewang0418/hss/master/scripts/hss_db.sql > $FHOSS_PATH"/scripts/hss_db.sql"
mysql -uroot -proot -hlocalhost hss_db < $FHOSS_PATH"/scripts/hss_db.sql"

ctx instance runtime_properties hss_pid ${PID}
ctx logger info "Sucessfully started OpenImsCore HSS (${PID})"

