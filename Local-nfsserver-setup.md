# Setup NFS server for persistent storage

NFS server need to be setup in a machine with large storage disk.

* [ ] Install nfs server
Log into node with storage disk and run the following command
```
    yum install -y nfs-utils
    systemctl enable rpcbind
    systemctl enable nfs-server
    systemctl start rpcbind
    systemctl start nfs-server
```

* [ ] Configure firewall ports

```
    firewall-cmd --zone=public --add-port=111/tcp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-port=111/udp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-port=2049/tcp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-port=2049/udp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-port=892/tcp --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --add-port=662/udp --permanent
    firewall-cmd --reload
```

        
* [ ] Allow all nodes in the subnet to access it

```
    vi /etc/exports
```

Add the following line to allow all nodes in the cluster to access the NFS server for file sharing.

```    
    /data *(rw,sync,no_root_squash)
```

* [ ] Restart the nfs server

```    
    systemctl restart nfs-server
```

* [ ] Test the NFS mount
  Go to any of the worker nodes, example worker2

```
    mkdir /data
    mount -t nfs <worker1>:/data /data
    cd /data
```

Make sure this mount work correctly. After the test, umount the share
```
    umount /data
```
