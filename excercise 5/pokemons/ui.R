#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyBS)
library(shinyWidgets)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Pokedex"),
    setBackgroundImage(src = "https://img.redbull.com/images/c_limit,w_1500,h_1000,f_auto,q_auto/redbullcom/2017/11/08/b9f7fd16-8e4a-42d3-ac7b-49ff0a03efb4/pokemon-red-and-blue"),
    # Sidebar with a slider input for number of bins
    tabsetPanel(
        tabPanel(
            "Pokemon Search",
            br(),
            DT::dataTableOutput("compTable")
        ),
        tabPanel("Chose pokemons to compare",
                 br(),
                 sidebarLayout(
                     sidebarPanel(
                         uiOutput("pokes_to_compare"),
                         br(),
                         br(),
                         uiOutput("selectstats"),
                         br(),
                         submitButton("Compare")
                         
                     ),
                     mainPanel(
                         plotlyOutput("pokemon_plot")
                  )
                 )
                 
        )
        ,
        tabPanel(
            "Current hand of pokemons",
            br(),
            fluidRow(
                column(
                    4,
                    align='center',
                    uiOutput("select1")
                ),
                column(
                    4,
                    align='center',
                    uiOutput("select2")
                ),
                column(
                    4,
                    align='center',
                    uiOutput("select3")
                )
            ),
            fluidRow(
                column(
                    4,
                    align='center',
                    uiOutput("select4")
                ),
                column(
                    4,
                    align='center',
                    uiOutput("select5")
                ),
                column(
                    4,
                    align='center',
                    uiOutput("select6")
                )
            ),
            sidebarPanel(
            uiOutput("selectstats2"),
            submitButton("Compare")
            ),
            mainPanel(
                plotlyOutput("pokemon_plot2")
            )

        ),
        tabPanel(
            "Series Images",
            br(),
            sidebarPanel(
                selectInput("select", label = h3("Select Series"), 
                            choices = list('red&blue'=1,'black&white'=2,'gold&silver'=3,'ruby&sapphire'=4,'x&y'=5), 
                            selected = 1),
                
                br(),
                submitButton("Change "),

                
            
            ),
            mainPanel(
                br(),
                uiOutput("image")
            )
            
                
        )
        
                
   
    )
))
