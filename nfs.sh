# Create project namespace
oc new-project nfs-fs

# Role back
oc -n nfs-fs create -f rbac.yaml

# create sa
oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:nfs-fs:nfs-client-provisioner

# storage classes
oc -n nfs-fs create -f class.yaml

# create deployment
oc -n nfs-fs create -f deployment.yaml

# Make it a default storage class
oc patch storageclass managed-nfs-storage -p '{"metadata": {"annotations":  {"storageclass.kubernetes.io/is-default-class": "true"}}}'
