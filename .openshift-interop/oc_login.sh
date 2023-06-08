oc login ${OCP_API_URL} --username=${OCP_CRED_USR} --password=${OCP_CRED_PSW} --insecure-skip-tls-verify=true --kubeconfig=/tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig
oc adm policy add-cluster-role-to-user self-provisioner system:serviceaccount:quarkus-tests:default