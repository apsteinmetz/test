## Only run examples in interactive R sessions
if (interactive()) {
  library(dplyr)
  # demoing optgroup support in the `choices` arg
  shinyApp(
    ui = fluidPage(
      selectizeInput("state", "Choose a state:",
                  choices=NULL,
                  multiple=TRUE,
                  options=list(placeholder="Choose")
      ),
      textOutput("result")
    ),
    server = function(input, output,session) {
      updateSelectizeInput(session, "state",
                           
                           choices = as.vector(all_tokens$ArtistToken), server = TRUE)
      output$result <- renderText({
        paste("You chose", input$state)
      })
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)

