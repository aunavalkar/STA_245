library(ggplot2)
library(ggspatial)
library(ggthemes)
library(sf)
#Import spatial data (shapefiles) in R 
Boundary_Layer<- st_read(dsn = "E:/Dissertation/GIS_TEMP_FLOOD/Shapefiles/Boundary_Layer.shp")
Road_Layer<- st_read(dsn = "E:/Dissertation/GIS_TEMP_FLOOD/Shapefiles/Road_Layer.shp")
Habitation_Layer<- st_read(dsn = "E:/Dissertation/GIS_TEMP_FLOOD/Shapefiles/Habitation_Layer.shp")

ggplot()+geom_sf(data = Boundary_Layer, size = 2, color = "red")+geom_sf(data = Road_Layer, color = "magenta", size=1)+
geom_sf(data = Habitation_Layer, size=3, color = "black", fill = "black", shape = 23)+
  geom_sf_text(data = Habitation_Layer, mapping = aes(label=Hab_Name), nudge_x = -1, nudge_y = 10, size= 3)+
  annotation_north_arrow(height = unit(2, "cm"), width =  unit(0.5, "cm"), pad_x = unit(0.5, "cm"), pad_y = unit(2, "cm"))+
  annotation_scale(plot_unit = "km", line_width = unit(3, "cm"))+ xlab("Longitude")+ ylab ("Latitude")+ggtitle("Ghanshyampur Road Network and Habitations")

#Import Shapefiles from GitHub repositories on Cities and Geographical Boundary of India. 
India_Boundary<- st_read(dsn = "Shapefiles/india/indian_borders_for_indian_viewers.shp")
India_Cities<- st_read(dsn = "Shapefiles/india_cities/india_cities.shp")
#Giving a CRS to Cities Shapefile
st_crs(India_Cities)<-st_crs(India_Boundary)
st_crs(India_Cities)
#plot Boundary + cities 
ggplot(data=India_Boundary)+geom_sf()+geom_sf(data = India_Cities)+geom_sf_text(data = India_Cities, mapping = aes(label=city), size=2, nudge_x = -0.2, nudge_y = -0.2)+ annotation_north_arrow(height = unit(2.5 , "cm"), width = unit(1.5, "cm"), pad_x = unit(1, "cm"),pad_y = unit(1.5, "cm")) + annotation_scale(line_width = 1)
