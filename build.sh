#!/bin/bash
set -x
docker build -t pweil/openshift-bootstrap-approver .
docker tag pweil/openshift-bootstrap-approver docker.io/pweil/openshift-bootstrap-approver
docker push docker.io/pweil/openshift-bootstrap-approver

