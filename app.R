library(shiny)
library(bayesrules)
ui <- fluidPage(
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
               label = "Enter number of trials (n)",
               min = 1,
               value = 10),
  numericInput(inputId = "n_success",
               label = "Enter number of successes (y)",
               min = 1,
               value = 8),
  
  plotOutput("some_plot")
  
)
server <- function(input, output) {
  
  output$some_plot <- renderPlot({
   plot_beta_binomial(input$alpha,
              input$beta,
              input$n_success,
              input$n_trial)
  })

}
shinyApp(ui, server)