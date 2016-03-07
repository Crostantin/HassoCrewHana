/**
 * 
 */

sap.ui.jsview("views.sample", {
	/**
	 * Specifies the Controller belonging to this View. In the case that it is
	 * not implemented, or that "null" is returned, this View does not have a
	 * Controller.
	 * 
	 * @memberOf views.Companies
	 */
	getControllerName : function() {
		return null;
	},
	/**
	 * Is initially called once after the Controller has been instantiated. It
	 * is the place where the UI is constructed. Since the Controller is given
	 * to this method, its event handlers can be attached right away.
	 * 
	 * @memberOf views.Companies
	 */
	createContent : function(oController) {

		// Set model
		var oControl;
		var oModel = new sap.ui.model.odata.ODataModel(
				"/HASSO_CREW/XS/CDS_SAMPLE/services/Players.xsodata/", false);
		var oTable = new sap.ui.table.Table("Players", {
			visibleRowCount : 10
		});

		// Table Columns
		
		// add id
		oControl = new sap.ui.commons.TextView().bindProperty("text", "id");
		oTable.addColumn(new sap.ui.table.Column({
			label : new sap.ui.commons.Label({
				text : "Id"
			}),
			template : oControl
		}));
		
		// add name
		oControl = new sap.ui.commons.TextView().bindProperty("text", "Name");
		oTable.addColumn(new sap.ui.table.Column({
			label : new sap.ui.commons.Label({
				text : "Name"
			}),
			template : oControl
		}));

		// add last name
		oControl = new sap.ui.commons.TextView().bindProperty("text", "Last_Name");
		oTable.addColumn(new sap.ui.table.Column({
			label : new sap.ui.commons.Label({
				text : "Last Name"
			}),
			template : oControl
		}));

		oTable.setTitle("Players");
		oTable.setModel(oModel);
		oTable.bindRows("/Players");
		return oTable

	}
});