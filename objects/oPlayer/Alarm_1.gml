/// @description Stats buffer

//Server controls the stats for the player
if (oController.is_server) {
	if (stamina < maxStamina) { stamina += staminaRegen; }
	if (stamina > maxStamina) { stamina = maxStamina; }
	if(hp < 0) { hp = 0; }
	// Create buffer with position
	var buffer = buffer_create(14, buffer_fixed, 1);
	//Buffer stats
	buffer_write(buffer, buffer_u8, DATA.PLAYER_STATS);
	buffer_write(buffer, buffer_u8, playerID);
	buffer_write(buffer, buffer_u8, hp);
	buffer_write(buffer, buffer_u8, stamina);
	buffer_write(buffer, buffer_u8, staminaRegen);
	buffer_write(buffer, buffer_u8, ammo);
	buffer_write(buffer, buffer_u16, ammoType1);
	buffer_write(buffer, buffer_u16, ammoType2);
	buffer_write(buffer, buffer_u16, ammoType3);
	
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
	//Reset Alarm
	alarm[1] = 1;
}