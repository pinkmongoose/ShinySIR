library(shiny)
shinyServer(

  function(input,output) {
    
    D<-reactiveValues()
    D$active<-F
    D$err<-F
    source("model.r",local=T)
    
    observeEvent(input$submit, {
      D$err<-F
      ReadParams(input)
      if (!D$err) RunModel()
      D$active<-T
    })
    
    output$plot <- renderPlot({
      if (D$active) DrawGraph()
    })
  
    output$Ioo <- renderText({
      if (D$active) tail(D$R,n=1)+tail(D$I,n=1)
    })
    
  }
  

)
