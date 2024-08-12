# How to manually creating PV and PVC using NFS Share


* Create PV for Attachment purpose


```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-attachment
spec:
  capacity:
    storage: 5Gi 
  accessModes:
  - ReadWriteOnce 
  nfs: 
    path: /data/attachment
    server: 172.17.0.2 
  persistentVolumeReclaimPolicy: Retain
```

* Create PVC for Attachment

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc-attachment
spec:
  accessModes:
    - ReadWriteOnce 
  resources:
    requests:
      storage: 1Gi
```
