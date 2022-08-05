# basic-GAN-MATLAB
This repository holds the source code to a very simple GAN implemented in MATLAB to generate a 4-pixel pattern. The primary purpose is educational so that one can understand the flow of data and cost function optimisation to understand working of a GAN better.

# How to Run and Architecture Details

Given in this repository is a ".mlx" file. That is the main MATLAB script. This code was written using MATLAB R2020b but should be compatible to run with most recent versions. It consists of a very simple Discriminator and Generator architecture for the purpose of generating a 4-pixel pattern. The architecture comprises of shallow perceptron networks and employs the cost function described in the original 2014 paper that introduced GANs. Apart from the main script, there are ".m" function files that are used in the script and therefore should be kept in the same directory as the script to be able to run the script as desired. Steps to Run :
 1. Have a valid MATLAB installation
 2. Download all the files in one directory and import the same into a MATLAB working directory.
 3. To run the script is self explanatory with instructions within the script itself.

# Shortfalls
It is worthwhile to note that the model suffers from mode collapse and is coded out just to serve as an open source educational example on how GANs work, keeping it as simple to understand and re-implement as possible. Improvements and Collaborations are welcome. 
