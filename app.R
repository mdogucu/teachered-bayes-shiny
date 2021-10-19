library(shiny)
library(bayesrules)
library(ggplot2)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("cerulean"),
  sliderInput(inputId = "alpha",
              label = "Choose the shape parameter (alpha)",
              min = 0.00001,
              max = 50,
              value = 1),
  sliderInput(inputId = "beta",
              label = "Choose the rate parameter (beta) ",
              min = 0.00001,
              max = 50,
              value = 1),
  numericInput(inputId = "n_trial",
               label = "Number of observations/cases",
               min = 1,
               value = 10),
  numericInput(inputId = "n_success",
               label = "Number of specified outcomes",
               min = 1,
               value = 8),
  
  plotOutput("some_plot")
  
)
server <- function(input, output) {
  
  output$some_plot <- renderPlot({
   plot_beta_binomial(input$alpha,
              input$beta,
              input$n_success,
              input$n_trial,
              likelihood = FALSE,
              posterior = FALSE) +
      ylim(0, 6)
  })

}
shinyApp(ui, server)

# Make pop up windows