#!/bin/bash
ctx logger info "starting OpenImsCore HSS..."
export JAVA_HOME=/usr/lib/jvm/java-6-oracle
HSS_PATH=$(ctx instance runtime_properties hss_path)
cd ${HSS_PATH}/deploy/
COMMAND="sh startup.sh"

ctx logger info "${COMMAND}"
nohup ${COMMAND} > /dev/null 2>&1 &
PID=$!

ctx instance runtime_properties hss_pid ${PID}
ctx logger info "Sucessfully started OpenImsCore HSS (${PID})"
