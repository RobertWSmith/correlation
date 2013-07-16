library(shiny)


options(shiny.maxRequestSize=30*1024^2)

shinyServer(function(input, output) {
  
  output$variables <- renderUI({
    
  })
  
  
  conductor <- reactive({
    File <- input$dataset
    
    if (is.null(File)) return(NULL);
    
    temp <- read.table(File$datapath, header = input$header, sep = input$sep, 
               dec = input$decimal, na.strings = input$var_missing)
    
    temp[,sapply(temp, is.numeric)]
  })
  
  output$correlation <- renderTable({
    
    go.ind <- input$goButton
    
    data <- isolate({as.data.frame(conductor())})
    
    #     data <- if (input$cntr_scl) center.and.scale(data)
    
    
    if ((go.ind) == 0) return(NULL);
    
    isolate({cor(data, use = "complete.obs", method = input$cor_method)})
    
  })
  
  output$corr_plot <- renderPlot({
    
    go.ind <- input$goButton
    
    data <- isolate({as.data.frame(conductor())})
    
    if (go.ind == 0) {
      return(NULL)
    } else {
      colnames(data) <- substr(colnames(data), 1, 10)
    }
    
    corrplot(cor(data), method = "circle", type = "lower", diag = FALSE)    
  })
})