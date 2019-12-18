#!/bin/sh

echo "root:$ROOT_PASSWORD" | /usr/sbin/chpasswd

exec "$@"
