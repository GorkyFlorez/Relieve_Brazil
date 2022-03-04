library(sf)
library(ggplot2)
library(tidyverse)
library(ggnewscale)
library(raster)
library(extrafont)      # custom font
library(hrbrthemes)     # to use import_roboto_condensed()
library(ggthemes)
library(elevatr)
library(tmap)
Bra      <- getData('GADM', country='Brazil', level=0) %>% st_as_sf()
Elev    <- getData('alt', country='Brazil')
plot(Elev)

slope = terrain(Elev  , opt = "slope") 
aspect = terrain(Elev , opt = "aspect")
hill = hillShade(slope, aspect, angle = 40, direction = 270)

colss <-c("#41641F","#6B9F3A","#EDAE5F","#955235","#9F3B03","#843907","#471600","#4E1C05","#50362F", "#391306")

Mapa_tmap= tm_shape(hill) +
  tm_raster(palette = gray(0:10 / 10), n = 100, legend.show = FALSE, alpha=0.7)+
  tm_shape(Elev) +
  tm_raster(alpha = 0.6, palette = colss ,n=8, style="cont",
            legend.show = T, title="Elevacion \n(m.s.n.m)")+
  tm_scale_bar(width = 0.25, text.size = 0.5, text.color = "black", color.dark = "lightsteelblue4", 
               position = c(.01, 0.005), lwd = 1, color.light= "white")+
  tm_compass(type="8star", position=c(.01, 0.85), text.color = "black")+
  tm_layout( bg.color="white", 
             legend.title.size=.8,
             legend.position = c(.90, .005) ,
             fontface="bold",
             legend.format = c(text.align = "right", 
                               text.separator = "-"))+
  tm_credits("BRAZIL:  Shaded \n     Relief map", position = c(.65, .8), col = "black", fontface="bold", size=2, fontfamily = "serif")+
  tm_credits("Data: DEM SRTM \n#Aprende R desde Cero Para SIG \nGorky Florez Castillo", position = c(0.1, .04), col = "black", fontface="bold")+
  tm_logo(c("https://www.r-project.org/logo/Rlogo.png",
            system.file("img/tmap.png", package = "tmap")),height = 3, position = c(0.60, 0.05))

tmap_save(Mapa_tmap, "Mapa/Brazil.png", dpi = 1200, width = 9, height = 9)


