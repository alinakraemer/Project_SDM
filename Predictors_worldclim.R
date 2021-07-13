### LOAD PREDICTORS ###
rm(list=ls())
library(raster)
library(mapview)
library(stringr)

# Monthly averages from 2010-2018
?list.files
preclist <- list.files("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_prec_2010-2018/", pattern="*.tif$")
tminlist <- list.files("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmin_2010-2018/", pattern="*.tif$")
tmaxlist <- list.files("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmax_2010-2018/", pattern="*.tif$")

prec <- raster::stack(paste0("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_prec_2010-2018/", preclist))
tmin <- raster::stack(paste0("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmin_2010-2018/", tminlist))
tmax <- raster::stack(paste0("E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Current_climate/wc2.1_2.5m_tmax_2010-2018/", tmaxlist))

## Calculating means for every month

# PRECIPITATION

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
names(precmean) <- paste("Prec", substr(names(precmean), 7, 9))

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(precmean, "precmean.grd",format="raster", overwrite=TRUE)

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
names(tminmean) <- paste("Tmin", substr(names(tminmean), 7, 9))
names(tminmean)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(tminmean, "tminmean.grd",format="raster", overwrite=TRUE)

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
names(tmaxmean) <- paste("Tmax", substr(names(tmaxmean), 7, 9))

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(tmaxmean, "tmaxmean.grd",format="raster", overwrite=TRUE)


## Future climate projections
?getData

rm(list=ls())

library(raster)
library(mapview)
library(stringr)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"

BCCpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/BCC-CSM2-MR/"
Canpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/CanESM5/"
CM6path <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/CNRM-CM6-1/"
ESM2path <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/CNRM-ESM2-1/"
IPSLpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/IPSL-CM6A-LR/"
ROCpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/MIROC_ES2L/"
ROC6path <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/MIROC6/"
MRIpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/WorldClim/Future_climate/MRI-ESM2-0/"

## PRECIPITATION

# 245-SCENARIO

BCCprec245 <- stack(paste0(BCCpath, "wc2.1_2.5m_prec_BCC-CSM2-MR_ssp245_2041-2060.tif"))
Canprec245 <- stack(paste0(Canpath, "wc2.1_2.5m_prec_CanESM5_ssp245_2041-2060.tif"))
CM6prec245 <- stack(paste0(CM6path, "wc2.1_2.5m_prec_CNRM-CM6-1_ssp245_2041-2060.tif"))
ESM2prec245 <- stack(paste0(ESM2path, "wc2.1_2.5m_prec_CNRM-ESM2-1_ssp245_2041-2060.tif"))
IPSLprec245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_prec_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
ROCprec245 <- stack(paste0(ROCpath, "wc2.1_2.5m_prec_MIROC-ES2L_ssp245_2041-2060.tif"))
ROC6prec245 <- stack(paste0(ROC6path, "wc2.1_2.5m_prec_MIROC6_ssp245_2041-2060.tif"))
MRIprec245 <- stack(paste0(MRIpath, "wc2.1_2.5m_prec_MRI-ESM2-0_ssp245_2041-2060.tif"))

Prec245 <- stack(BCCprec245, Canprec245, CM6prec245, ESM2prec245, IPSLprec245, ROCprec245, ROC6prec245, MRIprec245)

Prec245Jan <- raster::subset(Prec245, grep("2060.1$", names(Prec245), value=T))
Prec245Feb <- raster::subset(Prec245, grep("2060.2$", names(Prec245), value=T))
Prec245Mar <- raster::subset(Prec245, grep("2060.3$", names(Prec245), value=T))
Prec245Apr <- raster::subset(Prec245, grep("2060.4$", names(Prec245), value=T))
Prec245May <- raster::subset(Prec245, grep("2060.5$", names(Prec245), value=T))
Prec245Jun <- raster::subset(Prec245, grep("2060.6$", names(Prec245), value=T))
Prec245Jul <- raster::subset(Prec245, grep("2060.7$", names(Prec245), value=T))
Prec245Aug <- raster::subset(Prec245, grep("2060.8$", names(Prec245), value=T))
Prec245Sep <- raster::subset(Prec245, grep("2060.9$", names(Prec245), value=T))
Prec245Oct <- raster::subset(Prec245, grep("2060.10$", names(Prec245), value=T))
Prec245Nov <- raster::subset(Prec245, grep("2060.11$", names(Prec245), value=T))
Prec245Dec <- raster::subset(Prec245, grep("2060.12$", names(Prec245), value=T))

names(Prec245Jan)
names(Prec245Feb)
names(Prec245Mar)
names(Prec245Apr)
names(Prec245May)
names(Prec245Jun)
names(Prec245Jul)
names(Prec245Aug)
names(Prec245Sep)
names(Prec245Oct)
names(Prec245Nov)
names(Prec245Dec)

?stackApply
plot(Prec245Jan)
Prec245Janmean <- calc(Prec245Jan, mean)
Prec245Febmean <- calc(Prec245Feb, mean)
Prec245Marmean <- calc(Prec245Mar, mean)
Prec245Aprmean <- calc(Prec245Apr, mean)
Prec245Maymean <- calc(Prec245May, mean)
Prec245Junmean <- calc(Prec245Jun, mean)
Prec245Julmean <- calc(Prec245Jul, mean)
Prec245Augmean <- calc(Prec245Aug, mean)
Prec245Sepmean <- calc(Prec245Sep, mean)
Prec245Octmean <- calc(Prec245Oct, mean)
Prec245Novmean <- calc(Prec245Nov, mean)
Prec245Decmean <- calc(Prec245Dec, mean)

Prec245fin <- stack(Prec245Janmean, Prec245Febmean, Prec245Marmean, Prec245Aprmean, Prec245Maymean, Prec245Junmean, Prec245Julmean, Prec245Augmean, Prec245Sepmean, Prec245Octmean, Prec245Novmean, Prec245Decmean)
names(Prec245fin) <- paste("Prec", substr(names(Prec245fin), 7, 9))

plot(Prec245fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Prec245fin, "Prec245.grd",format="raster", overwrite=TRUE)



# 370-SCENARIO

BCCprec370 <- stack(paste0(BCCpath, "wc2.1_2.5m_prec_BCC-CSM2-MR_ssp370_2041-2060.tif"))
Canprec370 <- stack(paste0(Canpath, "wc2.1_2.5m_prec_CanESM5_ssp370_2041-2060.tif"))
CM6prec370 <- stack(paste0(CM6path, "wc2.1_2.5m_prec_CNRM-CM6-1_ssp370_2041-2060.tif"))
ESM2prec370 <- stack(paste0(ESM2path, "wc2.1_2.5m_prec_CNRM-ESM2-1_ssp370_2041-2060.tif"))
IPSLprec370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_prec_IPSL-CM6A-LR_ssp370_2041-2060.tif"))
ROCprec370 <- stack(paste0(ROCpath, "wc2.1_2.5m_prec_MIROC-ES2L_ssp370_2041-2060.tif"))
ROC6prec370 <- stack(paste0(ROC6path, "wc2.1_2.5m_prec_MIROC6_ssp370_2041-2060.tif"))
MRIprec370 <- stack(paste0(MRIpath, "wc2.1_2.5m_prec_MRI-ESM2-0_ssp370_2041-2060.tif"))

Prec370 <- stack(BCCprec370, Canprec370, CM6prec370, ESM2prec370, IPSLprec370, ROCprec370, ROC6prec370, MRIprec370)

Prec370Jan <- raster::subset(Prec370, grep("2060.1$", names(Prec370), value=T))
Prec370Feb <- raster::subset(Prec370, grep("2060.2$", names(Prec370), value=T))
Prec370Mar <- raster::subset(Prec370, grep("2060.3$", names(Prec370), value=T))
Prec370Apr <- raster::subset(Prec370, grep("2060.4$", names(Prec370), value=T))
Prec370May <- raster::subset(Prec370, grep("2060.5$", names(Prec370), value=T))
Prec370Jun <- raster::subset(Prec370, grep("2060.6$", names(Prec370), value=T))
Prec370Jul <- raster::subset(Prec370, grep("2060.7$", names(Prec370), value=T))
Prec370Aug <- raster::subset(Prec370, grep("2060.8$", names(Prec370), value=T))
Prec370Sep <- raster::subset(Prec370, grep("2060.9$", names(Prec370), value=T))
Prec370Oct <- raster::subset(Prec370, grep("2060.10$", names(Prec370), value=T))
Prec370Nov <- raster::subset(Prec370, grep("2060.11$", names(Prec370), value=T))
Prec370Dec <- raster::subset(Prec370, grep("2060.12$", names(Prec370), value=T))

names(Prec370Jan)
names(Prec370Feb)
names(Prec370Mar)
names(Prec370Apr)
names(Prec370May)
names(Prec370Jun)
names(Prec370Jul)
names(Prec370Aug)
names(Prec370Sep)
names(Prec370Oct)
names(Prec370Nov)
names(Prec370Dec)

Prec370Janmean <- calc(Prec370Jan, mean)
Prec370Febmean <- calc(Prec370Feb, mean)
Prec370Marmean <- calc(Prec370Mar, mean)
Prec370Aprmean <- calc(Prec370Apr, mean)
Prec370Maymean <- calc(Prec370May, mean)
Prec370Junmean <- calc(Prec370Jun, mean)
Prec370Julmean <- calc(Prec370Jul, mean)
Prec370Augmean <- calc(Prec370Aug, mean)
Prec370Sepmean <- calc(Prec370Sep, mean)
Prec370Octmean <- calc(Prec370Oct, mean)
Prec370Novmean <- calc(Prec370Nov, mean)
Prec370Decmean <- calc(Prec370Dec, mean)

Prec370fin <- stack(Prec370Janmean, Prec370Febmean, Prec370Marmean, Prec370Aprmean, Prec370Maymean, Prec370Junmean, Prec370Julmean, Prec370Augmean, Prec370Sepmean, Prec370Octmean, Prec370Novmean, Prec370Decmean)
names(Prec370fin) <- paste("Prec", substr(names(Prec370fin), 7, 9))
names(Prec370fin)

plot(Prec370fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Prec370fin, "Prec370.grd",format="raster", overwrite=TRUE)

## TMAX

# 245-SCENARIO

BCCtmax245 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmax_BCC-CSM2-MR_ssp245_2041-2060.tif"))
Cantmax245 <- stack(paste0(Canpath, "wc2.1_2.5m_tmax_CanESM5_ssp245_2041-2060.tif"))
CM6tmax245 <- stack(paste0(CM6path, "wc2.1_2.5m_tmax_CNRM-CM6-1_ssp245_2041-2060.tif"))
ESM2tmax245 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmax_CNRM-ESM2-1_ssp245_2041-2060.tif"))
IPSLtmax245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmax_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
ROCtmax245 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmax_MIROC-ES2L_ssp245_2041-2060.tif"))
ROC6tmax245 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmax_MIROC6_ssp245_2041-2060.tif"))
MRItmax245 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmax_MRI-ESM2-0_ssp245_2041-2060.tif"))

Tmax245 <- stack(BCCtmax245, Cantmax245, CM6tmax245, ESM2tmax245, IPSLtmax245, ROCtmax245, ROC6tmax245, MRItmax245)

Tmax245Jan <- raster::subset(Tmax245, grep("2060.1$", names(Tmax245), value=T))
Tmax245Feb <- raster::subset(Tmax245, grep("2060.2$", names(Tmax245), value=T))
Tmax245Mar <- raster::subset(Tmax245, grep("2060.3$", names(Tmax245), value=T))
Tmax245Apr <- raster::subset(Tmax245, grep("2060.4$", names(Tmax245), value=T))
Tmax245May <- raster::subset(Tmax245, grep("2060.5$", names(Tmax245), value=T))
Tmax245Jun <- raster::subset(Tmax245, grep("2060.6$", names(Tmax245), value=T))
Tmax245Jul <- raster::subset(Tmax245, grep("2060.7$", names(Tmax245), value=T))
Tmax245Aug <- raster::subset(Tmax245, grep("2060.8$", names(Tmax245), value=T))
Tmax245Sep <- raster::subset(Tmax245, grep("2060.9$", names(Tmax245), value=T))
Tmax245Oct <- raster::subset(Tmax245, grep("2060.10$", names(Tmax245), value=T))
Tmax245Nov <- raster::subset(Tmax245, grep("2060.11$", names(Tmax245), value=T))
Tmax245Dec <- raster::subset(Tmax245, grep("2060.12$", names(Tmax245), value=T))

names(Tmax245Jan)
names(Tmax245Feb)
names(Tmax245Mar)
names(Tmax245Apr)
names(Tmax245May)
names(Tmax245Jun)
names(Tmax245Jul)
names(Tmax245Aug)
names(Tmax245Sep)
names(Tmax245Oct)
names(Tmax245Nov)
names(Tmax245Dec)

plot(Tmax245Jan)
Tmax245Janmean <- calc(Tmax245Jan, mean)
Tmax245Febmean <- calc(Tmax245Feb, mean)
Tmax245Marmean <- calc(Tmax245Mar, mean)
Tmax245Aprmean <- calc(Tmax245Apr, mean)
Tmax245Maymean <- calc(Tmax245May, mean)
Tmax245Junmean <- calc(Tmax245Jun, mean)
Tmax245Julmean <- calc(Tmax245Jul, mean)
Tmax245Augmean <- calc(Tmax245Aug, mean)
Tmax245Sepmean <- calc(Tmax245Sep, mean)
Tmax245Octmean <- calc(Tmax245Oct, mean)
Tmax245Novmean <- calc(Tmax245Nov, mean)
Tmax245Decmean <- calc(Tmax245Dec, mean)

Tmax245fin <- stack(Tmax245Janmean, Tmax245Febmean, Tmax245Marmean, Tmax245Aprmean, Tmax245Maymean, Tmax245Junmean, Tmax245Julmean, Tmax245Augmean, Tmax245Sepmean, Tmax245Octmean, Tmax245Novmean, Tmax245Decmean)
names(Tmax245fin) <- paste("Tmax", substr(names(Tmax245fin), 7, 9))
names(Tmax245fin)

plot(Tmax245fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Tmax245fin, "Tmax245.grd",format="raster", overwrite=TRUE)

# 370-SCENARIO

BCCtmax370 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmax_BCC-CSM2-MR_ssp370_2041-2060.tif"))
Cantmax370 <- stack(paste0(Canpath, "wc2.1_2.5m_tmax_CanESM5_ssp370_2041-2060.tif"))
CM6tmax370 <- stack(paste0(CM6path, "wc2.1_2.5m_tmax_CNRM-CM6-1_ssp370_2041-2060.tif"))
ESM2tmax370 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmax_CNRM-ESM2-1_ssp370_2041-2060.tif"))
IPSLtmax370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmax_IPSL-CM6A-LR_ssp370_2041-2060.tif"))
ROCtmax370 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmax_MIROC-ES2L_ssp370_2041-2060.tif"))
ROC6tmax370 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmax_MIROC6_ssp370_2041-2060.tif"))
MRItmax370 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmax_MRI-ESM2-0_ssp370_2041-2060.tif"))

Tmax370 <- stack(BCCtmax370, Cantmax370, CM6tmax370, ESM2tmax370, IPSLtmax370, ROCtmax370, ROC6tmax370, MRItmax370)

Tmax370Jan <- raster::subset(Tmax370, grep("2060.1$", names(Tmax370), value=T))
Tmax370Feb <- raster::subset(Tmax370, grep("2060.2$", names(Tmax370), value=T))
Tmax370Mar <- raster::subset(Tmax370, grep("2060.3$", names(Tmax370), value=T))
Tmax370Apr <- raster::subset(Tmax370, grep("2060.4$", names(Tmax370), value=T))
Tmax370May <- raster::subset(Tmax370, grep("2060.5$", names(Tmax370), value=T))
Tmax370Jun <- raster::subset(Tmax370, grep("2060.6$", names(Tmax370), value=T))
Tmax370Jul <- raster::subset(Tmax370, grep("2060.7$", names(Tmax370), value=T))
Tmax370Aug <- raster::subset(Tmax370, grep("2060.8$", names(Tmax370), value=T))
Tmax370Sep <- raster::subset(Tmax370, grep("2060.9$", names(Tmax370), value=T))
Tmax370Oct <- raster::subset(Tmax370, grep("2060.10$", names(Tmax370), value=T))
Tmax370Nov <- raster::subset(Tmax370, grep("2060.11$", names(Tmax370), value=T))
Tmax370Dec <- raster::subset(Tmax370, grep("2060.12$", names(Tmax370), value=T))

names(Tmax370Jan)
names(Tmax370Feb)
names(Tmax370Mar)
names(Tmax370Apr)
names(Tmax370May)
names(Tmax370Jun)
names(Tmax370Jul)
names(Tmax370Aug)
names(Tmax370Sep)
names(Tmax370Oct)
names(Tmax370Nov)
names(Tmax370Dec)

plot(Tmax370Jan)
Tmax370Janmean <- calc(Tmax370Jan, mean)
Tmax370Febmean <- calc(Tmax370Feb, mean)
Tmax370Marmean <- calc(Tmax370Mar, mean)
Tmax370Aprmean <- calc(Tmax370Apr, mean)
Tmax370Maymean <- calc(Tmax370May, mean)
Tmax370Junmean <- calc(Tmax370Jun, mean)
Tmax370Julmean <- calc(Tmax370Jul, mean)
Tmax370Augmean <- calc(Tmax370Aug, mean)
Tmax370Sepmean <- calc(Tmax370Sep, mean)
Tmax370Octmean <- calc(Tmax370Oct, mean)
Tmax370Novmean <- calc(Tmax370Nov, mean)
Tmax370Decmean <- calc(Tmax370Dec, mean)

Tmax370fin <- stack(Tmax370Janmean, Tmax370Febmean, Tmax370Marmean, Tmax370Aprmean, Tmax370Maymean, Tmax370Junmean, Tmax370Julmean, Tmax370Augmean, Tmax370Sepmean, Tmax370Octmean, Tmax370Novmean, Tmax370Decmean)
names(Tmax370fin) <- paste("Tmax", substr(names(Tmax370fin), 7, 9))
names(Tmax370fin)

plot(Tmax370fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Tmax370fin, "Tmax370.grd",format="raster", overwrite=TRUE)

## TMIN

# 245-SCENARIO

BCCtmin245 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmin_BCC-CSM2-MR_ssp245_2041-2060.tif"))
Cantmin245 <- stack(paste0(Canpath, "wc2.1_2.5m_tmin_CanESM5_ssp245_2041-2060.tif"))
CM6tmin245 <- stack(paste0(CM6path, "wc2.1_2.5m_tmin_CNRM-CM6-1_ssp245_2041-2060.tif"))
ESM2tmin245 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmin_CNRM-ESM2-1_ssp245_2041-2060.tif"))
IPSLtmin245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmin_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
ROCtmin245 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmin_MIROC-ES2L_ssp245_2041-2060.tif"))
ROC6tmin245 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmin_MIROC6_ssp245_2041-2060.tif"))
MRItmin245 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmin_MRI-ESM2-0_ssp245_2041-2060.tif"))

Tmin245 <- stack(BCCtmin245, Cantmin245, CM6tmin245, ESM2tmin245, IPSLtmin245, ROCtmin245, ROC6tmin245, MRItmin245)

Tmin245Jan <- raster::subset(Tmin245, grep("2060.1$", names(Tmin245), value=T))
Tmin245Feb <- raster::subset(Tmin245, grep("2060.2$", names(Tmin245), value=T))
Tmin245Mar <- raster::subset(Tmin245, grep("2060.3$", names(Tmin245), value=T))
Tmin245Apr <- raster::subset(Tmin245, grep("2060.4$", names(Tmin245), value=T))
Tmin245May <- raster::subset(Tmin245, grep("2060.5$", names(Tmin245), value=T))
Tmin245Jun <- raster::subset(Tmin245, grep("2060.6$", names(Tmin245), value=T))
Tmin245Jul <- raster::subset(Tmin245, grep("2060.7$", names(Tmin245), value=T))
Tmin245Aug <- raster::subset(Tmin245, grep("2060.8$", names(Tmin245), value=T))
Tmin245Sep <- raster::subset(Tmin245, grep("2060.9$", names(Tmin245), value=T))
Tmin245Oct <- raster::subset(Tmin245, grep("2060.10$", names(Tmin245), value=T))
Tmin245Nov <- raster::subset(Tmin245, grep("2060.11$", names(Tmin245), value=T))
Tmin245Dec <- raster::subset(Tmin245, grep("2060.12$", names(Tmin245), value=T))

names(Tmin245Jan)
names(Tmin245Feb)
names(Tmin245Mar)
names(Tmin245Apr)
names(Tmin245May)
names(Tmin245Jun)
names(Tmin245Jul)
names(Tmin245Aug)
names(Tmin245Sep)
names(Tmin245Oct)
names(Tmin245Nov)
names(Tmin245Dec)

plot(Tmin245Jan)
Tmin245Janmean <- calc(Tmin245Jan, mean)
Tmin245Febmean <- calc(Tmin245Feb, mean)
Tmin245Marmean <- calc(Tmin245Mar, mean)
Tmin245Aprmean <- calc(Tmin245Apr, mean)
Tmin245Maymean <- calc(Tmin245May, mean)
Tmin245Junmean <- calc(Tmin245Jun, mean)
Tmin245Julmean <- calc(Tmin245Jul, mean)
Tmin245Augmean <- calc(Tmin245Aug, mean)
Tmin245Sepmean <- calc(Tmin245Sep, mean)
Tmin245Octmean <- calc(Tmin245Oct, mean)
Tmin245Novmean <- calc(Tmin245Nov, mean)
Tmin245Decmean <- calc(Tmin245Dec, mean)

Tmin245fin <- stack(Tmin245Janmean, Tmin245Febmean, Tmin245Marmean, Tmin245Aprmean, Tmin245Maymean, Tmin245Junmean, Tmin245Julmean, Tmin245Augmean, Tmin245Sepmean, Tmin245Octmean, Tmin245Novmean, Tmin245Decmean)
names(Tmin245fin) <- paste("Tmin", substr(names(Tmin245fin), 7, 9))
names(Tmin245fin)

plot(Tmin245fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Tmin245fin, "Tmin245.grd",format="raster", overwrite=TRUE)

# 370-SCENARIO

BCCtmin370 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmin_BCC-CSM2-MR_ssp370_2041-2060.tif"))
Cantmin370 <- stack(paste0(Canpath, "wc2.1_2.5m_tmin_CanESM5_ssp370_2041-2060.tif"))
CM6tmin370 <- stack(paste0(CM6path, "wc2.1_2.5m_tmin_CNRM-CM6-1_ssp370_2041-2060.tif"))
ESM2tmin370 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmin_CNRM-ESM2-1_ssp370_2041-2060.tif"))
IPSLtmin370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmin_IPSL-CM6A-LR_ssp370_2041-2060.tif"))
ROCtmin370 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmin_MIROC-ES2L_ssp370_2041-2060.tif"))
ROC6tmin370 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmin_MIROC6_ssp370_2041-2060.tif"))
MRItmin370 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmin_MRI-ESM2-0_ssp370_2041-2060.tif"))

Tmin370 <- stack(BCCtmin370, Cantmin370, CM6tmin370, ESM2tmin370, IPSLtmin370, ROCtmin370, ROC6tmin370, MRItmin370)

Tmin370Jan <- raster::subset(Tmin370, grep("2060.1$", names(Tmin370), value=T))
Tmin370Feb <- raster::subset(Tmin370, grep("2060.2$", names(Tmin370), value=T))
Tmin370Mar <- raster::subset(Tmin370, grep("2060.3$", names(Tmin370), value=T))
Tmin370Apr <- raster::subset(Tmin370, grep("2060.4$", names(Tmin370), value=T))
Tmin370May <- raster::subset(Tmin370, grep("2060.5$", names(Tmin370), value=T))
Tmin370Jun <- raster::subset(Tmin370, grep("2060.6$", names(Tmin370), value=T))
Tmin370Jul <- raster::subset(Tmin370, grep("2060.7$", names(Tmin370), value=T))
Tmin370Aug <- raster::subset(Tmin370, grep("2060.8$", names(Tmin370), value=T))
Tmin370Sep <- raster::subset(Tmin370, grep("2060.9$", names(Tmin370), value=T))
Tmin370Oct <- raster::subset(Tmin370, grep("2060.10$", names(Tmin370), value=T))
Tmin370Nov <- raster::subset(Tmin370, grep("2060.11$", names(Tmin370), value=T))
Tmin370Dec <- raster::subset(Tmin370, grep("2060.12$", names(Tmin370), value=T))

names(Tmin370Jan)
names(Tmin370Feb)
names(Tmin370Mar)
names(Tmin370Apr)
names(Tmin370May)
names(Tmin370Jun)
names(Tmin370Jul)
names(Tmin370Aug)
names(Tmin370Sep)
names(Tmin370Oct)
names(Tmin370Nov)
names(Tmin370Dec)

plot(Tmin370Jan)
Tmin370Janmean <- calc(Tmin370Jan, mean)
Tmin370Febmean <- calc(Tmin370Feb, mean)
Tmin370Marmean <- calc(Tmin370Mar, mean)
Tmin370Aprmean <- calc(Tmin370Apr, mean)
Tmin370Maymean <- calc(Tmin370May, mean)
Tmin370Junmean <- calc(Tmin370Jun, mean)
Tmin370Julmean <- calc(Tmin370Jul, mean)
Tmin370Augmean <- calc(Tmin370Aug, mean)
Tmin370Sepmean <- calc(Tmin370Sep, mean)
Tmin370Octmean <- calc(Tmin370Oct, mean)
Tmin370Novmean <- calc(Tmin370Nov, mean)
Tmin370Decmean <- calc(Tmin370Dec, mean)

Tmin370fin <- stack(Tmin370Janmean, Tmin370Febmean, Tmin370Marmean, Tmin370Aprmean, Tmin370Maymean, Tmin370Junmean, Tmin370Julmean, Tmin370Augmean, Tmin370Sepmean, Tmin370Octmean, Tmin370Novmean, Tmin370Decmean)
names(Tmin370fin) <- paste("Tmin", substr(names(Tmin370fin), 7, 9))
names(Tmin370fin)

plot(Tmin370fin)

predpath <- "E:/Landschaftsökologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Predictors/"
setwd(predpath)
writeRaster(Tmin370fin, "Tmin370.grd",format="raster", overwrite=TRUE)




# BCC-CSM2-MR

BCCprec245 <- stack(paste0(BCCpath, "wc2.1_2.5m_prec_BCC-CSM2-MR_ssp245_2041-2060.tif"))
BCCprec370 <- stack(paste0(BCCpath, "wc2.1_2.5m_prec_BCC-CSM2-MR_ssp370_2041-2060.tif"))
BCCtmax245 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmax_BCC-CSM2-MR_ssp245_2041-2060.tif"))
BCCtmax370 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmax_BCC-CSM2-MR_ssp370_2041-2060.tif"))
BCCtmin245 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmin_BCC-CSM2-MR_ssp245_2041-2060.tif"))
BCCtmin370 <- stack(paste0(BCCpath, "wc2.1_2.5m_tmin_BCC-CSM2-MR_ssp370_2041-2060.tif"))

# CanESM5

Canprec245 <- stack(paste0(Canpath, "wc2.1_2.5m_prec_CanESM5_ssp245_2041-2060.tif"))
Canprec370 <- stack(paste0(Canpath, "wc2.1_2.5m_prec_CanESM5_ssp370_2041-2060.tif"))
Cantmax245 <- stack(paste0(Canpath, "wc2.1_2.5m_tmax_CanESM5_ssp245_2041-2060.tif"))
Cantmax370 <- stack(paste0(Canpath, "wc2.1_2.5m_tmax_CanESM5_ssp370_2041-2060.tif"))
Cantmin245 <- stack(paste0(Canpath, "wc2.1_2.5m_tmin_CanESM5_ssp245_2041-2060.tif"))
Cantmin370 <- stack(paste0(Canpath, "wc2.1_2.5m_tmin_CanESM5_ssp370_2041-2060.tif"))

# CNRM-CM6-1

CM6prec245 <- stack(paste0(CM6path, "wc2.1_2.5m_prec_CNRM-CM6-1_ssp245_2041-2060.tif"))
CM6prec370 <- stack(paste0(CM6path, "wc2.1_2.5m_prec_CNRM-CM6-1_ssp370_2041-2060.tif"))
CM6tmax245 <- stack(paste0(CM6path, "wc2.1_2.5m_tmax_CNRM-CM6-1_ssp245_2041-2060.tif"))
CM6tmax370 <- stack(paste0(CM6path, "wc2.1_2.5m_tmax_CNRM-CM6-1_ssp370_2041-2060.tif"))
CM6tmin245 <- stack(paste0(CM6path, "wc2.1_2.5m_tmin_CNRM-CM6-1_ssp245_2041-2060.tif"))
CM6tmin370 <- stack(paste0(CM6path, "wc2.1_2.5m_tmin_CNRM-CM6-1_ssp370_2041-2060.tif"))

# CNRM-ESM2-1

ESM2prec245 <- stack(paste0(ESM2path, "wc2.1_2.5m_prec_CNRM-ESM2-1_ssp245_2041-2060.tif"))
ESM2prec370 <- stack(paste0(ESM2path, "wc2.1_2.5m_prec_CNRM-ESM2-1_ssp370_2041-2060.tif"))
ESM2tmax245 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmax_CNRM-ESM2-1_ssp245_2041-2060.tif"))
ESM2tmax370 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmax_CNRM-ESM2-1_ssp370_2041-2060.tif"))
ESM2tmin245 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmin_CNRM-ESM2-1_ssp245_2041-2060.tif"))
ESM2tmin370 <- stack(paste0(ESM2path, "wc2.1_2.5m_tmin_CNRM-ESM2-1_ssp370_2041-2060.tif"))

# IPSL-CM6A-LR

IPSLprec245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_prec_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
IPSLprec370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_prec_IPSL-CM6A-LR_ssp370_2041-2060.tif"))
IPSLtmax245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmax_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
IPSLtmax370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmax_IPSL-CM6A-LR_ssp370_2041-2060.tif"))
IPSLtmin245 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmin_IPSL-CM6A-LR_ssp245_2041-2060.tif"))
IPSLtmin370 <- stack(paste0(IPSLpath, "wc2.1_2.5m_tmin_IPSL-CM6A-LR_ssp370_2041-2060.tif"))

# MIROC-ES2L

ROCprec245 <- stack(paste0(ROCpath, "wc2.1_2.5m_prec_MIROC-ES2L_ssp245_2041-2060.tif"))
ROCprec370 <- stack(paste0(ROCpath, "wc2.1_2.5m_prec_MIROC-ES2L_ssp370_2041-2060.tif"))
ROCtmax245 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmax_MIROC-ES2L_ssp245_2041-2060.tif"))
ROCtmax370 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmax_MIROC-ES2L_ssp370_2041-2060.tif"))
ROCtmin245 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmin_MIROC-ES2L_ssp245_2041-2060.tif"))
ROCtmin370 <- stack(paste0(ROCpath, "wc2.1_2.5m_tmin_MIROC-ES2L_ssp370_2041-2060.tif"))

# MIROC6

ROC6prec245 <- stack(paste0(ROC6path, "wc2.1_2.5m_prec_MIROC6_ssp245_2041-2060.tif"))
ROC6prec370 <- stack(paste0(ROC6path, "wc2.1_2.5m_prec_MIROC6_ssp370_2041-2060.tif"))
ROC6tmax245 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmax_MIROC6_ssp245_2041-2060.tif"))
ROC6tmax370 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmax_MIROC6_ssp370_2041-2060.tif"))
ROC6tmin245 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmin_MIROC6_ssp245_2041-2060.tif"))
ROC6tmin370 <- stack(paste0(ROC6path, "wc2.1_2.5m_tmin_MIROC6_ssp370_2041-2060.tif"))

# MRI-ESM2-0

MRIprec245 <- stack(paste0(MRIpath, "wc2.1_2.5m_prec_MRI-ESM2-0_ssp245_2041-2060.tif"))
MRIprec370 <- stack(paste0(MRIpath, "wc2.1_2.5m_prec_MRI-ESM2-0_ssp370_2041-2060.tif"))
MRItmax245 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmax_MRI-ESM2-0_ssp245_2041-2060.tif"))
MRItmax370 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmax_MRI-ESM2-0_ssp370_2041-2060.tif"))
MRItmin245 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmin_MRI-ESM2-0_ssp245_2041-2060.tif"))
MRItmin370 <- stack(paste0(MRIpath, "wc2.1_2.5m_tmin_MRI-ESM2-0_ssp370_2041-2060.tif"))



