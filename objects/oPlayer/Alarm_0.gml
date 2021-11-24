/// @description Location buffer

//Server controls the stats for the player
if (oController.is_server) {
	// Create buffer with position
	var buffer = buffer_create(8, buffer_fixed, 1);
	//Buffer position
	buffer_write(buffer, buffer_u8, DATA.PLAYER_LOCATION);
	buffer_write(buffer, buffer_u8, playerID);
	buffer_write(buffer, buffer_s16, x);
	buffer_write(buffer, buffer_s16, y);
	buffer_write(buffer, buffer_u16, dir);

	// Send position to server
	if (!oController.is_server) {
		network_send_packet(oController.server, buffer, buffer_get_size(buffer));
	} else {
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
	//Reset Alarm
	alarm[0] = 1;
}