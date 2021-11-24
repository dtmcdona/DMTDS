/// @description Dodge
/*
This code can be used either in the global mouse left released or here.
Dodge gives the player a short speed boost.
*/
if(!is_local) { exit; }

if (oController.is_server) {
	if (dodgeTimer <= dodgeMaxTimer && stamina >= dodgeCost) {
		dodgeTimer = 0;
		stamina -= dodgeCost;
	}
}

// Create buffer with reloading bool
var buffer = buffer_create(3, buffer_fast, 1);
// Buffer position
buffer_write(buffer, buffer_u8, DATA.PLAYER_DODGE);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_u8, dodgeTimer);

// Send reloading to server
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

// Delete buffer
buffer_delete(buffer);