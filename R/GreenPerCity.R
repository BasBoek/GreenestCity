GreenPerCity <- function(raster, vector){
  extract(x = raster, y = vector, fun=mean, na.rm=TRUE, sp = TRUE)

}