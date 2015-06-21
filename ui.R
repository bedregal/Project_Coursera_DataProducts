library(shiny)
library(ggplot2)

#shinyUI(pageWithSidebar(
shinyUI(fluidPage(#theme = "bootstrap.css",
        title="Galaxy Property Analizer",
        #h1("Galaxy Analizer"),
        fluidRow(
                column(12, 
                        imageOutput("headimage"),
                         h4("The Galaxy Analizer App, allows to perform basic statistical analysis on a catalog
                          of ~1,000 galaxies. The catalog includes a variety of stellar and dust galaxy properties
                          derived using ground- and space-based telescope observations (e.g., GALEX, Hubble Space Telescope, 
                         Spitzer, Herschel). See the documentation for further details on the galaxy catalog and
                         App functionality."),
                        br()
                )
        ),
                
        fluidRow(
                column(2,
                        selectInput("id1", label="X axis",
                                choices=c("Stellar Mass" = "1",
                                  "SFR"          = "2",
                                  "Specific SFR" = "3",
                                  "Age"          = "4",
                                  "Metallicity"  = "5",
                                  "Total IR Lumin"= "6",
                                  "24 micron Lumin"= "7",
                                  "Av"             = "8",
                                  "Dust Mass"     = "9",
                                  "Time Formation" = "10",
                                  "Field in the Sky" = "11")),
                       br(),
                       checkboxInput("linfit", "Linear Fit", value = F),
                       tableOutput("Table_lfit"),
                       textOutput("ResStdErr"),
                       tags$head(tags$style("#ResStdErr{color: red;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
                          )
                       ),
                       br()
                       
                       
                       #dataTableOutput("Stat_lfit")
                ),             
                column(2,
                        selectInput("id2", "Y axis", selected="2",
                                c("Stellar Mass" = "1",
                                  "SFR"          = "2",
                                  "Specific SFR" = "3",
                                  "Age"          = "4",
                                  "Metallicity"  = "5",
                                  "Total IR Lumin"= "6",
                                  "24 micron Lumin"= "7",
                                  "Av"             = "8",
                                  "Dust Mass"     = "9",
                                  "Time Formation" = "10",
                                  "Field in the Sky" = "11"))   
            ),
            column(8,
                plotOutput('XvsY')
            )
        ),
        
        fluidRow(
            column(6,
                plotOutput('Resid') 
                #tableOutput("Table_lfit")
                
                   )    
                )
))