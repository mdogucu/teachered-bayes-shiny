library(shiny)
library(bayesrules)
library(ggplot2)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("united"),
                titlePanel("Bayes"),
                tabsetPanel(id = "oneandonly",
                            tabPanel("Prior",
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
                                     numericInput(inputId = "y_upper",
                                                 label = "Choose an upper limit for the y-axis",
                                                 min = 1,
                                                 max = 500,
                                                 value = 10),
                                     plotOutput("prior_plot")),
                            
                            tabPanel("Data",
                                     numericInput(inputId = "n_trial",
                                                  label = "Number of observations/cases",
                                                  min = 1,
                                                  value = 10),
                                     numericInput(inputId = "n_success",
                                                  label = "Number of specified outcomes",
                                                  min = 1,
                                                  value = 8),
                                     plotOutput("posterior_plot")),
                            
                            tabPanel("More Data",
                                     numericInput(inputId = "nn_trial",
                                                  label = "Number of observations/cases",
                                                  min = 1,
                                                  value = 10),
                                     numericInput(inputId = "nn_success",
                                                  label = "Number of specified outcomes",
                                                  min = 1,
                                                  value = 8),
                                     plotOutput("posterior2_plot")),
                            
                            tabPanel("Even more data",
                                     numericInput(inputId = "nnn_trial",
                                                  label = "Number of observations/cases",
                                                  min = 1,
                                                  value = 10),
                                     numericInput(inputId = "nnn_success",
                                                  label = "Number of specified outcomes",
                                                  min = 1,
                                                  value = 8),
                                     plotOutput("posterior3_plot"))
                            
                            
                            
                            )# end of tabsetpanel
                          
                
  
  
)
server <- function(input, output) {
  
  output$prior_plot <- renderPlot({
   plot_beta_binomial(input$alpha,
              input$beta,
              likelihood = FALSE,
              posterior = FALSE) +
      theme(legend.position = "none") +
      ylim(0, input$y_upper) +
      theme_gray(base_size = 16)
    })
    
  output$posterior_plot <- renderPlot({
    plot_beta_binomial(input$alpha,
                       input$beta,
                       input$n_success,
                       input$n_trial) +
      ylim(0, input$y_upper) +
      theme_gray(base_size = 16)
    })  
    
    output$posterior2_plot <- renderPlot({
      plot_beta_binomial(input$alpha + input$n_success,
                         input$beta + input$n_trial - input$n_success,
                         input$nn_success,
                         input$nn_trial) +
        ylim(0, input$y_upper) +
        theme_gray(base_size = 16)
      }) 
      
    output$posterior3_plot <- renderPlot({
        plot_beta_binomial(input$alpha + input$n_success + input$nn_success,
                           input$beta + input$n_trial - input$n_success + input$nn_trial - input$nn_success,
                           input$nnn_success,
                           input$nnn_trial) +
        ylim(0, input$y_upper) +
        theme_gray(base_size = 16)
      
  })

}
shinyApp(ui, server)

# Make pop up windows