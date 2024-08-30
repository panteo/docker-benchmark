#!/bin/bash

dest="host"
if [[ $1 == "cached" ]]; then
  dest="cached"
  cd /benchmark/cached
elif [[ $1 == "default" ]]; then
  dest="default"
  cd /benchmark/default
elif [[ $1 == "delegated" ]]; then
  dest="delegated"
  cd /benchmark/delegated
fi

echo
echo "Benchmarking $dest..."
sync
host_write_speed=$(dd if=/dev/zero of=./tempfile bs=1M count=1024 conv=fdatasync 2>&1 | tail -1)
echo "Write speed: $host_write_speed"
host_read_speed=$(dd if=./tempfile of=/dev/null bs=1M count=1024 2>&1 | tail -1)
echo "Read speed: $host_read_speed"
rm ./tempfile
