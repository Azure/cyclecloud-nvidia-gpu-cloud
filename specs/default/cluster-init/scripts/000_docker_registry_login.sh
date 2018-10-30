#!/bin/bash -x

NVIDIA_API_KEY=$( jetpack config nvidia.api_key )

set -e

# The NVidia profile reads stdout from this file to fetch the API Key
cat <<EOF > /usr/bin/ngc-get-key.sh
#!/bin/sh
#
# Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# This is a hook to automatically retrieve a user's NGC API Key, called
# from ngc-login.sh.

# If successful, the API Key will be printed on stdout, with rc = 0
# Else, exit rc = 1

echo "$NVIDIA_API_KEY"

EOF

chmod a+x /usr/bin/ngc-get-key.sh


