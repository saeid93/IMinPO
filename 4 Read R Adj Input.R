args <- commandArgs(TRUE)
numOfNodes <- as.integer(args[1])
library(statnet)

# read the csv file
adjList <- read.csv(paste("Data/3 Reduced/reducedGraph.csv",sep=""),header=FALSE,stringsAsFactors=FALSE)
adjList <- as.matrix(adjList)
attr(adjList,"dimnames") = NULL

# initialize the network
# numOfNodes <- 9877
numOfEdges <- nrow(adjList)

# make the network
net = network.initialize(numOfNodes)
attr(adjList,'n') <- numOfNodes
net = as.network(adjList, matrix.type='edgelist',directed = FALSE)


# save network to the file
save(net, file = paste(paste("Data/4 R Model/netAdjR",sep=""),".Rdata",sep = ""))
