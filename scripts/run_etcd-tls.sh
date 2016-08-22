#!/bin/bash
if [ $# -ne 5 ]; then
    echo "Usage: $0 hostname ipaddress networkname clustertoken initial_cluster_string"
    exit
else
name=$1
ip=$2
network=$3
token=$4
path="/home/$USER/etcd/data/"
certpath="home/$USER/etcd/certs"
clusterstring=$5
proto="https"
fi

if [ ! -d ${path}${name} ]; then
        mkdir -p ${path}${name}
        if [ $? -eq 0 ]; then
                echo "Created datadir: ${path}${name}"
        else
                echo "NO DataDir availble"
                exit
        fi
else
        echo "Found datadir ${path}${name}"
fi

if [ ! -d ${certpath} ]; then
        echo "No CertsDir found, running http mode"
        proto=http
fi


##this node will be private only
  #-p 2379:2379 \
  #-p 2380:2380 \
  #-p 4001:4001 \
  #-p 7001:7001 \
docker run \
  -d \
  --name ${name} \
  --net=${network} \
  --ip ${ip} \
  -v ${path}${name}:/data \
  -v ${certpath}:/etc/ssl/etcd:ro \
  bldrtech/simple-etcd:latest \
  --name ${name} \
  --initial-advertise-peer-urls ${proto}://${ip}:2380 \
  --listen-peer-urls ${proto}://${ip}:2380 \
  --listen-client-urls ${proto}://${ip}:2379,${proto}://127.0.0.1:2379 \
  --advertise-client-urls ${proto}://${ip}:2379 \
  --initial-cluster-token ${token} \
  --initial-cluster ${clusterstring} \
  --initial-cluster-state new