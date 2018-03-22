###
# to run, mount a kube config with appropriate permissions in
# /var/lib/origin/openshift.local.config/master/admin.kubeconfig
###
FROM openshift/origin
LABEL io.k8s.display-name="OpenShift CSR Approver" \
      io.k8s.description="This image runs the oc observe command to watch and approve CSR requests in your cluster."
RUN yum install -y openssl
ADD sign.sh /usr/bin/sign.sh
ADD entrypoint.sh /usr/bin/entrypoint.sh 
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

