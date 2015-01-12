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
Greeny <- GreenPerCity(allNDVI[[1:2]], City_newCRS)
class(Greeny)
names(Greeny)
spplot(Greeny[19])

City_newCRS@data <- data.frame(City_newCRS@data, Greeny)

CityGreen <- merge(Greeny[[1:2]], City_newCRS)
class(City_newCRS)
head(City_newCRS)

#GreenCities <- City_newCRS[,8]
# City_newCRS[[15]] <- Greeny
# City_newCRS
# names(City_newCRS)[8] <- paste('City')
# names(City_newCRS)[15] <- paste('meanNDVI')
# head(City_newCRS)

spplot(City_newCRS[15])
