A single-layer Random Forest model for voxel classification (volume segmentation).


This code is based on https://github.com/HMS-IDAC/PixelClassifier, with straightforward extensions to 3D, and a bit more parallelization.

The main scripts are:
voxelClassifierTrain, used to train the model, and
voxelClassifier, used to segment volumes after the model is trained.
See those files for details and parameters to set.

Labels/annotations can be created with VolumeAnnotationBot, available at https://www.mathworks.com/matlabcentral/fileexchange/64718-volumeannotationbot

A sample dataset for a running demo is available at https://www.dropbox.com/s/zzjzpvpxro5dgd4/DataForVC.zip?dl=0
(Subset of original data acquired by Michael Weber, https://www.linkedin.com/in/webermic/, at the Nikon Imaging Center, http://nic.med.harvard.edu)

This code uses 3-D steerable filters for feature detection, developed by Francois Aguet, available at http://www.francoisaguet.net/software.html
It also uses code for platonic solid vertices (in computing offset features), adapted from code by Kevin Mattheus Moerman: https://www.mathworks.com/matlabcentral/fileexchange/28213-platonic-solid

Dependency: this software requires the bfmatlab toolbox to read stacks, available at http://downloads.openmicroscopy.org/bio-formats/5.3.4/

Developed by:
Marcelo Cicconet
marceloc.net