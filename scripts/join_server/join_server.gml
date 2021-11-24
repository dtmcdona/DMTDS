function join_server() {
	oController.menuOpen = false;
		
	//Join server as client
	oController.server = network_create_socket(network_socket_tcp);
	var res = network_connect(oController.server, oController.server_ip, oController.server_port);
		
	if (res < 0) {
		show_error("Error: Couldn't connect to server.", false);
	} else {
		room_goto(rGame);
	}


}
