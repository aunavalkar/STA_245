#Spatial Data Management / Analysis / Geometry using Simple Features. 
library(ggplot2)
library(ggspatial)
library(ggthemes)
library(sf)
library(dplyr)
#Get a matrix of lat_long

points_matrix<- rbind(c(19.128775541189796, 72.89765626617037), c(19.135181645353818, 72.89911538787672), c(19.134046404503426, 72.90581018158814), c(19.133559870321406, 72.9119899911679), c(19.129180998185518, 72.91465074251475), c(19.125937314355806, 72.91422158907173), c(19.120585096813034, 72.90838510224637), c(19.12050400127468, 72.90821344086915))
colnames(points_matrix)<- c("Lat", "Long")

#Using method 1 by converting the matrix in to a dataframe. 
points_df <- as.data.frame(points_matrix)

#Convert the lat - long dataframe in to an simple features object. 
Powai_lake_points_sf<- st_as_sf(x = points_df, coords = c("Lat", "Long"), crs= 4326)

#Plot the points using ggplot()
ggplot()+geom_sf(data = Powai_lake_points_sf)

#Using method 2 where a matrix is forced as a spatial object
st_multipoint(points_matrix)

# Creating a multi-line geometry from a matrix of lat long
multiline_powai<- st_multilinestring(list(points_matrix))

#Also create a polygon or a multi - polygon geometry from the matrix of cartesian coordinates 
singlepolygon_powai<- st_polygon(list(points_matrix))
polygon_border <- rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))

#Create a simple polygon geometry from matrix of lat-long coordinates 
points_matrix_2<- rbind(c(19.128775541189796, 72.89765626617037), c(19.135181645353818, 72.89911538787672), c(19.134046404503426, 72.90581018158814), c(19.133559870321406, 72.9119899911679), c(19.129180998185518, 72.91465074251475), c(19.125937314355806, 72.91422158907173), c(19.120585096813034, 72.90838510224637), c(19.12050400127468, 72.90821344086915), c(19.128775541189796, 72.89765626617037))
powai_polygon_sf<-  st_polygon(list(points_matrix_2))

#Reprojection to UTM zone 43 N using the EPSG code 32643
India_States_UTM<- st_transform(India_States, crs = 32643)

#Simplify Geometry 
India_States_UTM_simplified<- st_simplify(India_States_UTM)

# Creating centroids 
India_States_UTM_simplified_centroids<- st_point_on_surface(India_States_UTM_simplified)

#Calculating distance between centroids of two union territories 
st_distance(x = India_States_UTM_simplified_centroids%>% filter(NAME_1=="CHANDIGARH"), y = India_States_UTM_simplified_centroids%>% filter(NAME_1=="DELHI"))


#Compute the length of lines / roads etc. in a line shape file using st_length()
st_length(Road_Network)

############Spatial Analysis in R#########Date 13/04/2021


#Creating Buffers around point and line shapefiles

Habitation_Buffer_1000<- st_buffer(x = Habitation, dist = 1000)
Road_Buffer_200<- st_buffer(x = Road_Network, dist = 200)

#Visualise the buffers

ggplot()+ geom_sf(data = Habitation_Buffer_1000, fill = "Yellow") + geom_sf(data = Habitation, size=1, color = "Red")+ geom_sf(data = Road_Network, color = "Blue") + geom_sf_text(data = Habitation, aes(label  = Hab_Name))

ggplot()+ geom_sf(data = Road_Buffer_200, fill = "Yellow") + geom_sf(data = Road_Network, color = "Red")

#Application of Buffering to obtain geometrical binary predicates. 

st_contains(x = Habitation_Buffer_1000 %>% filter(Hab_Name=="Ghanshyampur"), y = Road_Network)
  
#Visualise the geometrical binary predicate st_contains() and st_intersects()
ggplot() + geom_sf(data = Habitation_Buffer_1000 %>% filter(Hab_Name=="Ghanshyampur"), fill = "yellow") + geom_sf(data = Habitation %>% filter (Hab_Name == "Ghanshyampur"), color = "Red") + geom_sf(data = Road_Network%>% filter(id==76), colour = "green")

st_intersects(x = Habitation_Buffer_1000 %>% filter(Hab_Name=="Ghanshyampur"), y = Road_Network)

ggplot() + geom_sf(data = Habitation_Buffer_1000 %>% filter(Hab_Name=="Ghanshyampur"), fill = "yellow") + geom_sf(data = Habitation %>% filter (Hab_Name == "Ghanshyampur"), color = "Red") + geom_sf(data = Road_Network%>% filter(id==76|id==82|id ==10| id ==39 | id ==87 |  id ==23), colour = "green")


#BAsic geoprocessing features. 
# Create two geometry features in your area that overlap

Gorai_Plot_1<- list(rbind(c(19.23223346469867, 72.8291313599569), c(19.23032900003229, 72.8408901642962), c(19.219671694551387, 72.8406755875747), c(19.21979326467101, 72.83398079386325), c(19.21955012434183, 72.82883095254678), c(19.222629875265547, 72.82741474618474), c(19.23223346469867, 72.8291313599569)))
Gorai_Plot_2<- list(rbind(c(19.230774727784645, 72.83745693675188), c(19.23028847926755, 72.8408901642962), c(19.23028847926755, 72.84569668285825), c(19.231098892662963, 72.85659718031145), c(19.221090007019825, 72.85269188397979), c(19.21946907748709, 72.8406755875747), c(19.219752741309385, 72.83402370920757), c(19.230774727784645, 72.83745693675188)))

#Converting the polygon lists in to polygon objects
Gorai_Plot_1_Polygon<- st_polygon(x = Gorai_Plot_1)

Gorai_Plot_2_Polygon<- st_polygon(x = Gorai_Plot_2)

# Convert the polygons in to simple features column (sfc) and give the appropriate CRS . 4326

Gorai_Plot_1_Polygon<- st_sfc(Gorai_Plot_1_Polygon, crs = 4326)
Gorai_Plot_2_Polygon<- st_sfc(Gorai_Plot_2_Polygon, crs = 4326)

#Plot polygons to verify 
ggplot()+geom_sf(data = Gorai_Plot_1_Polygon, color = "red")+geom_sf(data = Gorai_Plot_2_Polygon, color = "green")

#Perform geoprocessing Intersection, Union , Difference
Gorai_Intersection<- st_intersection(x = Gorai_Plot_1_Polygon, y = Gorai_Plot_2_Polygon)

Gorai_Union<- st_union(x = Gorai_Plot_1_Polygon, y = Gorai_Plot_2_Polygon)

Gorai_Difference<- st_difference(x = Gorai_Plot_1_Polygon, y = Gorai_Plot_2_Polygon)

#Visualise the geoprocessing Output 
ggplot()+ geom_sf(data = Gorai_Intersection)

ggplot()+ geom_sf(data = Gorai_Union)

ggplot()+ geom_sf(data = Gorai_Difference)

#Near Analysis Example 
st_nearest_feature(x = Habitation %>% filter(Hab_Name=="Ghanshyampur"), y = Road_Network)























