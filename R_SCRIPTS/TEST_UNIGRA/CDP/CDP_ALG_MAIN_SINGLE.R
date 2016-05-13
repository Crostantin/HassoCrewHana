setwd("C:\\Users\\jacopo.cervi\\Dropbox\\SAP HANA\\R scripts")
source("C:\\Users\\jacopo.cervi\\Dropbox\\SAP HANA\\R scripts\\CDP_ALG.R")
QUOT <- read.table("lt_comp_quot.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA","NaN", "?") )
COST <- read.table("COST.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA","NaN", "?") )

cdp <- cdp_alg(QUOT,COST)
