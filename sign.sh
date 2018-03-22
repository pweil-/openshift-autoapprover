#!/bin/bash
#
# It will approve any CSR that is not approved yet, and delete any CSR that expired more than 60 seconds
# ago.
#
set -o errexit
set -o nounset
set -o pipefail
name=${1}
condition=${2}
certificate=${3}
username=${4}

echo "***************************************************"
echo "name: $name"
echo "condition: $condition"
echo "certificate: $certificate"
echo "username: $username"
echo "***************************************************"


# auto approve
if [[ -z "${condition}" && ("${username}" == "system:serviceaccount:openshift-infra:node-bootstrapper" || "${username}" == "system:node:"* ) ]]; then
  oc adm certificate approve "${name}"
  exit 0
fi
# check certificate age
if [[ -n "${certificate}" ]]; then
  text="$( echo "${certificate}" | base64 -d - )"
  if ! echo "${text}" | openssl x509 -noout; then
    echo "error: Unable to parse certificate" 2>&1
    exit 1
  fi 
  if ! echo "${text}" | openssl x509 -checkend -60 > /dev/null; then
    echo "Certificate is expired, deleting"
    oc delete csr "${name}"
  fi
  exit 0
fi
