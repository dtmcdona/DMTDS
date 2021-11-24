/// @description Stats buffer
//Server controls the stats for the ai
if (oController.is_server) {
	if (stamina < maxStamina) { stamina += staminaRegen; }
	if (stamina > maxStamina) { stamina = maxStamina; }	
	if(hp < 0) { hp = 0; }
	// Create buffer with position
	var buffer = buffer_create(7, buffer_fast, 1);
	//Buffer AI stats
	buffer_write(buffer, buffer_u8, DATA.AI_STATS);
	buffer_write(buffer, buffer_u8, playerID);
	buffer_write(buffer, buffer_u8, hp);
	buffer_write(buffer, buffer_u8, stamina);
	buffer_write(buffer, buffer_u8, staminaRegen);
	buffer_write(buffer, buffer_u8, ammo);
	buffer_write(buffer, buffer_u8, extraAmmo);

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
	alarm[1] = 1;
}