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


# Checking for errors/NAs
?subset
lonzero <- subset(ww, ww$LONGITUDE==0)
latzero <- subset(ww, ww$LATITUDE==0)
# --> no errors(NAs)

# Checking for exact duplicates

dups <- duplicated(ww)
wwdups <- ww[dups, ]
# --> no duplicates

# Checking for same coordinate data
?duplicated
dups2 <- duplicated(ww[, c("LATITUDE", "LONGITUDE")])
wwnd <- ww[!dups2,] # Subsample with no coordinate duplicates

# Checking for unplausible data points (use an appropriate GDAL here, the same as used for cropping)
library(sp)
coordinates(wwnd) <- ~LONGITUDE+LATITUDE
crs(wwnd) <- crs(wrld_simpl)

ovr <- over(wwnd, wrld_simpl)
head(ovr)

cntr <- ovr$NAME # 

i <- which(is.na(cntr))
i

j <- which(cntr != wwnd$COUNTRY)

cbind(cntr, wwnd$COUNTRY)[j,]

plot(wwnd)
plot(wrld_simpl, add=T, border="blue", lwd=2)
points(wwnd[j,], col="red", pch=20, cex=2)

## Adding occurrence points

crs(wrld_simpl)
?points
points(ww$LONGITUDE, ww$LATITUDE, col="orange", pch=20, cex=0.75)
points(ww$LONGITUDE, ww$LATITUDE, col="red", cex=0.75)

setwd(abundancepath)
write.csv2(wwnd, file="willow_warbler_2020_Europe_prep_and_clean.csv", row.names=TRUE)
?write.csv2


