/**
 * 
 */

sap.ui.jsview("views.testTable", {

	getControllerName : function() {
		return null;
	},

	createContent : function(oController) {
		
		// set token
		var getCSRFToken = function () {
			$.ajax({
		        url: "http://10.0.2.125:8000/HASSO_CREW/XS/HORSA_ODATA_WORK/index.html",
		        type: "GET",
		        async : false,
		        beforeSend: function (xhr) {
		            xhr.setRequestHeader ("Authorization", "Basic "+g_auth);
		            xhr.setRequestHeader("X-CSRF-Token", "fetch");
		        },
		        success: function(data, textStatus, XMLHttpRequest) {
		        	g_csrf_token = XMLHttpRequest.getResponseHeader('X-CSRF-Token');
		        },
		        error: function (jqXHR, textStatus, errorThrown){
		        	console.log(jqXHR);
		        	console.log(textStatus);
		        	console.log(errorThrown);
		        }
		    });
		};

		
		// Set model
		var oModel = new sap.ui.model.odata.ODataModel(
				"/HASSO_CREW/XS/HORSA_ODATA_WORK/services/OData.xsodata/", false);
		var oTable = new sap.ui.table.Table("Product", {
			visibleRowCount : 10
		});
		
		
		// Table Columns
		var oControl;
		oControl = new sap.ui.commons.TextView().bindProperty("text",
				"PRODUCT_NAME");
		oTable.addColumn(new sap.ui.table.Column({
			label : new sap.ui.commons.Label({
				text : "Name"
			}),
			template : oControl
		}));
		
		/**
		var oControl;
		oControl = new sap.ui.commons.TextView().bindProperty("text",
				"LASTNAME");
		oTable.addColumn(new sap.ui.table.Column({
			label : new sap.ui.commons.Label({
				text : "Last Name"
			}),
			template : oControl
		}));
		 */
		oTable.setTitle("TEST");
		oTable.setModel(oModel);
		oTable.bindRows("/Product");
		return oTable
		
	}
});