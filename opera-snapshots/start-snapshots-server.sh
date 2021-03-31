#!/usr/bin/env bash
cd $(dirname $0)
set -ex


mkdir -p ./files

docker run --name snapshots-server \
    --rm -d --network=host \
    -v $(pwd)/files:/usr/share/nginx/html:ro \
    --entrypoint=/bin/bash \
    nginx:latest \
	-c "sed -i 's/listen  .*/listen 8080;/g' /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
	
