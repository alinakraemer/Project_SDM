library(raster)
rm(list=ls())

abundancepath <- "E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Abundance_data/"

ww <- read.csv2(paste0(abundancepath, "willow_warbler_2020_Europe_prep_and_clean.csv"), header=T, sep=";")


## RASTERIZING
?raster
?extent
europe <- extent()


ras <- raster((ext = europe?), crs = , resolution =, template= EuropaGDAL)

abundras <- rasterize(ww, ras, ...)




## SWITCHING CRS FROM WGS TO ETRS

## Formatting latitude and longitude data

coordinates(wwnd) <- ~LONGITUDE+LATITUDE
crs(wwnd) <- crs(wrld_simpl)


