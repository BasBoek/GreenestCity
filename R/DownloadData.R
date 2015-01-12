
DownloadNDVI <- function(location) {
  download.file(url = location, destfile = 'data/modis.zip')
  unzip(zipfile = 'data/modis.zip', exdir = 'data')
}

DownloadCitiesNL <- function(level) {
  nlCity <- getData('GADM',country='NLD', level = level)
}