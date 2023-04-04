# Custom Notebook Images
This guide assumes you have already created a working instance of Open Data Hub and users with appropriate privileges to login and run Jupyter notebook environments. 

This repository uses podman to create images from baselines and customizations and pushes the final image to quay.io where it can then be imported in to ODH. The following directories host the Dockerfile for the various image builds.

- *ubi9*  
This serves as the base image in this walk through. In this case, the ubi9 image serves as our base image. It is recommended to keep this image as clean as possible as the customizations will happen at a later stage.

- *minimal*  
This serves as the main notebook configuration for jupyter. It gathers all configuration and dependencies required to run in the ODH environment. 

- *custom*  
This serves as the main customization to finalize the image for your custom notebook. It is recommended to perform any OS level packages and libraries outside of Python.

## Getting started
To build custom notebook images for use with Open Data Hub use the following steps:

### Building the images
1. Build the base image by running the following command from the root of this repo directory:

     `podman build -t base-ubi9 base-ubi9`  

    This will build and image called *base-ubi9* which we will use in the next step.

2. Add the notebook configuration to the image:

     `podman build -t minimal-notebook --from base-ubi9 minimal/py39`   

    This will add all configuration and dependencies required by Jupyter Notebook to run the container correctly. The image will be named *minimal-notebook* and will be used in the next step.

3. Add the customization to the image:

     `podman build -t my-custom-notebook --from minimal-notebook custom`

    This last build is the final image which will add any customizations to the notebook and enable it to be imported into ODH. 

> *NOTE*: For convience, there is a bash script `build_local.sh` to simplify the build process.

### Push the final image to quay.io
In our example we have an image called `my-custom-notebook`. Next, we will tag the images and push it to quay.io with the following commands:

`podman tag my-custom-notebook:latest quay.io/my-account-name/my-custom-notebook:latest`

## Import your custom notebook into ODH
1. Log into your ODH instance.
2. Expand the `Settings` menu item on the left.
3. Click on `Notebook Images`.
4. Click on `Import new image`.
5. Enter the image you just pushed to quay.io `quay.io/my-account-name/my-custom-notebook:latest`.
6. Give a name and description. Be sure it gives some information about the image.
7. Click `Import` to complete the process.

## Run your custom notebook
1. Log into your ODH instance if not already logged in.
2. Under `Applications` click on `Enabled`
3. Click `Launch Application` on the Jupyter card.
4. You should see your custom notebook listed. Select it and change any other settings before launching.

Your Jupyter Notebook should now spin up with the appropriate dependencies and customizations.

## Test the customization
In this example, we've added the `libGl` library to support a computer vision project. We can confirm our customization was successfull by simply launching a terminal from our notebook session and executing 

`rpm -qa|grep -i libgl`

We should see the mesa-libgl and other packages installed. 

### Extra Credit ###
In the *extra-credit* directory, there is a notebook based on Yolov5 computer vision project. You should be able to import this notebook into your environment and execute the sample code on your new custom notebook environment. 