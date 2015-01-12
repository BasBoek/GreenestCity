# Team Bastei
# January 12, 2015

library(raster)
library(rgdal)

source('DownloadData.R')

# Download monthly modis NDVI data or The Netherlands
DownloadNDVI('https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip')


NDVImonth <- brick('data/MOD13A3.A2014001.h18v03.005.grd')
plot(NDVImonth)

# Download municipalities of the Netherlands
Cities <- DownloadCitiesNL(3)

# Change projection
City_newCRS <- spTransform(Cities, CRS(proj4string(NDVImonth)))

# Mask The Netherlands
NDVImonthNL <- mask(NDVImonth, City_newCRS)

# Creating NDVI yearly average of the Netherlands
meanNDVI <- mean(NDVImonth)


