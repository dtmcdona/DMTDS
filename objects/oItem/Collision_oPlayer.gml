/// @description Pickup Item

//Check to see if player is picking up their own item
if(other.playerID != playerID) { exit; }

show_debug_message("Picking up item");
// Create buffer to pickup item
var buffer = buffer_create(5, buffer_fixed, 1);
		
//Buffer stats
buffer_write(buffer, buffer_u8, DATA.ITEM_PICKUP);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_u8, itemID);
buffer_write(buffer, buffer_u16, spawnID);

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

if(oController.is_server) {
	var pID = playerID
	var iID = itemID;
	var iSID = spawnID;
	var pickup = false;
	with (oPlayer) {
		if(is_local && playerID == pID) {
			var i = 0;
			if(iID = 1) {
				ammoType1 += oInventory.quantity[iID];
				if(ammoType == 1) { extraAmmo += oInventory.quantity[iID]; }
				pickup = true;
			} else if(iID = 2) {
				ammoType2 += oInventory.quantity[iID];
				if(ammoType == 2) { extraAmmo += oInventory.quantity[iID]; }
				pickup = true;
			} else if(iID = 3) {
				ammoType3 += oInventory.quantity[iID];
				if(ammoType == 3) { extraAmmo += oInventory.quantity[iID]; }
				pickup = true;
			} else {
				while(i < oInventory.slots && pickup == false) {
					if(inv[i] == 0) {
						inv[i] = iID;
						with (oItemTooltip) {
							if(slotID = i) { itemID = iID; }
						}
						pickup = true;
						// Create buffer to delete item
						var buffer = buffer_create(5, buffer_fixed, 1);
						
						//Buffer stats
						buffer_write(buffer, buffer_u8, DATA.ITEM_DESTROY);
						buffer_write(buffer, buffer_u8, pID);
						buffer_write(buffer, buffer_u8, iID);
						buffer_write(buffer, buffer_u16, iSID);

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
					} else {
						i++;
					}
				}
			}
		}
	}
	
	if(pickup) {
		instance_destroy(); 
	}
}