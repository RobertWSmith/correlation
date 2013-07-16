library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Correlation"),
    
    sidebarPanel(
      selectInput("sep", "Input Type:",
                  list("Select One" = "NULL",
                       "Comma Separated File" = ",",
                       "Space Separated File" = " ",
                       "Tab Separated File" = "\t")),
      
      checkboxInput("advancedFile", "Advanced File Options", FALSE),
      
      conditionalPanel("input.advancedFile == true",
                       
                       selectInput("header", "Header", 
                                   list("Header Line Present" = TRUE,
                                        "No Header" = FALSE),
                                   selected = "Header"),
                       
                       selectInput("decimal", "Decimal Indicator:",
                                   list("Dot (.)" = ".",
                                        "Comma (,)" = ","),
                                   selected = "Dot (.)"),
                       
                       checkboxGroupInput("var_missing", "Missing Value Indicators:", 
                                          list("NA" = "NA", 
                                               "(Blank Space)" = "", 
                                               "?" = "?" , 
                                               "#N/A" = "#N/A"),
                                          selected = "NA")
      ),
      
      fileInput("inFile", "Input Data:", 
                accept = c("text/csv", "text/comma-separated-values,text/plain")),
      
      tags$hr(),
      
      checkboxInput("advanced", "Advanced Options"),
      
      conditionalPanel("input.advanced == true",
                       
                       selectInput("cor_method", "Choose a Correlation Method:",
                                   choices = list("Pearson's rho" = "pearson",
                                                  "Kendall's tau" = "kendall",
                                                  "Spearman's rho" = "spearman"),
                                   selected = "Pearson's rho"),
                       
                       selectInput("Ha", "Alternative Hypothesis:",
                                   choices = list("Two-Tailed" = "two.sided", 
                                                  "Less Than" = "less", 
                                                  "Greater Than" = "greater"),
                                   selected = "Two-Tailed"),
                       
                       selectInput("conv_lvl", "Confidence Level:",
                                   choices = list("0.50" = 0.5,
                                                  "0.90" = 0.9,
                                                  "0.95" = 0.95,
                                                  "0.99" = 0.99),
                                   selected = "0.95"),
                       
                       radioButtons("cntr_scl", "Center and Scale:",
                                    choices = list("Yes" = TRUE,
                                                   "No" = FALSE),
                                    selected = "No")
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("table", tableOutput("table"))#,
        # tabPanel("summary", verbatimTextOutput("summary"))
      )
    )
  )
)


