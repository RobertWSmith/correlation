library(shiny)
library(ggplot2)
library(corrplot)

WD <- getwd()

source(file.path(WD, "functions.R"))
source(file.path(WD, "server.R"))
source(file.path(WD, "ui.R"))

runApp('.')
