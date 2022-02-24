#!/bin/sh
set -x

bash -x /opt/jboss/tools/docker-entrypoint.sh --server-config=standalone.xml
