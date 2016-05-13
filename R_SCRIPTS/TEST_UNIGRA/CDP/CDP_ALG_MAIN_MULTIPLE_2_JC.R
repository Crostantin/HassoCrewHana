rm(list=ls())

library(doSNOW)
library(foreach)
library(iterators)

setwd("C:\\Users\\jacopo.cervi\\Dropbox\\SAP HANA\\R scripts")

source("C:\\Users\\jacopo.cervi\\Dropbox\\SAP HANA\\R scripts\\CDP_ALG.R")
source("C:\\Users\\jacopo.cervi\\Dropbox\\SAP HANA\\R scripts\\REP.R")

QUOT <- read.table("lt_comp_quot.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA","NaN", "?") )
COST <- read.table("COST.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA","NaN", "?") )

n <- 5000

QUOT <- as.data.frame(rep(QUOT,n))
COST <- as.data.frame(rep(COST,n))

strt<-Sys.time()

cl<-makeCluster(4)
registerDoSNOW(cl)

quot_f<-data.frame()
cost_f<-data.frame()

tmp <- foreach (v_idprz=1:n, .combine='rbind') %dopar% {
 tmp <- cdp_alg(QUOT[QUOT$IDPRZ==v_idprz,],COST[COST$IDPRZ==v_idprz,])
 quot_tmp <- as.data.frame(tmp[1])
 cost_tmp <- as.data.frame(tmp[2])
 #quot_f <- rbind(quot_f,quot_tmp)
 #cost_f <- rbind(cost_f,cost_tmp)
 return(list(quot_tmp,cost_tmp))
}

stopCluster(cl)

print(Sys.time()-strt)