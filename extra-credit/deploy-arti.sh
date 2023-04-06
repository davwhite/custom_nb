#!/bin/bash
oc new-project artifact-server
oc new-build --name artifact-http --strategy docker --binary --context-dir .
oc start-build artifact-http --from-dir extra-credit --follow
oc new-app --name=arti-repo image-registry.openshift-image-registry.svc:5000/artifact-server/artifact-http:latest
oc expose svc/arti-repo --name=arti-repo-route