#replica i_table n volte
rep <- function(i_table,n) {
 i_table["IDPRZ"] <- 1
 i_table_tmp <- i_table
  if (n>1){
   for (idprz in 2:n) {
   i_table_tmp["IDPRZ"] <- idprz
   i_table <- rbind(i_table,i_table_tmp)
  }
 }
 i_table <- return(i_table)
}