library(shiny)
library(shinythemes)
library(shinyjs)
library(ggthemes)

layer4 <- readRDS("layer4.rds")
layer6 <- readRDS("layer6.rds")
layer7 <- readRDS("layer7.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("flatly"),
                navbarPage("Image Classification Using Deep Learning",
                    tabPanel("Convolution Layers", icon = icon("layer-group"),
                             sidebarLayout(
                                 sidebarPanel(
                                     h5("Image used for classification:"),
                                     img(src="cat_sm.jpg", width = 225),
                                     br(),
                                     br(),
                                     radioButtons("plotLayer", h5("Choose convolution layer to display:"),
                                                  c("Layer 4", "Layer 6", "Layer 7")
                                     )
                                 ),#sidebarPanel
                                 mainPanel(
                                     #img(src = "chan4.jpeg", height = 159),
                                     tags$b("Plot Channel Image:"),
                                     br(),
                                     br(),
                                     br(),
                                     imageOutput("layersChan", height = 159),
                                     br(),
                                     br(),
                                     br(),
                                     tags$b("Layer Activation Plot:"),
                                     plotOutput("layersPlot", height = 400)
                                 )#mainPanel
                             )#sidebarLayout
                             ),#tabPanel
                    tabPanel("About",  icon = icon("code"),
                             mainPanel(includeHTML("markdown.html"))
                            
                    )#tabPanel
                    )#navbarPage            
)#fluidPage

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$layersChan <- renderImage({
        if (input$plotLayer == "Layer 4") {
            list(src="www/chan4.jpeg")
        }
        else if (input$plotLayer == "Layer 6") {
            list(src="www/chan6.jpeg")
        }
        else if (input$plotLayer == "Layer 7") {
            list(src="www/chan7.jpeg")
        }
        
    })
    
    output$layersPlot <- reactivePlot(function() {
        if (input$plotLayer == "Layer 4") {
            plot(layer4)
            
            }
        else if (input$plotLayer == "Layer 6") {
            plot(layer6)
        }
        else if (input$plotLayer == "Layer 7") {
            plot(layer7)
        }
        
    })
    
    
}


# Run the application 
shinyApp(ui = ui, server = server)
