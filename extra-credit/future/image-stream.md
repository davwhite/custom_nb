# Build custom images with image streams
. <(oc completion bash)
oc new-build --name base-ubi9 --strategy docker --binary --context-dir .
oc start-build base-ubi9 --from-dir ubi9 --follow 

oc new-build --name minimal-notebook --strategy docker --binary --image-stream base-ubi9:latest --context-dir .
oc start-build minimal-notebook --from-dir minimal/py39 --follow

oc new-build --name my-custom-notebook --strategy docker --binary --image-stream minimal-notebook:latest --context-dir .
oc start-build my-custom-notebook --from-dir custom --follow