
#https://rpubs.com/cicenet/363721

library(plotly)
library(lubridate)
library(dplyr)

dfAccTransit <-read.csv("Accidentalidad_2016.csv", stringsAsFactors=FALSE, sep = ",")
names(dfAccTransit)
dfAccTransit <- dfAccTransit[dfAccTransit$GRAVEDAD == "Fatal", ]
dfAccTransit$Hour <-as.character(hour(parse_date_time(dfAccTransit$HORA, "%I:%M %p")))
head(dfAccTransit$HORA)
head(dfAccTransit$FECHA)
dfAccTransit$FECHA <- substr(dfAccTransit$FECHA, 1, 10)
head(dfAccTransit$FECHA)
dfAccTransit$DateTimeTest <-paste(dfAccTransit$FECHA," ",dfAccTransit$Hour,":00", sep = "")
head(dfAccTransit$DateTimeTest)
datas <- as.Date(dfAccTransit$DateTimeTest)
dfAccTransit$mes <- months(datas)

dfAccTransit$DateTime <- dfAccTransit$DateTimeTest
head(dfAccTransit$DateTime)
dfTotalAccByDatTime <-dfAccTransit %>% group_by(DateTime,Hour,GRAVEDAD, mes) %>% summarize(count=n())
library(plotly)
plot_ly(dfTotalAccByDatTime,x= ~DateTime,y = ~count, z= ~Hour, type = "scatter3d", color = ~factor(mes)) %>% 
  layout(title = "Acidentes de Trânsito Fatais em Medellin em 2016",
         scene = list(xaxis = list(title = "Data"),
                      yaxis = list(title = "Numero de Acidentes"),
                      zaxis = list(title = "Hora")
         )
  )
