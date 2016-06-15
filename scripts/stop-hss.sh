#!/bin/bash
ctx logger info "stop OpenImsCore HSS..."

set -e

PID=$(ctx instance runtime_properties hss_pid)

kill -9 ${PID}

ctx logger info "Sucessfully stopped OpenImsCore HSS (${PID})"

#public_ip=$(ctx instance runtime_properties public_ip)
#dns_ip=$(ctx instance runtime_properties dns_ip)

#retries=0
#cat > /home/ubuntu/dnsupdatefile << EOF
#server ${dns_ip}
#zone example.com
#key example.com 8r6SIIX/cWE6b0Pe8l2bnc/v5vYbMSYvj+jQPP4bWe+CXzOpojJGrXI7iiustDQdWtBHUpWxweiHDWvLIp6/zw==
#update delete hss.example.com. 30 A ${public_ip}
#send
#EOF

#while ! { sudo nsupdate /home/ubuntu/dnsupdatefile
#} && [ $retries -lt 10 ]
#do
#  retries=$((retries + 1))
#  echo 'nsupdate failed - retrying (retry '$retries')...'
#  ctx logger info "nsupdate failed retrying..."
#  sleep 5
#done
