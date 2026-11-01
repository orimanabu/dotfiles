#!/bin/bash

podman run --name rhokp --rm -p 8080:8080 -p 8443:8443 --env "ACCESS_KEY=mori1@redhat.com_6340056_4719e9db5254c506_64e0f77ec3e1a786" -d registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest
podman logs -f rhokp
