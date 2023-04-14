library(shiny)
library(dplyr)
library(DT)

# Define the UI
ui <- fluidPage(
  headerPanel("My second Shiny App"),
  # Input for the search term
  textInput("search_term", "GO Biological Process Search term:"),
  
  # Table to display the search results
  DTOutput("search_results")
)

# Define the server
server <- function(input, output) {
  # Load the data
  data <- read.csv("https://raw.githubusercontent.com/sr320/course-fish546-2023/main/output/blast_annot_go.tab", sep = '\t', header = TRUE)
  
  # Define a reactive expression to filter the data based on the search term
  filtered_data <- reactive({
    subset(data, grepl(input$search_term, Gene.Ontology..biological.process., ignore.case = TRUE))
  })
  
  # Display the search results in a table
  output$search_results <- renderDT({
    datatable(
      filtered_data(),
      options = list(searchHighlight = TRUE),
      escape = FALSE
    )
  })
}

# Run the app
shinyApp(ui, server)




# 
# # Define UI
# ui <- fluidPage(
#   headerPanel("My First Shiny App"),
#   sidebarLayout(
#     sidebarPanel(
#       # Add input field for the user to provide a value for the column
#       textInput("column_value", "Enter value for column:"),
#       actionButton("submit", "Submit")
#     ),
#     mainPanel(
#       p("Enter the evalue you want to query."),
#       # Add table or other visualizations to display the subset of the table
#       tableOutput("table")
#     )
#   )
# )
# 
# # Define server
# server <- function(input, output) {
#   # Read CSV file from GitHub repository
#   data <- read.csv("https://raw.githubusercontent.com/sr320/course-fish546-2023/main/output/blast_annot_go.tab", sep = '\t', header = TRUE)
#   
#   # Define reactive expression to subset table based on user input
#  subset_data <- reactive({
#    subset(data, V13 == input$column_value) # Replace COLUMN_NAME with the name of the column you want to filter on
#  })
#   
# 
#   
#   # Render table based on subset_data reactive expression
#   output$table <- renderTable({
#     subset_data()
#   })
# }
# 
# # Run the app
# shinyApp(ui, server)
