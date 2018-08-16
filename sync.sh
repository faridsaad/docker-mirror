#!/bin/bash
for image in $(cat /root/images.list|egrep -v '^#|^$')
do
  echo "skopeo copy --dest-tls-verify=false --dest-creds $username:$password docker://$src_reg/$image docker://$dest_reg/$image"
  skopeo copy --dest-tls-verify=false  --dest-creds $username:$password docker://$src_reg/$image docker://$dest_reg/$image
done
