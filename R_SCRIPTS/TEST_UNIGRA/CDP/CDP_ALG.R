cdp_alg <- function(QUOT,COST) {
#start.time <- Sys.time()

QUOT["VALORE"] <- NA
QUOT["NUMERO_GIORNI_STOCCAGGIO"] <- NA
QUOT["GG_STOCCAGGIO"] <- NA
QUOT["STOCCAGGIO_PERIODO"] <- NA
QUOT["STOCCAGGIO_PERIODO_CHILD"] <- NA
COST[c("COSTO","COSTO_PAR")] <- NA

max_stufe <-  max(QUOT[,"STUFE"])

for (v_stufe in max_stufe:0) {
	
	for (v_wegxx in 0:max(QUOT[QUOT$STUFE == v_stufe,"WEGXX"])){
	 if (v_stufe==0 || v_wegxx>0) {
		mat <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"COMP_KEY"]
		
		if (nrow(QUOT[QUOT$STUFE==v_stufe+1 & QUOT$VWEGX==v_wegxx,])==0) {
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"] <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,'ZQUOT']
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"STOCCAGGIO_PERIODO_CHILD"] <- 0 
			}
		else {
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"] <- QUOT[QUOT$STUFE == v_stufe & QUOT$WEGXX == v_wegxx,'ZQUOT'] + sum(QUOT[QUOT$STUFE == (v_stufe + 1) & QUOT$VWEGX == v_wegxx, "VALORE"])
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"STOCCAGGIO_PERIODO_CHILD"] <- sum(QUOT[QUOT$STUFE == (v_stufe + 1) & QUOT$VWEGX == v_wegxx, "STOCCAGGIO_PERIODO"])
		}
		QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"NUMERO_GIORNI_STOCCAGGIO"] <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"]*(QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"GG_INT"] - QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"ZZGPA"])
		costi <- unique(COST[,"COMP_KEY"])
		if (mat %in% costi) {
		 ordine_max <- max(COST[COST$COMP_KEY==mat,"ORDINE"])
		 for (ordine in 1:ordine_max) {
			costo_par <- (QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"]*COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"ZCOSTOUNPER"]/100) +
			(COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"ZCOSTOUN"]*COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"MNGLG"])
			COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"COSTO"] <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"] + costo_par
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"] <- COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"COSTO"]
			COST[COST$COMP_KEY==mat & COST$ORDINE==ordine,"COSTO_PAR"] <- costo_par
			}
		}
		if (QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"]!=0){
		 QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"GG_STOCCAGGIO"] <- ((QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"NUMERO_GIORNI_STOCCAGGIO"] + QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"STOCCAGGIO_PERIODO_CHILD"])/QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"]) + 
			QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"ZZGMD"]
			}
		else {QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"GG_STOCCAGGIO"] <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"ZZGMD"]}
		QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"STOCCAGGIO_PERIODO"] <- QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"VALORE"]*QUOT[QUOT$STUFE==v_stufe & QUOT$WEGXX==v_wegxx,"GG_STOCCAGGIO"]
	 }
	}		
}

#end.time <- Sys.time()
#time.taken <- end.time - start.time
return(list(QUOT,COST))
}
