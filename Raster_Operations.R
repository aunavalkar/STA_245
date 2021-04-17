#Raster Operations in R

library(raster)
library(sp)
#Importing a DEM 
DEM_1<- raster("../Rasters/DEM/cdne43t_v3r1/cdne43t.tif")
#Visualise a DEM using spplot()
spplot(DEM_1, main= "Visualise DEM")
#Extract elevation from DEM
cellFromXY(object = DEM_1, xy = c(73.10, 16.6))
DEM_1[5184361]
cellFromXY(object = DEM_1, xy = c(73.79, 16.6))
DEM_1[5186845]
cellFromXY(object = DEM_1, xy = c(73.95, 16.69))
DEM_1[4021021]

#Reprojection to EGM 2008 CRS to get true elevations. 
#Do a Reprojection to EGM 2008 CRS (to be discussed )
#Reproject to UTM 43 N projcted system
DEM_1_UTM<- projectRaster(DEM_1, crs = 32643)

#CEll statistics 
summary(DEM_1_UTM)
cellStats(DEM_1_UTM, stat = "mean")
hist(DEM_1_UTM)
#Extract contours from DEM 
Contours_DEM<- rasterToContour(x = DEM_1_UTM, n = 10)
# Plot contours 
spplot(Contours_DEM, main = "Contours from DEM")
#DEM to extract slope and aspect
Slope_1<- terrain(x = DEM_1_UTM, "slope")
spplot(Slope_1)

########################
##### Raster operations on Multi-spectral data (Landsat 4-5 Thematic Mapper)###
#Import Landsat bands
landsat_B2<- raster("../Rasters/Landsat_Konkan/145051/LT05_L1TP_145051_19910203_20170128_01_T1/LT05_L1TP_145051_19910203_20170128_01_T1_B2.TIF")
landsat_B3<- raster("../Rasters/Landsat_Konkan/145051/LT05_L1TP_145051_19910203_20170128_01_T1/LT05_L1TP_145051_19910203_20170128_01_T1_B3.TIF")
landsat_B4<- raster("../Rasters/Landsat_Konkan/145051/LT05_L1TP_145051_19910203_20170128_01_T1/LT05_L1TP_145051_19910203_20170128_01_T1_B4.TIF")
landsat_B5<- raster("../Rasters/Landsat_Konkan/145051/LT05_L1TP_145051_19910203_20170128_01_T1/LT05_L1TP_145051_19910203_20170128_01_T1_B5.TIF")


landsat_stacked<- stack(landsat_B2, landsat_B3, landsat_B4, landsat_B5)

NDVI<- (landsat_stacked$LT05_L1TP_145051_19910203_20170128_01_T1_B5-landsat_stacked$LT05_L1TP_145051_19910203_20170128_01_T1_B4)/((landsat_stacked$LT05_L1TP_145051_19910203_20170128_01_T1_B5+landsat_stacked$LT05_L1TP_145051_19910203_20170128_01_T1_B4))

















