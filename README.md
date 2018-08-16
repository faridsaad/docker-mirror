Image Syncer
===============

Tool to copy a list of images between two Docker registries. It uses skopeo to perform transfers without requiring to store images locally.

Useful when preparing for disconnected installations.

Example execution
===============

1. Edit the vars file and adjust to your environment accordingly:
```
# Destination registry URL ( host:port )
dest_reg=artifactory.yourcompany.com

# Destination registry username
username=USERNAME

# Destination registry password
password=PASSWORD
```

2. Edit images.list and add an image to sync per line:
```
openshift3/ose-pod:v3.7.52
openshift3/ose-sti-builder:v3.7.52
openshift3/ose:v3.7.52
```

3. Build the image. This will bake the image list and sync script into it, preparing it for execution:
```
docker build . -t skopeo:latest
```

4. Run the sync:
```
docker run -it --env-file=vars --rm skopeo:latest /root/sync.sh
```

5. The output of a successful run will look something like the following:

```
# docker run -it --env-file=vars --rm skopeo:latest /root/sync.sh
skopeo copy --dest-tls-verify=false --dest-creds <username>:<password> docker://registry.access.redhat.com/openshift3/ose-pod:v3.7.52 docker://artifactory.yourcompany.com/openshift3/ose-pod:v3.7.52
Getting image source signatures
Skipping fetch of repeat blob sha256:e0f71f706c2a1ff9efee4025e27d4dfd4f328190f31d16e11ef3283bc16d6842
Skipping fetch of repeat blob sha256:121ab4741000471a7e2ddc687dedb440060bf9845ca415a45e99e361706f1098
Skipping fetch of repeat blob sha256:db5e66b8b5eb2822d970eb438252ed62ba1cb2d70b50d1cfcdf36144f701326a
Copying config sha256:4dd9772a423525d402f795dd0f5b40f756e93b5d821055166da6821f34832072
 0 B / 3.55 KB [------------------------------------------------------------] 0s
Writing manifest to image destination
Storing signatures
# 
```
