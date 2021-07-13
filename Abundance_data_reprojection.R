rm(list=ls())

library(raster)
library(dismo)
library(sf)
library(sp)
library(mapview)

predfinpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors_finished/"
abundancepath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Abundance_data/"


# PROJECT OCCURRENCE COORDINATES

ww <- read.csv2(paste0(abundancepath, "willow_warbler_2020_Europe_prep_and_clean.csv"), header=T, sep=";")

currentclim <- raster::stack(paste0(predfinpath, "currentclim.grd"))

?spTransform
coordinates(ww)=~LONGITUDE+LATITUDE
proj4string(ww) <- crs("+init=epsg:4326")
wwETRS <- spTransform(ww, crs(currentclim))

?coordinates

# ADD PROJECTED LONGITUDE LATITUDE COLUMNS

wwlonlat <- data.frame(wwETRS)

names(wwlonlat)

# CREATE SUBSET WITH ONLY LONGITUDE AND LATITUDE COLUMNS

names(wwlonlat)
plot(currentclim$Prec.1)

?subset
wwsdm <- subset(wwlonlat, select=c("LONGITUDE", "LATITUDE"))
names(wwsdm)
head(wwsdm)
points(wwsdm$LONGITUDE, wwsdm$LATITUDE, col="orange", pch=20, cex=0.75)
points(wwsdm$LONGITUDE, wwsdm$LATITUDE, col="red", cex=0.75)

# SAVE DATAFRAME

?saveRDS

setwd(abundancepath)

saveRDS(wwsdm, "wwfin.RDS")

wwsdm <- readRDS(paste0(abundancepath, "wwfin.RDS"))











