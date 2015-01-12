GreenestCity <- function(month){
  City <- subset(GreenDF, subset = GreenDF[,month] == max(GreenDF[,month]) , na.rm=TRUE)
  CityGr <- City$NAME_2
  return(CityGr)
}


