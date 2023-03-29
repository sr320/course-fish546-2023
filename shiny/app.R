library(shiny)
library(dplyr)

# Define UI
ui <- fluidPage(
  headerPanel("My First Shiny App"),
  sidebarLayout(
    sidebarPanel(
      # Add input field for the user to provide a value for the column
      textInput("column_value", "Enter value for column:"),
      actionButton("submit", "Submit")
    ),
    mainPanel(
      p("Enter the evalue you want to query."),
      # Add table or other visualizations to display the subset of the table
      tableOutput("table")
    )
  )
)

# Define server
server <- function(input, output) {
  # Read CSV file from GitHub repository
  data <- read.csv("https://raw.githubusercontent.com/sr320/course-fish546-2023/main/output/blast_annot_go.tab", sep = '\t', header = TRUE)
  
  # Define reactive expression to subset table based on user input
 # subset_data <- reactive({
 #   subset(data, V13 == input$column_value) # Replace COLUMN_NAME with the name of the column you want to filter on
 # })
  
  # Assume you have a data frame called "df" with a column called "col"
  # where you want to search for partial matches
  
  partial_match <- function(text, pattern) {
    grepl(pattern, text, ignore.case = TRUE)
  }
  
  # Define a function to filter the data frame
  filter_df <- function(pattern) {
    data[apply(data, 1, partial_match, pattern), ]
  }
  
  # In your Shiny app, create an input text box for the user to input the search term
  textInput("search_term", "Search term:")
  
  # Use an observeEvent to filter the data frame whenever the user inputs a search term
  observeEvent(input$search_term, {
    filtered_df <- filter_df(input$search_term)
    # Use the filtered_df to display the results in your Shiny app
  })
  
  
  
  
  # Render table based on subset_data reactive expression
  output$table <- renderTable({
    filtered_df()
  })
}

# Run the app
shinyApp(ui, server)
