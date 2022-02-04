# blue-whale-earthquake

This repository contains code and data necessary to generate the analyses and figures associated with the following manuscript: 

Barlow, D. R., Estrada Jorge, M., Klinck, H., & Torres, L. G. (in submission). Shaken, not stirred: blue whales show no acoustic response to earthquake events. 


# In this repository: 

- earthquake_measurements.R: This script calculates distance of earthquake measured in the Geonet database (https://www.GeoNet.org.nz/) from hydrophone locations, merges earthquake measurements from Geonet with acoustic measurements of each earthquake at each hydrophone location, and saves resulting output file as a .csv with earthquake specs.
-  calling_earthquakes.Rmd: This script contains all analyses of blue whale calling activity before and after earthquake and null events, including all statistical comparisons and data visualization. 
- data: This folder contains data files needed to run scripts and produce plots.
