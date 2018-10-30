# NVidia GPU Cloud #

This project demonstrates adding the NVidia GPU Cloud container repository to a CycleCloud GridEngine cluster.
The same technique may be used to add NVidia GPU Cloud to any CycleCloud cluster.   The two requirements are to use the NVidia GPU Cloud Marketplace image and apply the project spec.


## License ##

To use the NVidia GPU Cloud container repository, you must create an account and obtain an API Key from the [Nvidia GPU Cloud](https://ngc.nvidia.com/) site.

To use the NVidia GPU Cloud Marketplace images, you must first accept the license agreement.
The simplest way to do so is to run the following Azure CLI commands:

``` bash
    az vm image accept-terms --urn "nvidia:ngc_azure_17_11:nvidia_gpu_cloud_18_06:18.08.0"
```



## Pre-Requisites ##


This sample requires the following:

  1. CycleCloud must be installed and running.

     a. If this is not the case, see the CycleCloud QuickStart Guide for
        assistance.

  2. The CycleCloud CLI must be installed and configured for use.

  3. You must have access to log in to CycleCloud.

  4. You must have access to upload data and launch instances in your chosen
     Cloud Provider account.

  5. You must have access to a configured CycleCloud "Locker" for Project Storage
     (Cluster-Init and Chef).

  6. Optional: To use the `cyclecloud project upload <locker>` command, you must
     have a Pogo configuration file set up with write-access to your locker.

     a. You may use your preferred tool to interact with your storage "Locker"
        instead.


## Configuring the Project ##


The first step is to configure the project for use with your storage locker:

  1. Open a terminal session with the CycleCloud CLI enabled.

  2. Switch to the data-science-vm project directory.


## Deploying the Project ##


To upload the project (including any local changes) to your target locker, run the
`cyclecloud project upload` command from the project directory.  The expected output looks like
this:

``` bash

   $ cyclecloud project upload my_locker
   Sync completed!

```


**IMPORTANT**

For the upload to succeed, you must have a valid Pogo configuration for your target Locker.


## Importing the Cluster Template ##


To import the cluster:

 1. Open a terminal session with the CycleCloud CLI enabled.

 2. Switch to the data-science-vm project directory.

 3. Run ``cyclecloud import_template Data-Science-VM -f templates/data-science-vm.txt``.
    The expected output looks like this:
    
    ``` bash
    
    $ cyclecloud import_template SGE-NVidia-GPU-Cloud -f templates/sge-nvidia-gpu-cloud.txt
    Importing template SGE-NVidia-GPU-Cloud....
    ---------------------------------
    SGE-NVidia-GPU-Cloud : *template*
    ---------------------------------
    Keypair:
    Cluster nodes:
        master: off
    Total nodes: 1
    ```


## Example Usage ##

Create a new cluster in the CycleCloud UI by selecting the "SGE-NVidia-GPU-Cloud" cluster type in the Cluster Creation page.

In the "Required Settings" form, select `tensorflow:18.08-py3`, `mxnet:18.08-py3`, and `caffe2:18.08-py3` from the container selection widget.

Start the cluster from the UI and then log in to the master to test:


``` bash
$ cyclecloud connect -c NvidiaGPUCloud-Mxnet master
admin@ip-0A800008:~$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
nvcr.io/nvidia/tensorflow   18.08-py3           acde02d28923        6 weeks ago         3.4GB
nvcr.io/nvidia/mxnet        18.08-py3           7c686255536a        6 weeks ago         4.1GB
nvcr.io/nvidia/caffe2       18.08-py3           e82334d03b18        6 weeks ago         3.02GB
admin@ip-0A800008:~$ nvidia-docker run  --rm nvcr.io/nvidia/tensorflow:18.08-py3 python -c 'import tensorflow as tf; print("starting tensorflow session"); hello = tf.constant("Hello, TensorFlow!"); sess = tf.Session(); print(sess.run(hello)); print("tensorflow session complete\n")'

================
== TensorFlow ==
================

NVIDIA Release 18.08 (build 604096)

Container image Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
Copyright 2017 The TensorFlow Authors.  All rights reserved.

Various files include modifications (c) NVIDIA CORPORATION.  All rights reserved.
NVIDIA modifications are covered by the license terms that apply to the underlying project or file.

2018-09-13 19:26:19.677942: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1392] Found device 0 with properties:
name: Tesla P100-PCIE-16GB major: 6 minor: 0 memoryClockRate(GHz): 1.3285
pciBusID: 09ce:00:00.0
totalMemory: 15.90GiB freeMemory: 15.61GiB
2018-09-13 19:26:19.677987: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1471] Adding visible gpu devices: 0
2018-09-13 19:26:19.942527: I tensorflow/core/common_runtime/gpu/gpu_device.cc:952] Device interconnect StreamExecutor with strength 1 edge matrix:
2018-09-13 19:26:19.942587: I tensorflow/core/common_runtime/gpu/gpu_device.cc:958]      0
2018-09-13 19:26:19.942596: I tensorflow/core/common_runtime/gpu/gpu_device.cc:971] 0:   N
2018-09-13 19:26:19.942889: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1084] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 15131 MB memory) -> physical GPU (device: 0, name: Tesla P100-PCIE-16GB, pci bus id: 09ce:00:00.0, compute capability: 6.0)
starting tensorflow session
b'Hello, TensorFlow!'
tensorflow session complete

admin@ip-0A800008:~$

```

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

