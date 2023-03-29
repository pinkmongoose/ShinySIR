ReadParams <- function(input) {
  D$beta <- input$beta
  D$gamma <- input$gamma
  D$dt <- input$dt
  D$run_time <- input$run_time
  D$time_points <- D$run_time/D$dt
  D$vacc <- input$vacc
  D$I0 <- input$I0
  if (D$I0+D$vacc>1) {
    showModal(modalDialog(title="Error","Initial population exceeds unity."))
    D$err<-T
  }
}

RunModel <- function() {
  t<-S<-I<-R<-array(0,D$time_points)
  S[1] <- 1-D$I0-D$vacc
  I[1] <- D$I0
  R[1] <- t[1] <- 0
  
  for (i in 2:D$time_points) {
    oS <- S[i-1]
    oI <- I[i-1]
    oR <- R[i-1]
    infected <- D$beta*oS*oI*D$dt
    removed <- D$gamma*oI*D$dt
    S[i] <- oS-infected 
    I[i] <- oI+infected-removed
    R[i] <- oR+removed
    t[i] <- t[i-1]+D$dt
  }
 
  D$S<-S
  D$I<-I
  D$R<-R
  D$t<-t
}

DrawGraph <- function() {
  plot(D$t, D$S, col="blue", type="l", ylim=c(0,1), xlim=range(D$t), ylab="population density", xlab="run time",cex.lab=1.75)
  lines(D$t, D$I, col="red", type="l")
  lines(D$t, D$R, col="black", type="l")
  if (D$vacc>0) rect(0,1-D$vacc,max(D$t),1,col="#ccccff",lty="blank")
}

