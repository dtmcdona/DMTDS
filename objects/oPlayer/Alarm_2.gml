/// @description AFK timer buffer
//Server controls the stats for the player
if (oController.is_server && !is_local) {
	if (afkTimer < 300) {
		alarm[2] = 60;
		exit; 
	}
	// Create buffer with position
	var buffer = buffer_create(14, buffer_fixed, 1);
	//Buffer stats
	buffer_write(buffer, buffer_u8, DATA.PLAYER_DISCONNECT);
	buffer_write(buffer, buffer_u8, playerID);

	
	// Send hp from server
	if (oController.is_server) {
		for (var i=0; i<ds_list_size(oController.clients); i++) {
			//Get socket of that client
			var soc = oController.clients[| i];
			//Skip the server
			if(soc < 0) continue;
			//Send data packet
			network_send_packet(soc, buffer, buffer_get_size(buffer));
		}
	}
	//Delete buffer
	buffer_delete(buffer);
	
	//Delete Player
	instance_destroy();
}
