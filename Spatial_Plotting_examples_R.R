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


###choropleth plotting using Census Data
#Import census data in R environment using read_excel()
#Import Shapefile data using read_sf()
#Subset the PCA data to our requirement
PCA_Census<- subset(x = Primary_Census_Abstract_Total_Table_For_India, subset = TRU=="Total"&Level=="STATE", select = c("Name","No_HH", "TOT_P", "TOT_M", "TOT_F"))
#PCA data frame and shapefile Attribute data manipulation to facilitate merge with shapefile
India_States$NAME_1<- toupper(India_States$NAME_1)
#After renaming and data cleaning. Perform Merge
India_States_2<- merge.data.frame(x = India_States, y = PCA_Census, by.x = "NAME_1", by.y="Name")
#Retrieve the spatial characteristic of the new dataframe 
India_States_2<- st_as_sf(India_States_2)
#Plot the choropleth by selecting a suitable colour palette 
ggplot(data = India_States_2)+geom_sf(mapping = aes(fill=TOT_F))+scale_fill_continuous_tableau(palette = "Red")+labs(fill = "Total Population")
ggplot(data = India_States_2)+geom_sf(mapping = aes(fill=cut_interval(TOT_F, 7)))+labs(fill="Total Population")

############ Spatial and Attribute Query Lesson dated :30/3/2021############
#Attribute data selection
Global_Data_UHI<- st_read(dsn = "Shapefiles/india/sdei-global-uhi-2013-shp/sdei-global-uhi-2013-shp/shp/sdei-global-uhi-2013.shp")
#Visualise the data
ggplot(data = Global_Data_UHI)+geom_sf()
View(Global_Data_UHI)
#Abstract India's data 
Indian_HeatIsland<- subset(x = Global_Data_UHI, subset = grepl("IND", Global_Data_UHI$ISO3))
#Visualise Indian abstracted data
ggplot(data = Indian_HeatIsland) +geom_sf()

#Obtain basic heat map without dissolving the shapefile boundaries of the cities. (Note: This map obscures detailed information on the maximum summer day time temperature)
ggplot(data = Indian_HeatIsland)+geom_sf(mapping = aes(fill = URB_D_MEAN))+scale_fill_continuous_tableau(palette = "Red")+labs(fill = "LST", title = "Average Summer Daytime Max LST", subtitle = "Indian Region")

#Do a spatial Query to zoom in on an area that you want in order to visualise UHI better. 

# USe st_crop() to select the new extent of the area you want to zoom in on .
Cropped_Indian_UIH<- st_crop(Indian_HeatIsland, xmin = 75, ymin = 15, xmax = 80, ymax=25)

# Does it Crop? 
ggplot(data = Cropped_Indian_UIH)+geom_sf()

#Yes it crops based on spatial box 

#Crop it further by changing the parameters of the bounding box
bbox<- st_bbox(obj = Cropped_Indian_UIH, xmin=76 , ymin=16 , xmax=78 , ymax=22)
Indian_HeatIsland_Cropped<- st_crop(Indian_HeatIsland, bbox)

#Plot to see the changed extents 
ggplot(data = Indian_HeatIsland_Cropped)+geom_sf()

#Plot the UHI in the new extents 
ggplot(data = Indian_HeatIsland_Cropped)+geom_sf(mapping = aes(fill = URB_D_MEAN))

#Plot the UHI as intervals 
ggplot(data = Indian_HeatIsland_Cropped)+geom_sf(mapping = aes(fill = cut_interval(x = URB_D_MEAN, 5)))+labs(fill = "LST", title = "Average Summer Daytime Max LST", subtitle = "Indian Region")




























