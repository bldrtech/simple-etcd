# simple-etcd
# tls etcd cluster with docker containers
# Example run
```
docker run \
  -d \
  -p 2379:2379 \
  -p 2380:2380 \
  -p 4001:4001 \
  -p 7001:7001 \
  -v /home/core/etcd/data:/data \
  -v /home/core/etcd/certs:/etc/ssl/etcd:ro \
  --name named-etcd \
  bldrtech/simple-etcd:latest \
  -name named-etcd \
  -advertise-client-urls https://192.168.1.99:4001 \
  -initial-advertise-peer-urls http://192.168.1.99:7001
```