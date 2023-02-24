#Librairies
library(maps)
library(leaflet)
library(dplyr)
library(shiny)
library (readxl)

Data_entrants <- read_excel("C:/Users/pauli/Desktop/Git-Larmes/Carte-interactive/Data entrants.xlsx", 
                            col_types = c("text", "text", "text", 
                                          "text", "numeric", "numeric", "numeric", 
                                          "numeric", "numeric"))
View(Data_entrants)

leaflet(Data_entrants %>%
          dplyr::filter(
            Accord == Data_entrants$Accord
          )) %>%
  addTiles() %>%
  addMarkers(lat = ~Latitude, lng=~Longitude) #à compléter

ui <- fluidPage(
  leafletOutput("mymap")
)


ui <- fluidPage(
  titlePanel("My first shiny app"),
  leafletOutput("mymap"),
  fluidRow(column(2,radioButtons("radio", h3("Select the accord"),
                                 choices = list("Bilateral" = "Bilatéral", "ERASMUS" = "ERASMUS", "MEXFITEC"="MEXFITEC", "BRAFITEC"="BRAFITEC", "BRAFAGRI"="BRAFAGRI","ARFITEC"="ARFITEC"),
  ))))

server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    
    leaflet(Data_entrants %>%
              dplyr::filter(
                Accord == input$radio
              )) %>%
      addTiles() %>%
      addMarkers(lat = ~Latitude, lng=~Longitude)
    
    
  })
  
  
}

# finally, we need to call the shinyapp function with the ui and server as arguments

shinyApp(ui, server)
