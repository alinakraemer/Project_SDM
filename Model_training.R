rm(list=ls())

library(raster)
library(dismo)
library(rJava)
library(sf)
library(sp)
library(mapview)

predfinpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors_finished/"
abundancepath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Abundance_data/"


# LOAD DATA
?readRDS
ww <- readRDS(paste0(abundancepath, "wwfin.RDS"))

currentclimstack <- raster::stack(paste0(predfinpath, "currentclimstack.grd"))

# MODEL TRAINING

?maxent
sdm <- maxent(currentclimstack, ww, factors=37, removeDuplicates=TRUE)

sdmcurrent <- predict(sdm, currentclimstack)

plot(sdmcurrent)


# PREDICTION

futureclim245stack <- raster::stack(paste0(predfinpath, "futureclim245stack.grd"))
futureclim370stack <- raster::stack(paste0(predfinpath, "futureclim370stack.grd"))

names(futureclim245)
names(futureclim370)
sdm245 <- predict(sdm, futureclim245stack)
sdm370 <- predict(sdm, futureclim370stack)

plot(sdm245)
plot(sdm370)
