/// @description Reload
if(!is_local) { exit; }
reloading = true;
reloadTimer = reloadMax;
afkTimer = 0;

// Create buffer with reloading bool
var buffer = buffer_create(3, buffer_fixed, 1);
// Buffer position
buffer_write(buffer, buffer_u8, DATA.PLAYER_RELOAD);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_bool, reloading);

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