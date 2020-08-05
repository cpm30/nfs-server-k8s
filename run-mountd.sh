#!/bin/bash

set -eu

for mnt in "$@"; do
  if [[ ! "$mnt" =~ ^/exports/ ]]; then
    >&2 echo "Path to NFS export must be inside of the \"/exports/\" directory"
    exit 1
  fi
  mkdir -p $mnt
  chmod 777 $mnt
  echo "$mnt *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)" >> /etc/exports
done

exportfs -a
rpcbind
rpc.statd
rpc.nfsd

exec rpc.mountd --foreground
