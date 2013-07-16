library(shiny)

shinyServer(function(input, output) {
  
  inp_data <- reactive({
    File <- input$inFile
    
    if (is.null(File)) return(NULL);
    
    read.table(File$datapath, header = input$header, sep = input$sep, 
               dec = input$decimal, na.strings = input$var_missing)
  })
  
  output$table <- renderTable({
    data <- inp_data()
#     
#     if (is.null(data)) return(NULL);
#     
#     tbl <- cor(data, na.rm = TRUE, use = "complete.obs", method = input$cor_method)
  })
  
})