function create_server() {
	oController.menuOpen = false;
	oController.server = network_create_server(network_socket_tcp, oController.server_port, oController.max_players);
		
	if (oController.server < 0) {
		show_error("Error: Couldn't create server.", false);
	} else {
		room_goto(rGame);
			
		oController.is_server = true;
	}


}
