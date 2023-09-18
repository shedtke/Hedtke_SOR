library(sf)
library(spData)
library(tidyverse)
library(ggspatial)
library(ggrepel)
library(ggplot2)

library(raster)

library(osmdata)
library(geodata)

loc.gha<-read.table("C:/Users/SHedtke/Documents/Hedtke_et_al_SOR/loc.txt",header=TRUE,sep="\t")

mycol<-c(rep("#FCFDBFFF",4),rep("#721F81FF",5),rep("#ED7953FF",4)

lat.range.min<-min(loc.gha$lat)
lat.range.max<-max(loc.gha$lat)
lon.range.min<-min(loc.gha$lon)
lon.range.max<-max(loc.gha$lon)


border.latlon<-0.25

lat.min<-lat.range.min-border.latlon
lat.max<-lat.range.max+border.latlon
lon.min<-lon.range.min-border.latlon
lon.max<-lon.range.max+border.latlon

srtm.raster<-getData("SRTM", lat=8,lon=-1,download=TRUE)

srtm.m<-rasterToPoints(srtm.raster)
srtm.df<-data.frame(srtm.m)
colnames(srtm.df)=c("lon","lat","alt")
 
my_bbox.m <- matrix(c(lon.min,lon.min,lon.max,lon.max,lon.min,lat.max,lat.min,lat.min,lat.max,lat.max),ncol = 2)
my_bbox.sf <- st_geometry(st_polygon(x = list(my_bbox.m)))
st_crs(my_bbox.sf) <- 4326

my_bbox_buff_2500.sf <- 
+   my_bbox.sf %>%
+   st_transform(crs = 32632) %>%
+   st_buffer(dist = 2500) %>% # 2.5 kilometers
+   st_transform(crs = 4326)

osm_rivers.sf <- 
+   opq(bbox = st_bbox(my_bbox_buff_2500.sf)) %>%
+   add_osm_feature(key = 'waterway', value = 'river') %>%
+   osmdata_sf()
osm_rivers.sf <- osm_rivers.sf$osm_lines

slope.raster <- terrain(srtm.raster, opt='slope')
aspect.raster <- terrain(srtm.raster, opt='aspect')
hill.raster <- hillShade(slope.raster, aspect.raster, 40, 270)
hill.m <- rasterToPoints(hill.raster)
hill.df <-  data.frame(hill.m)
colnames(hill.df) <- c("lon", "lat", "hill")

osm_lakes.sf <- 
+   opq(bbox = st_bbox(my_bbox_buff_2500.sf)) %>%
+   add_osm_feature(key = 'water', value = 'lake') %>%
+   osmdata_sf()
osm_lakes.sf <- osm_lakes.sf$osm_multipolygons

gadm(country="Ghana",path="C:/Users/SHedtke/Downloads/")->gadm.gha

gadm.sf<-as(gadm.gha,"Spatial") 
st_as_sf(gadm.gha)->gadm.sf2

mysize<-loc.gha$sample_size/2

ggplot(world)+ theme_void()+geom_sf(data=gadm.sf2) +geom_raster(data = hill.df, aes(lon, lat, fill = hill), alpha = .45) + scale_fill_gradientn(colours = grey.colors(100))+ geom_sf(data = osm_rivers.sf, colour = '#9ecae1', size = 0.05)+coord_sf(xlim = c(lon.min, lon.max), ylim = c(lat.min,lat.max), expand = FALSE)+geom_point(data = loc.gha, aes(lon, lat), fill = mycol, color = "black", size = mysize, stroke = 1, shape = 21, alpha = .7)+annotation_scale(location = "bl", width_hint = 0.3)

 

## revision to getting the water bodies that works:

osm_water.sf <- opq(bbox = st_bbox(my_bbox_buff_2500.sf)) %>% add_osm_feature(key="natural",value=c("water")) %>% osmdata_sf()

ggplot(world)+ theme_void()+geom_sf(data=gadm.sf2,fill=NA)+geom_sf(data = osm_water.sf$osm_multipolygons, colour = watercol, fill = watercol)+geom_sf(data = osm_rivers.sf, colour = watercol, size = 0.05)+coord_sf(xlim = c(lon.min, lon.max), ylim = c(lat.min,lat.max), expand = FALSE)+geom_point(data = loc.gha, aes(lon, lat), fill = mycol, color = "black", size = mysize, stroke = 1, shape = 21, alpha = .7)+annotation_scale(location = "bl", width_hint = 0.3)

loc.cam<-read.table("C:/Users/SHedtke/Documents/Hedtke_et_al_SOR/loc2.txt",header=TRUE, sep="\t")

mycol<-c(rep("#FDE725FF",6),rep("#21908CFF",8))

gadm(country="Cameroon",path="C:/Users/SHedtke/Downloads/")->gadm.cam
gadm.sf<-as(gadm.cam,"Spatial") 
st_as_sf(gadm.cam)->gadm.sf2

lat.range.max<-max(loc.cam$lat)
lat.range.min<-min(loc.cam$lat)
lon.range.min<-min(loc.cam$lon)
lon.range.max<-max(loc.cam$lon)
lat.range.max<-max(loc.cam$lat)
border.latlon<-0.25

lat.min<-lat.range.min-border.latlon
lat.max<-lat.range.max+border.latlon
lon.min<-lon.range.min-border.latlon
lon.max<-lon.range.max+border.latlon

 
my_bbox.m <- matrix(c(lon.min,lon.min,lon.max,lon.max,lon.min,lat.max,lat.min,lat.min,lat.max,lat.max),ncol = 2)
my_bbox.sf <- st_geometry(st_polygon(x = list(my_bbox.m)))
st_crs(my_bbox.sf) <- 4326

my_bbox_buff_2500.sf <- my_bbox.sf %>% st_transform(crs = 32632) %>% st_buffer(dist = 2500) %>% st_transform(crs = 4326)

osm_rivers.sf <- opq(bbox = st_bbox(my_bbox_buff_2500.sf)) %>% add_osm_feature(key = 'waterway', value = 'river') %>% osmdata_sf()
osm_rivers.sf <- osm_rivers.sf$osm_lines


osm_water.sf <- opq(bbox = st_bbox(my_bbox_buff_2500.sf)) %>% add_osm_feature(key="natural",value=c("water")) %>% osmdata_sf()

mysize<-loc.cam$sample_size/2

 

ggplot(world)+ theme_void()+ geom_sf(data=gadm.sf2,fill=NA)+ geom_sf(data = osm_water.sf$osm_multipolygons, col = watercol, fill = watercol)+ geom_sf(data = osm_rivers.sf, col = watercol, size = 0.05)+coord_sf(xlim = c(lon.min, lon.max), ylim = c(lat.min,lat.max), expand = FALSE)+geom_point(data = loc.cam, aes(lon, lat), fill = mycol, color = "black", size = mysize, stroke = 1, shape = 21, alpha = .7)+annotation_scale(location = "bl", width_hint = 0.3)

 

