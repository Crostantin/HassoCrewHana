function generateSessionIdAndToken() {

	var destination = $.net.http.readDestination("HASSO_CREW.XS.SessionId", "localhost");
	var client = new $.net.http.Client();
	var request = new $.net.http.Request($.net.http.GET, "/HASSO_CREW/XS/SessionId/private/getSessionId.xsjs");
	request.headers.set("Authorization", "Basic U2Vzc0lkVGVjaFVzZXI6SW5pdGlhbDIzNA===");
	request.headers.set("X-CSRF-Token", "Fetch");

	client.request(request, destination);
	var response = client.getResponse();

	if (response.status === $.net.http.OK) {
		$.response.status = $.net.http.OK;
		return {
			sessionId : response.cookies.get("xsSessionId"),
			csrfToken : response.headers.get("x-csrf-token")
		};
	}
}

$.response.setBody(JSON.stringify(generateSessionIdAndToken()));