#! /bin/bash
podman build -t base-ubi9 base-ubi9
podman build -t minimal-notebook --from base-ubi9 minimal/py39
podman build -t my-custom-notebook --from minimal-notebook custom
