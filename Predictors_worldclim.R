### LOAD PREDICTORS ###
library(mapview)
library(stringr)

# averages from 1970-2000
?getData
tmin <- getData("worldclim",var="tmin",res=2.5)
tmax <- getData("worldclim",var="tmax",res=2.5)
prec <- getData("worldclim",var="prec",res=2.5)
str(tmin)

# Monthly averages from 2010-2018
?list.files
preclist <- list.files("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_prec_2010-2018/", pattern="*.tif$")
tminlist <- list.files("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmin_2010-2018/", pattern="*.tif$")
tmaxlist <- list.files("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmax_2010-2018/", pattern="*.tif$")

prec <- raster::stack(paste0("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_prec_2010-2018/", preclist))
tmin <- raster::stack(paste0("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmin_2010-2018/", tminlist))
tmax <- raster::stack(paste0("E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmax_2010-2018/", tmaxlist))

## Calculating means for every month

# PRECIPITATION

?grep
?subset
# Creating subsets for each month 
prec01 <- raster::subset(prec, grep(".01", names(prec), fixed=TRUE, value=T))
prec02 <- raster::subset(prec, grep(".02", names(prec), fixed=TRUE, value=T))
prec03 <- raster::subset(prec, grep(".03", names(prec), fixed=TRUE, value=T))
prec04 <- raster::subset(prec, grep(".04", names(prec), fixed=TRUE, value=T))
prec05 <- raster::subset(prec, grep(".05", names(prec), fixed=TRUE, value=T))
prec06 <- raster::subset(prec, grep(".06", names(prec), fixed=TRUE, value=T))
prec07 <- raster::subset(prec, grep(".07", names(prec), fixed=TRUE, value=T))
prec08 <- raster::subset(prec, grep(".08", names(prec), fixed=TRUE, value=T))
prec09 <- raster::subset(prec, grep(".09", names(prec), fixed=TRUE, value=T))
prec10 <- raster::subset(prec, grep(".10", names(prec), fixed=TRUE, value=T))
prec11 <- raster::subset(prec, grep(".11", names(prec), fixed=TRUE, value=T))
prec12 <- raster::subset(prec, grep(".12", names(prec), fixed=TRUE, value=T))
prec12 <- dropLayer(prec12, 10) # 2019 Data should not be considered
names(prec12)

names(prec)
names(prec01)
names(prec02)
names(prec03)
names(prec04)
names(prec05)
names(prec06)
names(prec07)
names(prec08)
names(prec09)
names(prec10)
names(prec11)
names(prec12)

prec01mean <- calc(prec01, mean) # calculating mean -> 1 raster layer
prec02mean <- calc(prec02, mean)
prec03mean <- calc(prec03, mean)
prec04mean <- calc(prec04, mean)
prec05mean <- calc(prec05, mean)
prec06mean <- calc(prec06, mean)
prec07mean <- calc(prec07, mean)
prec08mean <- calc(prec08, mean)
prec09mean <- calc(prec09, mean)
prec10mean <- calc(prec10, mean)
prec11mean <- calc(prec11, mean)
prec12mean <- calc(prec12, mean)

precmean <- stack(prec01mean, prec02mean, prec03mean, prec04mean, prec05mean, prec06mean, prec07mean, prec08mean, prec09mean, prec10mean, prec11mean, prec12mean)



predpath <- "E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
?writeRaster
writeRaster(precmean, "precmean.tif",format="GTiff", overwrite=TRUE)

# MINIMUM TEMPERATURE

# Creating subsets for each month 
tmin01 <- raster::subset(tmin, grep(".01", names(tmin), fixed=TRUE, value=T))
tmin02 <- raster::subset(tmin, grep(".02", names(tmin), fixed=TRUE, value=T))
tmin03 <- raster::subset(tmin, grep(".03", names(tmin), fixed=TRUE, value=T))
tmin04 <- raster::subset(tmin, grep(".04", names(tmin), fixed=TRUE, value=T))
tmin05 <- raster::subset(tmin, grep(".05", names(tmin), fixed=TRUE, value=T))
tmin06 <- raster::subset(tmin, grep(".06", names(tmin), fixed=TRUE, value=T))
tmin07 <- raster::subset(tmin, grep(".07", names(tmin), fixed=TRUE, value=T))
tmin08 <- raster::subset(tmin, grep(".08", names(tmin), fixed=TRUE, value=T))
tmin09 <- raster::subset(tmin, grep(".09", names(tmin), fixed=TRUE, value=T))
tmin10 <- raster::subset(tmin, grep(".10", names(tmin), fixed=TRUE, value=T))
tmin11 <- raster::subset(tmin, grep(".11", names(tmin), fixed=TRUE, value=T))
tmin12 <- raster::subset(tmin, grep(".12", names(tmin), fixed=TRUE, value=T))
tmin12 <- dropLayer(tmin12, 10) # 2019 Data should not be considered
names(tmin12)

names(tmin)
names(tmin01)
names(tmin02)
names(tmin03)
names(tmin04)
names(tmin05)
names(tmin06)
names(tmin07)
names(tmin08)
names(tmin09)
names(tmin10)
names(tmin11)
names(tmin12)

tmin01mean <- calc(tmin01, mean) # calculating mean -> 1 raster layer
tmin02mean <- calc(tmin02, mean)
tmin03mean <- calc(tmin03, mean)
tmin04mean <- calc(tmin04, mean)
tmin05mean <- calc(tmin05, mean)
tmin06mean <- calc(tmin06, mean)
tmin07mean <- calc(tmin07, mean)
tmin08mean <- calc(tmin08, mean)
tmin09mean <- calc(tmin09, mean)
tmin10mean <- calc(tmin10, mean)
tmin11mean <- calc(tmin11, mean)
tmin12mean <- calc(tmin12, mean)
names(tmin12mean)

tminmean <- stack(tmin01mean, tmin02mean, tmin03mean, tmin04mean, tmin05mean, tmin06mean, tmin07mean, tmin08mean, tmin09mean, tmin10mean, tmin11mean, tmin12mean)



predpath <- "E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
?writeRaster
writeRaster(tminmean, "tminmean.tif",format="GTiff", overwrite=TRUE)


# MAXIMUM TEMPERATURE

# Creating subsets for each month 
tmax01 <- raster::subset(tmax, grep(".01", names(tmax), fixed=TRUE, value=T))
tmax02 <- raster::subset(tmax, grep(".02", names(tmax), fixed=TRUE, value=T))
tmax03 <- raster::subset(tmax, grep(".03", names(tmax), fixed=TRUE, value=T))
tmax04 <- raster::subset(tmax, grep(".04", names(tmax), fixed=TRUE, value=T))
tmax05 <- raster::subset(tmax, grep(".05", names(tmax), fixed=TRUE, value=T))
tmax06 <- raster::subset(tmax, grep(".06", names(tmax), fixed=TRUE, value=T))
tmax07 <- raster::subset(tmax, grep(".07", names(tmax), fixed=TRUE, value=T))
tmax08 <- raster::subset(tmax, grep(".08", names(tmax), fixed=TRUE, value=T))
tmax09 <- raster::subset(tmax, grep(".09", names(tmax), fixed=TRUE, value=T))
tmax10 <- raster::subset(tmax, grep(".10", names(tmax), fixed=TRUE, value=T))
tmax11 <- raster::subset(tmax, grep(".11", names(tmax), fixed=TRUE, value=T))
tmax12 <- raster::subset(tmax, grep(".12", names(tmax), fixed=TRUE, value=T))
tmax12 <- dropLayer(tmax12, 10) # 2019 Data should not be considered
names(tmax12)

names(tmax)
names(tmax01)
names(tmax02)
names(tmax03)
names(tmax04)
names(tmax05)
names(tmax06)
names(tmax07)
names(tmax08)
names(tmax09)
names(tmax10)
names(tmax11)
names(tmax12)

tmax01mean <- calc(tmax01, mean) # calculating mean -> 1 raster layer
tmax02mean <- calc(tmax02, mean)
tmax03mean <- calc(tmax03, mean)
tmax04mean <- calc(tmax04, mean)
tmax05mean <- calc(tmax05, mean)
tmax06mean <- calc(tmax06, mean)
tmax07mean <- calc(tmax07, mean)
tmax08mean <- calc(tmax08, mean)
tmax09mean <- calc(tmax09, mean)
tmax10mean <- calc(tmax10, mean)
tmax11mean <- calc(tmax11, mean)
tmax12mean <- calc(tmax12, mean)
names(tmax12mean)

tmaxmean <- stack(tmax01mean, tmax02mean, tmax03mean, tmax04mean, tmax05mean, tmax06mean, tmax07mean, tmax08mean, tmax09mean, tmax10mean, tmax11mean, tmax12mean)



predpath <- "E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
?writeRaster
writeRaster(tmaxmean, "tmaxmean.tif",format="GTiff", overwrite=TRUE)


## Future climate projections
?getData

getData("")

