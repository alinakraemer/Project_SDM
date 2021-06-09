rm(list=ls())

library(raster)
library(dismo)

### ABUNDANCE DATA ###

abundancepath <- "E:/Landschafts?kologie_Master/Module/M8a_Fernerkundung_und_raeumliche_Modellierung/Projekt_SDM/Data/Abundance_data/"

?read.csv
?read.csv2
?paste0
abund <- read.csv2(paste0(abundancepath, "willow_warbler_2020_Europe_latlong.csv"), header=T, sep=";")

str(abund)
head(abund)
tail(abund)


?substr
abund$MONTH <- substr((abund$OBSERVATION.DATE), 4, 5)
unique(abund$MONTH)

ww <- abund[abund$MONTH == "06",]
head(ww)



## Plotting the abundance data for an overview
library(maptools)
data(wrld_simpl) # free polygon data frame for simplified geographic globe
plot(wrld_simpl, xlim=c(10,30), ylim=c(30,70), axes=TRUE, col="light yellow") # 
box() # restore the box around the map


# Checking for errors
?subset
lonzero <- subset(ww, ww$LONGITUDE==0)
latzero <- subset(ww, ww$LATITUDE==0)
latzero


## Formatting latitude and longitude data

library(sf)
ww_utm <- st_transform(ww$LATITUDE, crs="+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0
+no_defs ")
names(ww)

## Adding occurrence points

crs(wrld_simpl)
?points
points(ww$LONGITUDE, ww$LATITUDE, col="orange", pch=20, cex=0.75)
points(ww$LONGITUDE, ww$LATITUDE, col="red", cex=0.75)








## RASTERIZING
?raster
?extent
europe <- extent()


ras <- raster((ext = europe?), crs = , resolution =, template= EuropaGDAL)

abundras <- rasterize(ww, ras, ...)




## SWITCHING CRS FROM WGS TO ETRS