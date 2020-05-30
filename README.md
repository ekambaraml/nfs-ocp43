
# NFS Storage provisioner and OpenShift 4.3 Registry Storage Setup 

#### Assumption:
- NFS server is setup and exported the share to this OpenShift Cluster nodes
- NFS share has r/w permission to this cluster

For more help <url>

## Create a new project for NFS

` oc new-project nfs-fs `

## Setup RBAC
` oc -n nfs-fs create -f rbac.yaml`

##  Setup Service Account
` oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:nfs-fs:nfs-client-provisioner`

## Create storage class
`oc -n nfs-fs create -f class.yaml`

## Create Deployment
update the deployment.yaml with NFS server IP address and path
`oc -n nfs-fs create -f deployment.yaml`


## Update - OpenShift 4.3 registry to use NFS storage
`oc patch storageclass managed-nfs-storage -p '{"metadata": {"annotations":  {"storageclass.kubernetes.io/is-default-class": "true"}}}'`

## Update imageregistry config to use nfs
`oc patch configs.imageregistry.operator.openshift.io cluster --type=json --patch '[{"op":"remove","path":"/spec/storage/emptyDir"},{"op":"add","path":"/spec/storage/pvc","value":{"claim"`:""}}]'

## expose registry
`oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge`


