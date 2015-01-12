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
names(City_newCRS)

# Mask The Netherlands
# NDVImonthNL <- mask(NDVImonth, City_newCRS)

plot(allNDVI)

source('R/GreenPerCity.R')

# Extracting mean NDVI/month/City
GreenCity <- GreenPerCity(allNDVI, City_newCRS)

# Creating Dataframe (not spatial) for subsetting
GreenDF <- GreenCity@data

### Examples of determining the greenest city of the Netherlands for a month or averaged over the year
Greenest_Jan <- GreenestCity('January')
Greenest_Jun <- GreenestCity('June')
Greenest_Nov <- GreenestCity('November')
Greenest_ALL <- GreenestCity('Mean_NDVI')   # <- MEAN OVER THE YEAR!

    # # # Greenest City EVER # # #
         print(Greenest_ALL)

### Please try it yourself!!! (first uncomment next line and fill in month of your choice)
# GreenestMonthCity <- GreenestCity('ENTER__MONTH')

# Plot March NDVI average per municipality
spplot(GreenCity['March'], main=list(label="March",cex=3))
spplot(GreenCity['November'], main=list(label="November",cex=3))
spplot(GreenCity['Mean_NDVI'], main=list(label="YEAR_AVG",cex=3))


