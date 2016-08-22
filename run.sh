#!/bin/sh
# Certificates
Environment="ETCD_CERT_FILE=/etc/ssl/etcd/etcdserver.pem"
Environment="ETCD_KEY_FILE=/etc/ssl/etcd/etcdserver-key.pem"
Environment="ETCD_TRUSTED_CA_FILE=/etc/ssl/etcd/ca.pem"
Environment="ETCD_CLIENT_CERT_AUTH=true"
Environment="ETCD_PEER_CERT_FILE=/etc/ssl/etcd/etcdserver.pem"
Environment="ETCD_PEER_KEY_FILE=/etc/ssl/etcd/etcdserver-key.pem"
Environment="ETCD_PEER_TRUSTED_CA_FILE=/etc/ssl/etcd/ca.pem"
Environment="ETCD_PEER_CLIENT_CERT_AUTH=true"
# Listeners
Environment="ETCD_LISTEN_CLIENT_URLS=https://0.0.0.0:2379"

ETCD_CMD="/bin/etcd -data-dir=/data -listen-peer-urls=${PEER_URLS} -listen-client-urls=${CLIENT_URLS} $*"
echo -e "Running '$ETCD_CMD'\nBEGIN ETCD OUTPUT\n"

exec $ETCD_CMD