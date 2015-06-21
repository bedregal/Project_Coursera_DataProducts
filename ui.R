library(shiny)
library(ggplot2)

shinyUI(fluidPage(
        title="Galaxy Property Analizer",
        
        fluidRow(
                column(12, 
                        imageOutput("headimage")
                       )
                ),
  
        tabsetPanel(
                #ACTUAL APP TAB
                tabPanel("App", 
                         fluidRow(
                                 column(12,
                                          h4("The Galaxy Analyzer App, allows to perform basic statistical analysis on a catalog
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
                                 )    
                                )
                         ),
                
                tabPanel("Documentation",
                         
                         h2("1.- Introduction"),
                         
                         h4("The Galaxy Analyzer is an application designed to perform basic 
                            statistical analysis on a catalog of ~1,000 galaxies. The catalog 
                            includes a variety of stellar and dust galaxy properties (see the 
                                definition of each one at the end of this document). They were
                          derived using ground- and space-based telescope observations (e.g., 
                          GALEX, Hubble, Spitzer and Herschel Space Telescopes). This App 
                            constitutes my final project for the Coursera Developing Data 
                                Products course."),
                         br(),
                         
                         h2("2.- Basic mode: X versus Y plots"),
                         
                         h4("The basic purpose of this App is to provide a quick and easy way 
                            to plot galaxy parameters versus eachother. Given that many of 
                            these parameters spread in huge ranges (several orders of magnitude)
                            most of them are plotted in log-10 scale. See Sec.3 for a brief
                             description of these parameters."),
                         
                         imageOutput("imBasic"),
                         
                         h4("In the above figure, we see the default appearence of the app.
                            Star formation rate versus stellar mass (both in log-10 scale) are 
                            shown in the right panel. On the left, the user can choose between 11
                            galaxy parameters (which drive the plot) for the X and Y axes. The 
                            plot updetes inmediatly after a new parameter is selected."),
 
                         br(),
                         
                         h2("2.- Linear Fit Mode"),

                         imageOutput("imLinFit"),
                         
                         br(),
                         br(),
                         
                         h4("By clicking on the checkbox named Linear Fit, the user will see 
                            a new display with new information as shown in the above figure.
                                When this option is activated, 
                            the app fits a linear regression model to the data displayed in 
                            the top-right panel. The result of this fit is shown as a blue line 
                            in this figure. Also, the values for slope and intercept are shown 
                            in blue characters in the bottom-right corner of the figure"),
                         
                         h4("In the Linear Fit Mode, the app also show other relevent parameters
                            of the fit that will help the user to assess if the fit is good or 
                            not. First, right below the checkbox, a small table is shown. It displays
                            the slope and intercept of the linear regression, their Standard Errors
                            and their probabilities assumming a 95% confidence intrval."),
                         
                         h4("Below this table, we present in red chracters the Residual Standard Error
                            for the linear fit."),
                         
                         h4("Finally, a new figure apears in the bottom-left of the app. It has 
                            four panels and each correspond to a different diagnostic to evaluate
                            the quality of the fit."),
                         
                         br(),
                         
                         h2("3.- About the galaxy catalog"),
                         
                         h4("Concerning this galaxy catalog, I start by warning the reader that
                            this material is not extrictly public, so it cannot be used or shown
                            in any way unless you have autorization from the authors. For this 
                            reason I neither will describe in detail how this catalog was made nor
                            give exact references of the data/models used to derive these galaxy
                            properties. I will just describe what are these galaxy properties in
                            the simplest possible way. Also, besides the Optical Extinction and
                            Metallicity parameters, all the others are shown in a log-10 scale 
                            in the app plots. This is because most of these properties describe
                            very wide ranges which would be difficult to visualize in a normal
                            linear-scale."),
                         
                         h4("Stellar Mass (M*): It is the total mass of the stars that form a galaxy.
                                In here the stellar mass is provided in units of Solar Mass 
                            (1 Solar Mass = Msun = 2*10^30 kilograms)."),
                         
                         h4("Star Formation Rate (SFR): It is the total number of Solar Masses
                            produced per year at the time we observe the galaxy (e.g., in units of
                            [M*/year])."),
                         
                         h4("Specific SFR (SpecSFR): It is the SFR divided by galaxy stellar mass (e.g., in 
                            units of [1/Giga-year]). This parameter tells us if the galaxy is forming
                            stars efficiently or not."),
                         
                         h4("Age: It is the age of the galaxy at the time we observe it. It is
                            given in units of BILLIONS of years (or Giga-years, or Gyr). Consider the age 
                            of the Universe (time since the Big Bang) is about 13.6 Giga-years."),
                         
                         h4("Metallicity: This indicator tells us how much metals a galaxy has
                            compared to the amount of metals in the Sun. In this context, METALS 
                            are all those chemical elements found in the surface of stars that ARE NOT
                            Hydrogen or Helium. A Metallicity = 1 is a Solar Metallicity."),
                         
                         h4("Total Infrared Luminosity (Ltir): This is the total power (this is
                            [erg/second]) emitted by a galaxy in the infrared (IR) regime (between 
                            photon wavelengths of 8-1,000 microns). In here Ltir is provided in 
                            Solar Luminosities (Lsun, 1Lsun = 3.8*10^33 erg/second)."),
                         
                         h4("24 micron Luminosity (L24): This is the total power (defined in units of
                            [erg/second]) emitted by a galaxy within a broad-band filter approx.
                            centered at 24 microns. In here L24 is provided in 
                            Solar Luminosities."),
                         
                         h4("Optical Extinction (Av): Amount of optical light (in the broad V-band)
                            obscured by the precense of interstellar dust in a galaxy. It is defined 
                            in a magnitude scale such as Av = -2.5*log10(Fobs/Funobs), where Fobs
                            is the obscured observed flux in V-band, and Funobs is the unobscured
                            real emitted flux in V-band."),
                         
                         h4("Dust Mass (Mdust): Total mass of dust grains in a galaxy. It is given 
                            in Msun units."),
                         
                         h4("Time of Formation: It is the age the Universe had when a given galaxy
                            was born (e.g., the galaxy start forming stars.). This time is given in
                            units of Giga-years."),
                         
                         h4("Field: These galaxies were observed in two distinctive areas
                            in the night sky. Galaxies from the first field are flagged as 1
                            and galaxies from the second field, as 2.")
                         
                      )
                 )
))