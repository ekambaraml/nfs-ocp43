# How to manually creating PV and PVC using NFS Share

Before creating PV, please create the share with folder /data/attachment

* Create PV for Attachment purpose

```
cat <<EOF |oc apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-attachment-pv
spec:
  capacity:
    storage: 5Gi 
  accessModes:
  - ReadWriteOnce 
  nfs: 
    path: /data/attachment
    server: 172.17.0.2 
  persistentVolumeReclaimPolicy: Retain
EOF
```

* Create PVC for Attachment

```
cat <<EOF |oc apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-attachment-pvc
spec:
  accessModes:
    - ReadWriteOnce 
  resources:
    requests:
      storage: 1Gi
  volumeName: nfs-attachment-pv
EOF
```
