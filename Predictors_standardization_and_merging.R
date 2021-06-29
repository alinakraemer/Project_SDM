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

# current

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



# future

library(raster)
library(dismo)
library(sf)
library(mapview)

# Loading predictors

gadmpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/GADM_Europa/"
predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
corpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Corine Land Cover/DATA/"

Prec245 <- stack(paste0(predpath, "Prec245.grd"))
Prec370 <- stack(paste0(predpath, "Prec370.grd"))
Tmax245 <- stack(paste0(predpath, "Tmax245.grd"))
Tmax370 <- stack(paste0(predpath, "Tmax370.grd"))
Tmin245 <- stack(paste0(predpath, "Tmin245.grd"))
Tmin370 <- stack(paste0(predpath, "Tmin370.grd"))

# rastertemplate

climmean <- stack(paste0(predpath, "climmeanfin.grd"))

precmean <- stack(paste0(predpath, "precmean.grd"))

rastemplate <- projectRaster(climmean, crs=crs(precmean))

# crop

Prec245crop <- crop(Prec245, rastemplate)
Prec370crop <- crop(Prec370, rastemplate)
Tmax245crop <- crop(Tmax245, rastemplate)
Tmax370crop <- crop(Tmax370, rastemplate)
Tmin245crop <- crop(Tmin245, rastemplate)
Tmin370crop <- crop(Tmin370, rastemplate)

# project

Prec245ETRS <- projectRaster(Prec245crop, crs="+init=epsg:3035")
Prec370ETRS <- projectRaster(Prec370crop, crs="+init=epsg:3035")
Tmax245ETRS <- projectRaster(Tmax245crop, crs="+init=epsg:3035")
Tmax370ETRS <- projectRaster(Tmax370crop, crs="+init=epsg:3035")
Tmin245ETRS <- projectRaster(Tmin245crop, crs="+init=epsg:3035")
Tmin370ETRS <- projectRaster(Tmin370crop, crs="+init=epsg:3035")

setwd(predpath)
writeRaster(Prec245ETRS, "Prec245ETRS.grd", overwrite=TRUE)
writeRaster(Prec370ETRS, "Prec370ETRS.grd", overwrite=TRUE)
writeRaster(Tmax245ETRS, "Tmax245ETRS.grd", overwrite=TRUE)
writeRaster(Tmax370ETRS, "Tmax370ETRS.grd", overwrite=TRUE)
writeRaster(Tmin245ETRS, "Tmin245ETRS.grd", overwrite=TRUE)
writeRaster(Tmin370ETRS, "Tmin370ETRS.grd", overwrite=TRUE)

futureclimETRS <- raster::stack(Prec245ETRS, Prec370ETRS, Tmax245ETRS, Tmax370ETRS, Tmin245ETRS, Tmin370ETRS)

writeRaster(futureclimETRS, "futureclimETRS.grd", overwrite=TRUE)

# resample


Prec245fin <- resample(Prec245ETRS, climmean)
Prec370fin <- resample(Prec370ETRS, climmean)
Tmax245fin <- resample(Tmax245ETRS, climmean)
Tmax370fin <- resample(Tmax370ETRS, climmean)
Tmin245fin <- resample(Tmin245ETRS, climmean)
Tmin370fin <- resample(Tmin370ETRS, climmean)



futureclim245 <- raster::stack(Prec245fin, Tmax245fin, Tmin245fin)
futureclim370 <- raster::stack(Prec370fin, Tmax370fin, Tmin370fin)

setwd(predpath)
writeRaster(futureclim245, "futureclim245.grd", overwrite=TRUE)
writeRaster(futureclim370, "futureclim370.grd", overwrite=TRUE)

