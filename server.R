library(shiny)


data <- read.table("data_coursera09_proj_v0.cat", skip=1)

shinyServer(
        function(input,output) {
                
                output$headimage <- renderImage({
                        # Return a list containing the filename
                        list(src = "Screen\ Shot\ 2015-06-20\ at\ 20.58.11.png",
                             contentType = 'image/png',
                             width = 750,
                             height = 350)
                             }, deleteFile=F
                        )
                                       
                
                output$XvsY <- renderPlot({
                        if(input$id1 == "1") {xaxis <- log10(as.numeric(data[,3])); xtit="log Stellar Mass"}
                        if(input$id1 == "2") {xaxis <- log10(as.numeric(data[,4])); xtit="log Star Formation Rate"}
                        if(input$id1 == "3") {xaxis <- log10(as.numeric(data[,5])); xtit="log Specific Star Formation Rate"}
                        if(input$id1 == "4") {xaxis <- log10(as.numeric(data[,6])); xtit="log Age"}
                        if(input$id1 == "5") {xaxis <- as.numeric(data[,7]); xtit="Metallicity"}
                        if(input$id1 == "6") {xaxis <- log10(as.numeric(data[,8])); xtit="log Total IR Luminosity"}
                        if(input$id1 == "7") {xaxis <- log10(as.numeric(data[,9])); xtit="log 24 micron Luminosity"}
                        if(input$id1 == "8") {xaxis <- as.numeric(data[,10]); xtit="Optical Extinction"}
                        if(input$id1 == "9") {xaxis <- log10(as.numeric(data[,11])); xtit="log Dust Mass"}
                        if(input$id1 == "10") {xaxis <- log10(as.numeric(data[,12])); xtit="log Age Universe when galaxy forms"}
                        if(input$id1 == "11") {xaxis <- as.numeric(data[,1]); xtit="Observed Field in the Sky"}

                        if(input$id2 == "1")  {yaxis <- log10(as.numeric(data[,3])); ytit="log Stellar Mass"}
                        if(input$id2 == "2")  {yaxis <- log10(as.numeric(data[,4])); ytit="log Star Formation Rate"}
                        if(input$id2 == "3")  {yaxis <- log10(as.numeric(data[,5])); ytit="log Specific Star Formation Rate"}
                        if(input$id2 == "4")  {yaxis <- log10(as.numeric(data[,6])); ytit="log Age"}
                        if(input$id2 == "5")  {yaxis <-       as.numeric(data[,7] ); ytit="Metallicity"}
                        if(input$id2 == "6")  {yaxis <- log10(as.numeric(data[,8])); ytit="log Total IR Luminosity"}
                        if(input$id2 == "7")  {yaxis <- log10(as.numeric(data[,9])); ytit="log 24 micron Luminosity"}
                        if(input$id2 == "8")  {yaxis <-       as.numeric(data[,10]); ytit="Optical Extinction"}
                        if(input$id2 == "9")  {yaxis <- log10(as.numeric(data[,11])); ytit="log Dust Mass"}
                        if(input$id2 == "10") {yaxis <- log10(as.numeric(data[,12])); ytit="log Age Universe when galaxy forms"}
                        if(input$id2 == "11") {yaxis <-       as.numeric(data[,1])  ; ytit="Observed Field in the Sky"}
                        
                        
                        plot(xaxis, yaxis, xlab = xtit, ylab = ytit, col="red", pch=19, cex=0.5)
                        
                        if(input$linfit == TRUE) {
                                lfit <- lm(yaxis ~ xaxis)
                                print(summary(lfit))
                                abline(lfit, lty=1, col="blue", lw=3)
                                xlong=max(xaxis)-min(xaxis)
                                ylong=max(yaxis)-min(yaxis)
                                text(x = c(0.8,0.8)*xlong+min(xaxis), 
                                     y = c(0.1,0.05)*ylong+min(yaxis),
                                     labels=c(paste("LinFit Slope = ",round(lfit$coef[2],digits=2)),
                                              paste("LinFit Intercept = ",round(lfit$coef[1],digits=2))),
                                     col=c("blue","blue")
                                     
                                )
                                      
                                output$Resid <- renderPlot({
                                        #h3("Fit Quality Diagnostics")
                                        par(mfrow=c(2,2),oma=c(0,0,.9,0))
                                        plot(lfit)
                                        title("Linear Fit Quality Diagnostics", outer=T)
                                        print(summary(lfit)$sigma)
                                        #print(lfit$model)
                                })
                                
                                output$Table_lfit <- renderTable(
                                        #data.frame(lfit$coefficients)
                                        data.frame(Params=c("Value", "Std.Error", "Pr(>|t|) 95% CI"),
                                                   Slope=c(summary(lfit)$coefficients[2,1], 
                                                           summary(lfit)$coefficients[2,2],
                                                           summary(lfit)$coefficients[2,4]),
                                                   Intercept=c(summary(lfit)$coefficients[1,1], 
                                                             summary(lfit)$coefficients[1,2],
                                                             summary(lfit)$coefficients[1,4])
                                        )
                                )
                                
                                output$ResStdErr <- renderText(
                                        paste("Residual STD Error = ", round(summary(lfit)$sigma, digits=3))
                                )
                        }
                                 
                })
                
        }
)