"This script is in charge of building the 
  ergm model"
# rm(list=ls())
library(parallel)
np = detectCores()
library(statnet)

load(paste("Data/4 R Model/netAdjR.Rdata",sep=""))
print("Adjacency list read successfully!")

# net ~ edges + isolates + gwdegree(0.25) + gwdsp + gwesp 
# build the model from the network
# to add: degree1.5 + degcrossprod + degcor + density + dsp(2) + esp(2) + twopath
start.time <- Sys.time()
myControl = control.ergm(MCMLE.maxit = 100, parallel=np, parallel.type="PSOCK")
netModel <- ergm(net ~ density + isolates + esp(2) + twopath + dsp(2) + degree1.5 + gwdegree(0.25) + gwdsp + gwesp, 
                 control=myControl)
end.time <- Sys.time()
save(netModel, file = paste("Data/5 ERGM Model/netModel.Rdata",sep=""))

