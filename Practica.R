library(lubridate)

Datos <- read.delim("docs/bucmot/detecciones.txt")

DatosLimpios <- Datos[,c(2, 7, 11, 31, 32)]

DatosLimpios[DatosLimpios$OBSERVATION.COUNT == "X", ]$OBSERVATION.COUNT <- 1

table(DatosLimpios$OBSERVATION.COUNT)

DatosLimpios$OBSERVATION.DATE <- ymd(DatosLimpios$OBSERVATION.DATE)

# Separar fechas y horas

class(DatosLimpios$TIME.OBSERVATIONS.STARTED)
head(DatosLimpios)

Fecha<- ymd_hms(DatosLimpios$LAST.EDITED.DATE)
class(Fecha)

# Separar fechas y horas

date(Fecha)

lubridate::hour(Fecha)
lubridate::minute(Fecha)

library(tidyverse)
DatosLimpios2 <- DatosLimpios %>%
  separate(LAST.EDITED.DATE, into = c("Date", "Time"), sep = " ") %>% 
  mutate(Date = ymd(Date)) %>% 
  mutate(Hora = substr(Time, 1, 5)) %>% 
  mutate(HoraMilitar = str_replace_all(Hora, ":", "")) %>% 
  mutate(HoraMilitar = as.numeric(HoraMilitar))


  

head(DatosLimpios2)

plot(DatosLimpios2$HoraMilitar)


