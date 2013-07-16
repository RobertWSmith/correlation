library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("TEST Upload & Ouput"),
    
    sidebarPanel(
      selectInput("sep", "Input Type:",
                  list("Select One" = "NULL",
                       "Comma Separated File" = ",",
                       "Space Separated File" = " ",
                       "Tab Separated File" = "\t")),
      
      conditionalPanel(("input.sep != ',' && input.sep != 'NULL'"),
                       radioButtons("decimal", "Decimal Indicator",
                                    list("Dot (.)" = ".",
                                         "Comma (,)" = ","),
                                    selected = "Dot (.)")
                       ),
      
      conditionalPanel("input.sep != 'NULL'",
                       fileInput("dataset", "Input Data:", 
                                 accept = c("text/csv", "text/comma-separated-values,text/plain"))
                       ),
      
      checkboxInput("advancedFile", "Advanced File Options", FALSE),
      
      conditionalPanel("input.advancedFile == true",
                       
                       tags$hr(),
                       
                       checkboxInput("header", strong("Header Line Present"), TRUE),
                       
                       checkboxGroupInput("var_missing", strong("Missing Value Indicators:"), 
                                          list("NA" = "NA", 
                                               "(Blank Space)" = "", 
                                               "?" = "?" , 
                                               "#N/A" = "#N/A"),
                                          selected = c("NA"))
      ),
      
      tags$hr(),
      
      actionButton("goButton", "Reload!"),
      
      tags$hr(),
      
      uiOutput("variables"),
      
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
        tabPanel("Correlation Plot", plotOutput("corr_plot")),
        tabPanel("Correlation Matrix", tableOutput("correlation"))
      )
    )
  )
)


