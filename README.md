# Adaptive Grayscale Compressive Spectral Imaging Using Optimal Blue Noise Coding Patterns

#### Authors:
* [Carlos Hinojosa](http://carlosh93.github.io)
* [Nelson Diaz](http://hdspgroup.com/)
* [Henry Arguello](http://hdspgroup.com/)

**Journal:** ELSEVIER, Optics and Laser Technology 

**DOI:** https://doi.org/10.1016/j.optlastec.2019.03.038

**50 days's free access:** https://authors.elsevier.com/c/1YvA76wNUc~EO

## Abstract
Imaging spectroscopy collects the spectral information of a scene by sensing all the spatial information across the electromagnetic wavelengths and are useful for applications in surveillance, agriculture, and medicine, etc. In contrast, compressive spectral imaging (CSI) systems capture compressed projections of the scene, which are then used to recover the whole spectral scene. A key component in such optical systems is the coded aperture which performs the scene codification and defines the sensing scheme of the system. The proper design of the coded aperture entries leads to good quality reconstructions with few compressed measurements. Commonly, the acquired measurements are prone to saturation due to the limited dynamic range of the sensor, however, the saturation is not usually taking into account in the coded aperture design. The saturation errors in compressed measurements are unbounded leading to poor reconstructions since CSI recovery algorithms only provide solutions for bounded or noisy-bounded errors. This paper proposes an adaptive grayscale coded aperture design which combines the advantages of blue noise and block-unblock coding patterns. Blue noise coding patterns are optimal and provide high-quality image reconstructions on regions of non-saturated compressed pixels. On the other hand, the block-unblock coding patterns provide redundancy in the sampling which helps to reduce the saturation in the detector. Further, the saturation is reduced between snapshots by using an adaptive filter which updates the entries of the grayscale coded aperture based on the previously acquired measurements. The proposed coded apertures are optimized such that the number of saturated measurements is minimized. Extensive simulations and an experimental setup were made using the coded aperture snapshot spectral imager (CASSI) sensing scheme, where the results show an improvement up to 2 dB of peak signal-to-noise ratio is achieved when the proposed adaptive grayscale blue noise and block-unblock coded aperture (AGBBCA) design is compared with adaptive grayscale block-unblock coded apertures (AGBCA).

**Keywords:** Compressive Spectral Imaging (CSI), Spectral Imaging Systems, Coded Aperture Design, Grayscale Coded Aperture, Adaptive Imaging, Computational Imaging

## Download
This paper can be downloaded from Carlos Hinojosa homepage http://carlosh93.github.io.

**50 days's free access:** https://authors.elsevier.com/c/1YvA76wNUc~EO

## How to Cite
If you find this code useful in your research, please cite this paper as:

## How to Run the Code
### Download the Databases
Before Run this script please Download the databases, which are freely available from the following websites:
* [Databases from columbia CAVE projects](http://www.cs.columbia.edu/CAVE/databases/multispectral):
  - [beads_ms](http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/beads_ms.zip)
  - [glass_tiles_ms](http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/glass_tiles_ms.zip)
  - [superballs_ms](http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/superballs_ms.zip)
* [Databases from High Dimensiona Signal Processing Group Optics Laboratory at Universidad Industrial de Santander, Colombia](https://github.com/hdspgroup/spectral-image-databases)
  - [Fullflor](https://github.com/hdspgroup/spectral-image-databases/raw/master/data/fullFlor.mat)
  - [OSO_FULL](https://github.com/hdspgroup/spectral-image-databases/raw/master/data/OSO_FULL.mat)
  
After downloading the databases from CAVE Projects, please move the files to the 'Data' folder. Similarly, after downloading the databases from HDSP optics laboratory, place the data in the 'realdata' folder.

### Run Simulations
To perform an example of C-CASSI sensing simulation followed by CSI image reconstruction, open the file 'Run_complete.m.' and specify the database to be used. Finally, run in MATLAB:
```{matlab}
Run_complete.m
```
## License
This code package is licensed under the GNU GENERAL PUBLIC LICENSE (version 3) - see the [LICENSE](https://github.com/carlosh93/Adaptive-Grayscale-CSI-Blue-Noise-Patterns/blob/master/LICENSE) file for details.
