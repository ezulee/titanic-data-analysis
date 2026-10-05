#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

# change data "Titanic" from table to dataframe
df <- as.data.frame(Titanic)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Survival of Passengers on the Titanic"),

    # Sidebar with selection of cabin class
    sidebarLayout(
        sidebarPanel(
            selectInput("class_choice",
                        "Select Cabin Class",
                        choices = c("1st", "2nd", "3rd", "Crew")
                        ),
            
            # Demographic -  age
            checkboxGroupInput("age_choice",
                               "Select Age Group",
                               choices = c("Child", "Adult"),
                               selected = c("Adult")
                               ),
            
            # Demograhic - gender
            checkboxGroupInput("gender_choice",
                               "Select Gender Group",
                               choices = c("Male", "Female"),
                               selected = c("Male")
                               ),
        ),
        
        mainPanel(
          tabsetPanel(
            tabPanel("Demographic Info of Passengers and Survived/Not Survived",
                     plotlyOutput("survival_plot"),
                     tableOutput("stats_table")
                     ),
            
            tabPanel("Cabin Class and Survival Rate",
                      plotlyOutput("reg_plot")
                      )
            
          )
  
        )
    )
)

# Define server logic
server <- function(input, output) {
  
  # data filtering
  filtered_df <- reactive({
    df %>%
    filter(Class == input$class_choice,
           Age %in% input$age_choice,
           Sex %in% input$gender_choice) %>%
    group_by(Survived) %>%
    summarise(Count = sum(Freq))
  })
    
    # draw a plot
    output$survival_plot <- renderPlotly({
      d <- filtered_df()
    
      plot_ly(d,
              x = ~Survived,
              y = ~Count,
              type = "bar") %>%
        
        layout(title = "Survivor Statistics",
               xlab = "survived",
               ylab = "number of people")
    })
    
    output$stats_table <- renderTable({filtered_df()})
    
    # calculate survival rate according to cabin class
    reg_data <- reactive({
      df %>%
        group_by(Class, Survived) %>%
        summarise(Count = sum(Freq)) %>%
        group_by(Class) %>%
        mutate(Rate = (Count / sum(Count)) * 100) %>%
        filter(Survived == "Yes") %>%
        mutate(Class_num = as.numeric(Class))
    })
  
    # draw a regression line with ggplot2
    output$reg_plot <- renderPlotly({
      r <- ggplot(reg_data(), aes(x = Class_num, y = Rate)) +
        geom_point(color = "darkred") +
        geom_smooth(method = "lm", color = "darkblue", se = FALSE) +
        scale_x_continuous(breaks = 1:4, labels = c("1st", "2nd", "3rd", "Crew")) +
        labs(x = "Class", y = "Survival Rate (%)") +
        theme_minimal()
      ggplotly(r)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
