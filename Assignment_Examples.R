library(sf)
library(raster)
library(ggplot2)
Road_1<- rbind(c(19.232294245100018, 72.82936739435502), c(19.232152424076673, 72.830633397012), c(19.231767480681672, 72.83250021448922), c(19.231544618303772, 72.83406662455631), c(19.23095707058519, 72.83644842616518), c(19.230551864037427, 72.83805775157659), c(19.2302682188592, 72.84005331508672), c(19.230166916891125, 72.84106182567785), c(19.2302682188592, 72.84262823574497), c(19.230450562244297, 72.8446667145994), c(19.23034926038867, 72.8465335320766), c(19.23051134332767, 72.84769224637282), c(19.230713946776493, 72.84874367230827), c(19.230835508725836, 72.85048174375258), c(19.230936810281545, 72.85254168027917), c(19.231017851481127, 72.85363602155893))
Road_2<- rbind(c(19.23725790375734, 72.84114765636647), c(19.23622466472919, 72.84058975689051), c(19.235475055874428, 72.84061121456267), c(19.234421545753744, 72.84052538387405), c(19.233671928667704, 72.84048246852976), c(19.232273984961328, 72.84063267223482), c(19.231382536384448, 72.84082579128419), c(19.23032900001005, 72.8409116219728), c(19.229315977892682, 72.84084724895634), c(19.22854607690514, 72.84084724895634), c(19.227593825955267, 72.8409545373171), c(19.22728991491568, 72.84086870662848), c(19.22726965415972, 72.8409116219728), c(19.227310175669146, 72.84076141826773), c(19.22605400422928, 72.84082579128419), c(19.226155308733734, 72.84082579128419), c(19.225750090341162, 72.84080433361204), c(19.22433181809668, 72.84071850292342), c(19.223561893751356, 72.84073996059558), c(19.22210307983516, 72.84071850292342))
Road_3<- rbind(c(19.23513063984784, 72.84526752941964), c(19.235110380059073, 72.8438513230576), c(19.23506986047405, 72.84297155849939), c(19.235090120267813, 72.84146952144876), c(19.235009081077756, 72.84063267223482))
Road_4<- rbind(c(19.228606858693247, 72.84992384427665), c(19.228505555700576, 72.84666227810952), c(19.22901207003921, 72.8445808839108), c(19.229700927033267, 72.84275698177785), c(19.229761708394037, 72.84181284420318), c(19.230045354446954, 72.84108328335002))
Road_1<- list(Road_1[,2:1])
Road_2<- list(Road_2[,2:1])
Road_3<- list(Road_3[,2:1])
Road_4<- list(Road_4[,2:1])
#Fill up the attribute of the intended SF object
Roadnames<- c("Road 1", "Road 2", "Road 3", "Road 4")

Road_Geometry<- st_sfc(st_multilinestring(Road_1),
st_multilinestring(Road_2),
st_multilinestring(Road_3),
st_multilinestring(Road_4))
# Road_Shapefile<- cbind.data.frame(Roadname=Roadnames, geometry=Road_Shapefile)
# Road_Shapefile<- st_sf(Road_Shapefile, crs = 4326)
# Road_Shapefile<- st_transform(Road_Shapefile, crs = 32643)
# 
# Hospital_Multipoints<- st_sfc(st_point(c(72.84052538387405,  19.227938257787113)), st_point(c( 72.84601854794498, 19.228444773874987)), st_point(c(72.84737038129055, 19.227614086671252)), st_point(c(72.84395861141839, 19.23452284509752)), st_point( c( 72.84395861141839, 19.23452284509752)), st_point(c(72.83168482294744, 19.226276874056584)))
# Hospital_Names<- c("Hospital 1", "Hospital 2", "Hospital 3", "Hospital 4", "Hospital 5", "Hospital 6")
# Hospital_sf<- cbind.data.frame(Name=Hospital_Names, geometry= Hospital_Multipoints)
# Hospital_sf<- st_sf(Hospital_sf, crs = 4326)
# Hospital_sf<- st_transform(Hospital_sf, crs = 32643)
# 
# reference_point<-st_point(c(72.84086870662848, 19.230025094030843))
# reference_point<- st_sfc(reference_point, crs= 4326)
# reference_point<- st_transform(reference_point, crs= 32643)
# 
# ggplot()+geom_sf(data=Road_Shapefile, color = "green")+geom_sf_text(data = Road_Shapefile, mapping = aes(label = Roadname), color = "grey", nudge_x = -2, nudge_y = 2)+geom_sf(data = reference_point, size = 3, colour = "red")+geom_sf(data= Hospital_sf, size = 1.5)+geom_sf_text(data = Hospital_sf, aes(label = Name), color = "magenta") +geom_sf(data=buffer_reference_1000, fill = "transparent", color = "red")
# buffer_reference_1000<- st_buffer(reference_point, dist = 1000)
# 
# ggplot()+geom_sf(data =  Hospital_sf%>% filter(Name!="Hospital 6"))+geom_sf(data = reference_point, size = 3, colour = "red") +geom_sf(data=buffer_reference_1000, fill = "transparent", color = "red")
# st_write(obj = Hospital_sf, dsn = "Shapefiles/Hospital.shp", driver = "ESRI Shapefile", delete_dsn = TRUE)
# 
