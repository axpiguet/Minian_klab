# Minian pipeline: the Klab version !

The files contained in this repo are a mondified version of the Minian pipeline. It fixes big artefacts contained in the klab Miniscope recordings and makes the pipeline usable. The outputs are also made to be easy to use within the lab framework.

https://github.com/denisecailab/minian
https://minian.readthedocs.io/en/stable/index.html


## Environment creation ##
Using Miniforge : 

    Mamba create -y --name minian

    Mamba activate minian

    Mamba install -y -c conda-forge mamba

    Mamba install -y -c conda-forge Python=3.8

    Mamba install -y -c conda-forge MedPy=0.4.0

    Mamba install -y -c conda-forge minian=1.2.1

    Mamba install -y -c conda-forge pyviz_comms = 2.2.1
    
    Mamba install -y -c conda-forge xarray=0.19.0


## Data ## 

The pipeline is made to read Miniscope videos in .avi format, all stored under a same folder, sorted in chronological order. You will have to provide the path to the folder.

## Using the pipeline ## 

Before running anything, go to 
C:\Users\YourName\.conda\envs\YourEnvName\Library\pkgs\minian-1.2.1-py38h57928b3_1\Lib\site-packages\minian\visualization.py

and modify the write_video function with r = 25 instead of r = 30. This is important to get the appropriate number of frames in the output videos.


The rest of the instrictuions are provided in :
#### https://www.notion.so/neuronalcircuits/Minian-pipeline-1b23d51d9bb580e19cd6def533d16a79?pvs=4 ####

## Files description ##
Minian_runner.py --> fully runs MiniscopeAnimalParam.ipynb

MiniscopeAnimalParam.ipynb --> main pipeline notebook - to tune parameters

cross-registration.ipynb --> match and merge units across sessions 

checking.m --> plot traces and light intensity to validate the results

app2.mlapp --> displays synchronized traces and video
