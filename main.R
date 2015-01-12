# Team Bastei
# January 12, 2015

library(raster)
library(rgdal)
library(sp)

source('R/DownloadData.R')

# Download monthly modis NDVI data or The Netherlands
DownloadNDVI('https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip')

NDVImonth <- brick('data/MOD13A3.A2014001.h18v03.005.grd')

# Creating NDVI yearly average of the Netherlands
meanNDVI <- mean(NDVImonth)
allNDVI <- stack(NDVImonth, meanNDVI)
names(allNDVI)[13] <- paste('Mean_NDVI')

# Download municipalities of the Netherlands
Cities <- DownloadCitiesNL(3)

# Change projection
City_newCRS <- spTransform(Cities, CRS(proj4string(allNDVI)))

source('R/GreenPerCity.R')

# Extracting mean NDVI/month/City (Please take a coffee...)
GreenCity <- GreenPerCity(allNDVI, City_newCRS)

# Creating Dataframe (not spatial) for subsetting
GreenDF <- GreenCity@data

source('R/GreenestCity.R')

### Examples of determining the greenest city of the Netherlands for a month or averaged over the year
print(Greenest_Jan <- GreenestCity('January'))
print(Greenest_Jun <- GreenestCity('June'))
print(Greenest_Nov <- GreenestCity('November'))
print(Greenest_ALL <- GreenestCity('Mean_NDVI'))   # <- MEAN OVER THE YEAR!  # # # Greenest City EVER # # #

### Please try it yourself!!! (first uncomment next line and fill in month of your choice)
# GreenestMonthCity <- GreenestCity('ENTER__MONTH')

# Plot March NDVI average per municipality
spplot(GreenCity['March'], main=list(label="NDVI March",cex=3))
spplot(GreenCity['November'], main=list(label="NDVI November",cex=3))
spplot(GreenCity['Mean_NDVI'], main=list(label="NDVI YEAR_AVG",cex=3))


