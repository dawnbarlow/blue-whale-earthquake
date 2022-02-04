
#####################################
# earthquake_measurements.R
# 
# Calculates distance of each earthquake measured in the Geonet database (https://www.GeoNet.org.nz/) from hydrophone locations 
# Merges earthquake measurements from Geonet with acoustic measurements of each earthquake at each hydrophone location
# Saves resulting output file as a .csv with earthquake specs
#
# Dawn Barlow
# Last update: 7 Jan 2022
#
#####################################

library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(geosphere)

setwd("C:/Users/barlowd/Desktop/Box Sync/Documents - BoxSync to desktop/OSU/Blue Whales/Acoustics/earthquakes/manuscript data and code")

# read in specs from geonet dataset (subset to only include earthquakes > magnitute 3.0, and > 8 hrs from another earthquake)
geonet.df <- read.csv("./data/EarthquakeGeonet_subset.csv")

# read in selection table from Raven, with acoustically detected earthquakes from the geonet subset
earthquakedet.df <- read.csv("./data/EarthquakeDetections_RavenSelections.csv")

# read in MARU locations
MARUlocs.df <- read.csv("./data/MARU_locations.csv")
MARUlocs.df

# Calculate distance from earthquake epicenter to each hydrophone
geonet.df$DistMARU1 <- distHaversine(c(173.3425,-39.12288), geonet.df[,4:5])
geonet.df$DistMARU2 <- distHaversine(c(174.2833,-40.03328), geonet.df[,4:5])
geonet.df$DistMARU3 <- distHaversine(c(174.3673,-40.50016), geonet.df[,4:5])
geonet.df$DistMARU4 <- distHaversine(c(173.4003,-40.40010), geonet.df[,4:5])
geonet.df$DistMARU5 <- distHaversine(c(172.1806,-40.09981), geonet.df[,4:5])


# Add magnitude, depth, and distance to earthquakedet.df
red.df <- select(geonet.df, "publicid", "depth", "magnitude")
earthquakedet.df <- merge(earthquakedet.df, red.df, by="publicid", all.x = TRUE)

earthquakedet.df$DistOrigin <- NA

for (i in geonet.df$publicid) {
  
  earthquakedet.df$DistOrigin[earthquakedet.df$Channel==1 & earthquakedet.df$publicid==i] <- geonet.df$DistMARU1[geonet.df$publicid==i]
  earthquakedet.df$DistOrigin[earthquakedet.df$Channel==2 & earthquakedet.df$publicid==i] <- geonet.df$DistMARU2[geonet.df$publicid==i]
  earthquakedet.df$DistOrigin[earthquakedet.df$Channel==3 & earthquakedet.df$publicid==i] <- geonet.df$DistMARU3[geonet.df$publicid==i]
  earthquakedet.df$DistOrigin[earthquakedet.df$Channel==4 & earthquakedet.df$publicid==i] <- geonet.df$DistMARU4[geonet.df$publicid==i]
  earthquakedet.df$DistOrigin[earthquakedet.df$Channel==5 & earthquakedet.df$publicid==i] <- geonet.df$DistMARU5[geonet.df$publicid==i]
  
}


# Write earthquake file including depth, magnitude, dist to origin
write.csv(earthquakedet.df, "./data/EarthquakeSpecs.csv")

