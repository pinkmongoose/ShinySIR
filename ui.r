library(shiny)
shinyUI(
  
  fluidPage(
  titlePanel("SIR model simulation"),
  sidebarLayout(
    sidebarPanel(
      helpText("Select values for the model run and then click 'GO!'."),
      h4("Disease parameters"),
      sliderInput("beta","transmission rate",min=0,max=10,step=0.1,value=2),
      sliderInput("gamma","removal rate",min=0,max=10,step=0.1,value=1),
      h4("Initial conditions"),
      sliderInput("vacc","population vaccinated",min=0,max=1,step=0.01,value=0),
      sliderInput("I0","initial infected population",min=0,max=0.1,step=0.001,value=0.01),
      h4("Simulation parameters"),
      sliderInput("dt","time step",min=0.001,max=0.05,step=0.001,value=0.01),
      sliderInput("run_time","duration of model",min=1,max=100,value=20),
      actionButton("submit","GO!")
    ),
    mainPanel(
      h4("SIR model graph"),
      plotOutput("plot",height="500px"),
      div("---Susceptible population",style="color:blue"),
      div("---Infected population",style="color:red"),
      div("---Removed population",style="color:black"),
      h4("Final epidemic size"),
      textOutput("Ioo")
    )
  )
)

)
