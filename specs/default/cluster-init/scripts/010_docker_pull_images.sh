#!/bin/bash -x

CLUSTER_OWNER=$( jetpack config cyclecloud.cluster.user.name )
NVIDIA_IMAGES_JSON=$( jetpack config --json nvidia.images )

/usr/bin/ngc-user.sh 
usermod -a -G docker $CLUSTER_OWNER

/usr/bin/ngc-login.sh


set -e

apt install -y jq

NVIDIA_IMAGES=$( echo ${NVIDIA_IMAGES_JSON} | jq '.["nvidia.images"] | .[]' | sed -e 's/"//g' )

echo "Pre-caching images: ${NVIDIA_IMAGES}"
for IMG in ${NVIDIA_IMAGES}; do

    if [[ ! "$IMG" =~ ^nvcr.io* ]]; then
        echo "WARNING: Attempting to pull image from a repo other than nvcr.io: ${IMG}..."
    fi
    echo "Pulling docker image: ${IMG}"
    docker pull ${IMG}
    
done


echo "Currently loaded images: "
docker images
