#!/bin/bash
set -x

while true; do
  /usr/bin/oc observe csr --maximum-errors=-1 --resync-period=10m -a {.status.conditions[*].type} -a {.status.certificate} -a {.spec.username} -- sign.sh
done
