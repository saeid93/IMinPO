args <- commandArgs(TRUE)
numOfSim <- as.integer(args[1])
"This script is in charge of making 
  doing the ergm simulations"
library(statnet)
library(parallel)


# rm(list=ls())
np = detectCores()
# curDir = dirname(rstudioapi::getActiveDocumentContext()$path)
# setwd(curDir)
# dataset = "CA-HepTh-2"
modelFile = paste("Data/5 ERGM Model/netModel.Rdata",sep = "")
load(modelFile)
print("model loaded successfully!")
# numOfSim = 1000 # number of desired simulations
start.time <- Sys.time()
for (i in 1:numOfSim){
  simulatedNet <- simulate(netModel, nsim=1 , basis=netModel$newnetwork)
  a = simulatedNet
  simulatedNet <- as.matrix(simulatedNet, matrix.type = 'edgelist',
                            control=control.ergm(parallel=np, parallel.type="PSOCK"))
  write.table( simulatedNet, paste("Data/6 Simulated Networks/",i,"simNet.csv",sep = ""), sep=",",  col.names=FALSE, row.names = FALSE)
  print(paste("network number",i,"has successfuly been created"))
  rm(simulatedNet)
}
end.time <- Sys.time()


