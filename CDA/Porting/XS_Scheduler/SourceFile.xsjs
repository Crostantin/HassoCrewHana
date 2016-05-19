function My_table()
{
var query = "{CALL CDA_TMP.HASSO_CREW.CDA.Porting.Procedure::SP_Scrivi_Customer}";
$.trace.debug(query);
var conn = $.db.getConnection();
var pcall = conn.prepareCall(query);
pcall.execute();
pcall.close();
conn.commit();
conn.close();
}