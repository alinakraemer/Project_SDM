rm(list=ls())

library(raster)
library(dismo)
library(sf)
library(mapview)

# Loading predictors

gadmpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/GADM_Europa/"
predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
corpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Corine Land Cover/DATA/"

# In ETRS89 umprojizieren
# WORLDCLIM

precmean <- stack(paste0(predpath, "precmean.grd"))
tmaxmean <- stack(paste0(predpath, "tmaxmean.grd"))
tminmean <- stack(paste0(predpath, "tminmean.grd"))

precmeanETRS <- projectRaster(precmean, crs="+init=epsg:3035")
tmaxmeanETRS <- projectRaster(tmaxmean, crs="+init=epsg:3035")
tminmeanETRS <- projectRaster(tminmean, crs="+init=epsg:3035")
plot(tmaxmeanETRS)

plot(precmeanETRS)

setwd(predpath)
writeRaster(precmeanETRS, "precmeanETRS.grd", overwrite=TRUE)
writeRaster(tmaxmeanETRS, "tmaxmeanETRS.grd", overwrite=TRUE)
writeRaster(tminmeanETRS, "tminmeanETRS.grd", overwrite=TRUE)

climmeanETRS <- raster::stack(precmeanETRS, tmaxmeanETRS, tminmeanETRS)

setwd(predpath)
writeRaster(climmeanETRS, "climmeanETRS.grd", overwrite=TRUE)

crs(climmeanWGS)
res(climmeanWGS)

# CORINE LAND COVER

cor <- raster(paste0(corpath, "U2018_CLC2018_V2020_20u1.tif"))
res(cor)
crs(cor)

# Creating Rastertemplate
precmeanETRS <- stack(paste0(predpath, "precmeanETRS.grd"))
tmaxmeanETRS <- stack(paste0(predpath, "tmaxmeanETRS.grd"))
tminmeanETRS <- stack(paste0(predpath, "tminmeanETRS.grd"))

climmeanETRS <- raster::stack(paste0(predpath, "climmeanETRS.grd"))

rastemplate <- raster(ext = extent(cor), crs = crs(cor), resolution = c(10000, 10000))

# Cropping

precmeancrop <- crop(precmeanETRS, cor)
tmaxmeancrop <- crop(tmaxmeanETRS, cor)
tminmeancrop <- crop(tminmeanETRS, cor)

# Resampling
?resample
precmeanfin <- resample(precmeancrop, rastemplate)
tmaxmeanfin <- resample(tmaxmeancrop, rastemplate)
tminmeanfin <- resample(tminmeancrop, rastemplate)

climmeanfin <- raster::stack(precmeanfin, tmaxmeanfin, tminmeanfin)

setwd(predpath)
writeRaster(climmeanfin, "climmeanfin.grd", overwrite=TRUE)



