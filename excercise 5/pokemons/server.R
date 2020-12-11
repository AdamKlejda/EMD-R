#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(ggplot2)
library(dplyr)
library(data.table)
library(kableExtra)
library(plotly)
library(RCurl)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    ##---------Loading data
    pokemonsDf <- reactive({
        temp <- read.table("pokemons.csv", head=TRUE, sep=',')
    })
    ##---------Default table
    
    output$compTable <- DT::renderDataTable({
        DT::datatable(pokemonsDf(),
                      filter="top",
                      escape=TRUE,
                      style= 'default',
                      selection='single'
                      
        )
    })
    
    
    
    ##---------ComparePokemons
    
    output$import_pokemons <- renderDataTable({data()}, options = list(pageLength = 5))
    
    output$pokes_to_compare <-renderUI(
        {
            selectizeInput(inputId = "Pokemon_names",
                           label = "Chose pokemons to compare",
                           choices= pokemonsDf()['name'],
                           multiple = TRUE,
                           selected = c('Charmander','Charmeleon','Charizard'),
                           options = list(
                               maxItems = 3,
                               'plugins' = list('remove_button'),
                               'create' = TRUE,
                               'persist' = FALSE))
        }
    )
    output$selectstats<-renderUI(
        {
            
            checkboxGroupInput(inputId = "stats_to_chose",
                               label = "Chose stats",
                               choices= c('hp','attack','defense','speed','sp_atk','sp_def','exp'),
                               selected =c('hp','attack','defense'))
        }
    )
    
    output$pokemon_plot<- renderPlotly({
        temp <- filter(pokemonsDf(), name %in% input$Pokemon_names )%>%
            melt( id.vars = "name", variable.name = "category", 
                               measure.vars = input$stats_to_chose,
                               value.name="scores")
        
        plot_ly(temp, x=temp$category, y=temp$scores, type="bar", name=temp$name) %>%
            layout(paper_bgcolor='white')
        
    })
    
    ##---------ComparePokemons
    
    output$select1<-renderUI(
        {
            selectInput(
                inputId = "pokemon1",
                label = "Pokemon 1",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Snorlax"
            )
        }
    )
    output$select2<-renderUI(
        {
            selectInput(
                inputId = "pokemon2",
                label = "Pokemon 2",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Venosaur"
            )
        }
    )
    output$select3<-renderUI(
        {
            selectInput(
                inputId = "pokemon3",
                label = "Pokemon 3",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Lapras"
            )
        }
    )
    output$select4<-renderUI(
        {
            selectInput(
                inputId = "pokemon4",
                label = "Pokemon 4",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Starmie"
            )
        }
    )
    output$select5<-renderUI(
        {
            selectInput(
                inputId = "pokemon5",
                label = "Pokemon 5",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Pikachu"
            )
        }
    )
    output$select6<-renderUI(
        {
            selectInput(
                inputId = "pokemon6",
                label = "Pokemon 6",
                choices =  pokemonsDf()['name'],
                multiple = F,
                selected = "Gengar"
            )
        }
    )
    
    output$selectstats2<-renderUI(
        {
            
            checkboxGroupInput(inputId = "stats_to_chose2",
                               label = "Chose stats",
                               choices= c('hp','attack','defense','speed','sp_atk','sp_def','exp'),
                               selected =c('hp','attack','defense'))
        }
    )
    
    output$pokemon_plot2<- renderPlotly({
        temp <- filter(pokemonsDf(), name %in% c(input$pokemon1,input$pokemon2,input$pokemon3) )%>%
            melt( id.vars = "name", variable.name = "category", 
                  measure.vars = input$stats_to_chose2,
                  value.name="scores")
        
        plot_ly(temp, x=temp$category, y=temp$scores, type="bar", name=temp$name) %>%
            layout(paper_bgcolor='white', barmode = 'stack')
        
    })
    

    output$img <- renderPrint({ input$select })
    
    output$image <- renderUI({
        img<-"red_blue.jpg"
        if( input$select == 1){
            img <- "red_blue.jpg"
        }
        if( input$select == 2){
            img <- "black_and_white.jpg"
        }
        if( input$select == 3){
            img <- "gold_and_silver.png"
        }
        if( input$select == 4){
            img <- "ruby_and_sapphire.png"
        }
        if( input$select == 5){
            img <- "xy.jpg"
        }
        fluidRow(
            column(
                4,
                align='center',
                img(src=img, heigh=500, width=500)
            )
        )
    })
    
})
