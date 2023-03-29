library(shiny)
library(dplyr)

# Define UI
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # Add input field for the user to provide a value for the column
      textInput("column_value", "Enter value for column:"),
      actionButton("submit", "Submit")
    ),
    mainPanel(
      # Add table or other visualizations to display the subset of the table
      tableOutput("table")
    )
  )
)

# Define server
server <- function(input, output) {
  # Read CSV file from GitHub repository
  data <- read.csv("../output/blast_annot_go.tab")
  
  # Define reactive expression to subset table based on user input
  subset_data <- reactive({
    subset(data, Gene.Ontology..biological.process == input$column_value) # Replace COLUMN_NAME with the name of the column you want to filter on
  })
  
  # Render table based on subset_data reactive expression
  output$table <- renderTable({
    subset_data()
  })
}

# Run the app
shinyApp(ui, server)
