/// @description Server/Client   

//Gets the type of data from ds map
var type = async_load[? "type"];

//Get client list size
var clientListSize = ds_list_size(clients);

//Player has connected
if (type == network_type_connect) {
	//Gets the socket id from the ds map
	var socket = async_load[? "socket"];
	
	//Create player instance for the connected client
	var index = 1;
	for (var i = 1; i<clientListSize+1; i++) {
		with(oPlayer) {
			if(playerID = index) {
				index++;
			}
		}
	}
	var player = instance_create_layer(oPlayerSpawn.x, oPlayerSpawn.y, "Instances", oPlayer);
	player.playerID = index;
	player.is_local = false;
	player.hp = 100;
	player.maxhp = 100;
	player.moveSpeed = 6;
	player.spawnCooldown = 20;
	player.currentSpeed = 0;
	player.xdest = -1;
	player.ydest = -1;
	player.attackSpeed = 2;
	player.attackCooldown = 2;
	player.dir = 0;
	player.stamina = 0;
	player.maxStamina = 100;
	player.staminaRegen = 10;
	
	//Let player know that they have been connected and how many players are connected
	var buffer = buffer_create(3, buffer_fast, 1);
	
	//Set the type of buffer then write the actual data
	buffer_write(buffer, buffer_u8, DATA.INIT_DATA);
	buffer_write(buffer, buffer_u8, clientListSize);
	buffer_write(buffer, buffer_u8, player.playerID);
	
	//Send the buffer to the specific socket with buffer size
	network_send_packet(socket, buffer, buffer_get_size(buffer));
	
	buffer_delete(buffer);
	
	//Send information to other clients
	var buffer = buffer_create(2, buffer_fast, 1);
	
	buffer_write(buffer, buffer_u8, DATA.PLAYER_JOINED);
	buffer_write(buffer, buffer_u8, player.playerID);
	
	//Send to each client
	for (var i = 0; i<clientListSize; i++) {
		var soc = clients[| i];
		
		if (soc < 0) continue;
		
		network_send_packet(soc, buffer, buffer_get_size(buffer));
	}
	//Delete buffer
	buffer_delete(buffer);
	
	//Add player to the client list
	ds_list_add(clients, index);
	//ds_list_sort(clients, true);
	
	//Debug
	show_debug_message("Number of players: " + string(ds_list_size(clients)));
	if(is_server) {
		for (var i = 0; i<clientListSize+1; i++) {
			show_debug_message(string(i) +": " + string(ds_list_find_value(clients, i)));
		}
	}
} else if (type == network_type_disconnect) {
	//Gets the socket id from the ds map
	var socket = async_load[? "socket"];
	
	
	//Remove player to the client list
	var findSocket = ds_list_find_index(clients, socket);
	ds_list_delete(clients, findSocket);
	ds_list_sort(clients, true);
	
	//Debug
	show_debug_message("Number of players: " + string(ds_list_size(clients)));

	
	if(is_server) {
		for (var i = 0; i<clientListSize+1; i++) {
			show_debug_message(string(i) +": " + string(ds_list_find_value(clients, i)));
		}
	}
	
} else if (type == network_type_data) {
	
	//Receives any data
	var buffer = async_load[? "buffer"];
	
	//Seeks start of buffer
	buffer_seek(buffer, buffer_seek_start, 0);
	
	//Check the data type that is being received
	var data = buffer_read(buffer, buffer_u8);
	
	//INIT_DATA
	if(data == DATA.INIT_DATA) {
		var clientListSize = buffer_read(buffer, buffer_u8);
		var myID = buffer_read(buffer, buffer_u8);
		
		//Loops through list of all players
		for (var i=0; i < clientListSize+1; i++) {
			if (i!=myID) {
				var player = instance_create_layer(oPlayerSpawn.x, oPlayerSpawn.y, "Instances", oPlayer);
				player.playerID = i;
				player.is_local = false;
				player.hp = 100;
				player.maxhp = 100;
				player.moveSpeed = 6;
				player.spawnCooldown = 20;
				player.currentSpeed = 0;
				player.xdest = -1;
				player.ydest = -1;
				player.attackSpeed = 10;
				player.attackCooldown = 20;
				player.dir = 0;
				player.stamina = 0;
				player.maxStamina = 100;
				player.staminaRegen = 10;
			}
		}

		global.myPlayer.playerID = myID;
		
	} else if (data == DATA.PLAYER_JOINED) {
	//PLAYER JOINED
		var inst = instance_create_layer(0, 0, "Instances", oPlayer);
		
		var pID = buffer_read(buffer, buffer_u8);
		inst.playerID = pID;
		inst.is_local = false;
	} else if (data == DATA.PLAYER_DISCONNECT) {
	//PLAYER DISCONNECT
		var pID = buffer_read(buffer, buffer_u8);
		var soc = async_load[? "socket"];
		
		if(instance_exists(oPlayer)) {
			with(oPlayer) {
				if(playerID = pID) {
					instance_destroy();
				}
			}
			with(oItem) {
				if(playerID = pID) {
					instance_destroy();
				}
			}
			if(global.myPlayer.playerID = pID) {
				//Leave server as client
				oController.server = network_destroy(network_socket_tcp);

				//Go to main menu
				oController.menuOpen = true;
				room_goto(rMenu);
			}
		}
		
	} else if (data == DATA.PLAYER_UPDATE) { 
	//PLAYER_UPDATE
		var pID = buffer_read(buffer, buffer_u8);
		var pXDest = buffer_read(buffer, buffer_s16);
		var pYDest = buffer_read(buffer, buffer_s16);
		var pDir = buffer_read(buffer, buffer_u16);
		
		with (oPlayer) {
			if (pID == playerID) {
				xdest = pXDest;
				ydest = pYDest;
				if(!is_local) { dir = pDir; }
			}
		}
		
		// Server forwards destination to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}	
	} else if (data == DATA.PLAYER_LOCATION) { 
	//PLAYER_LOCATION
		var pID = buffer_read(buffer, buffer_u8);
		var pX = buffer_read(buffer, buffer_s16);
		var pY = buffer_read(buffer, buffer_s16);
		var pDir = buffer_read(buffer, buffer_u16);
		
		with (oPlayer) {
			if (pID == playerID) {
				if(point_distance(x,y,pX,pY) > 50) {
					x = pX;
					y = pY;
				}
				if(!is_local) { dir = pDir; }
				if(hp <= 0) {
					xdest = x;
					ydest = y;
				}
			}
		}
		
		// Server forwards position to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}	
	} else if (data == DATA.ATTACK_SPAWN) {
	//ATTACK_SPAWN
		var inst = instance_create_layer(0, 0, "Instances", oAttack);
		
		var pID = buffer_read(buffer, buffer_u8);
		var aID = buffer_read(buffer, buffer_u8);
		var pX = buffer_read(buffer, buffer_s32);
		var pY = buffer_read(buffer, buffer_s32);
		var pDir = buffer_read(buffer, buffer_u16);
		
		inst.playerID = pID;
		inst.attackID = aID;
		inst.x = pX;
		inst.y = pY;
		inst.dir = pDir;
		inst.is_local = false;
		
		with(oPlayer) {
			if(playerID = pID) {
				ammo -= 1;
				if(ammo <= 0) {
					reloading = true;
				}
				dir = pDir;
			}
		}
	} else if (data == DATA.ATTACK_DESTROY) {
	//ATTACK_DESTROY
		var pID = buffer_read(buffer, buffer_u8);
		var aID = buffer_read(buffer, buffer_u8);
		var eID = buffer_read(buffer, buffer_u8);
		var damage = buffer_read(buffer, buffer_u8);
		//Destroy the attack on client side
		with (oAttack) {
			if (pID == playerID && aID == attackID  && eID = enemyID) {
				instance_destroy();
			}
		}
		// Server forwards destroy attack to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.AI_UPDATE) { 
	//AI_UPDATE
		var pID = buffer_read(buffer, buffer_u8);
		
		with (oAI) {
			if (pID == playerID) {
				xdest = buffer_read(buffer, buffer_s16);
				ydest = buffer_read(buffer, buffer_s16);
			}
		}
		
		// Server forwards destination to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.AI_LOCATION) { 
	//AI_LOCATION
		var pID = buffer_read(buffer, buffer_u8);
		var pX = buffer_read(buffer, buffer_s16);
		var pY = buffer_read(buffer, buffer_s16);
		
		with (oAI) {
			if (pID == playerID) {
				if(point_distance(x,y,pX,pY) > 40) {
					x = pX;
					y = pY;
				}
			}
		}
		
		// Server forwards position to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}	
	} else if (data == DATA.AI_SPAWN) {
	//AI_SPAWN
		var inst = instance_create_layer(0, 0, "Instances", oAI);
		
		inst.playerID = buffer_read(buffer, buffer_u8);
		inst.is_local = false;
	} else if (data == DATA.PLAYER_STATS) { 
	//PLAYER_STATS
		var pID = buffer_read(buffer, buffer_u8);
		var pHP = buffer_read(buffer, buffer_u8);
		var pStamina = buffer_read(buffer, buffer_u8);
		var pStaminaRegen = buffer_read(buffer, buffer_u8);
		var pAmmo = buffer_read(buffer, buffer_u8);
		var pAmmoType1 = buffer_read(buffer, buffer_u16);
		var pAmmoType2 = buffer_read(buffer, buffer_u16);
		var pAmmoType3 = buffer_read(buffer, buffer_u16);
		
		with (oPlayer) {
			if (pID == playerID) {
				hp = pHP;
				stamina = pStamina;
				staminaRegen = pStaminaRegen;
				ammo = pAmmo;
				ammoType1 = pAmmoType1;
				ammoType2 = pAmmoType2;
				ammoType3 = pAmmoType3;
			}
		}
		
		// Server forwards stats to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.PLAYER_RELOAD) { 
	//PLAYER_RELOAD
		var pID = buffer_read(buffer, buffer_u8);
		
		with (oPlayer) {
			if (pID == playerID) {
				reloading = buffer_read(buffer, buffer_bool);
				reloadTimer = reloadMax;
			}
		}
		
		// Server forwards position to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}	
	} else if (data == DATA.PLAYER_DODGE) { 
	//PLAYER_DODGE
		var pID = buffer_read(buffer, buffer_u8);
		var pDodgeTimer = buffer_read(buffer, buffer_u8);

		with (oPlayer) {
			if (pID == playerID) {
				dodgeTimer = pDodgeTimer;
				
				if (dodgeTimer <= dodgeMaxTimer && stamina >= dodgeCost) {
					dodgeTimer = 0;
					stamina -= dodgeCost;
				}
			}
		}
		
		// Server forwards position to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}	
	} else if (data == DATA.AI_STATS) { 
	//AI_STATS
		var pID = buffer_read(buffer, buffer_u8);
		var pHP = buffer_read(buffer, buffer_u8);
		var pStamina = buffer_read(buffer, buffer_u8);
		var pStaminaRegen = buffer_read(buffer, buffer_u8);
		var pAmmo = buffer_read(buffer, buffer_u8);
		var pExtraAmmo = buffer_read(buffer, buffer_u8);
		
		with (oAI) {
			if (pID == playerID) {
				hp = pHP;
				stamina = pStamina;
				staminaRegen = pStaminaRegen;
				ammo = pAmmo;
				extraAmmo = pExtraAmmo;
			}
		}
		
		// Server forwards position to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.PUBLIC_CHAT) { 
	//PUBLIC_CHAT
		var pChatSpacing = buffer_read(buffer, buffer_u8);
		var pChatMessage = buffer_read(buffer, buffer_string);
		
		with (oChatBox) {
			//Add message to chat box
			var textArrLength = array_length(text);
			for (a = textArrLength; a>0; a--) {
				text[a] = text[a-1];
				chatSpacing[a] = chatSpacing[a-1];
			}
			chatSpacing[0] = pChatSpacing;
			text[0] = pChatMessage;
			numMessages++;
			word = "";
			message = "";
			spacing = 0;
		}
		
		// Server forwards message to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.ITEM_SPAWN) { 
	//ITEM_SPAWN
		show_debug_message("Spawned item.");
		//Creates unique ID for item
		randomize();
		
		var pID = buffer_read(buffer, buffer_u8);
		var iID = buffer_read(buffer, buffer_u8);
		var itemX = buffer_read(buffer, buffer_s16);
		var itemY = buffer_read(buffer, buffer_s16);
		var iSID = buffer_read(buffer, buffer_u16);
		
		//Create item
		var inst = instance_create_layer(itemX, itemY, "Instances", oItem);
		inst.playerID = pID;
		inst.itemID = iID;
		inst.spawnID = iSID;
		
	} else if (data == DATA.ITEM_PICKUP) { 
	//ITEM_PICKUP
		show_debug_message("Item picked up.");
		//Read in specific item
		var pID = buffer_read(buffer, buffer_u8);
		var iID = buffer_read(buffer, buffer_u8);
		var iSID = buffer_read(buffer, buffer_u16);
		
		with (oPlayer) {
			if(playerID == pID && (is_local || oController.is_server)) {
				var i = 0;
				var pickup = false;
				if(iID = 1) {
					ammoType1 += oInventory.quantity[iID];
					if(ammoType == 1) {
						extraAmmo = ammoType1;
					}
					pickup = true;
				} else if(iID = 2) {
					ammoType2 += oInventory.quantity[iID];
					if(ammoType == 2) {
						extraAmmo = ammoType2;
					}
					pickup = true;
				} else if(iID = 3) {
					ammoType3 += oInventory.quantity[iID];
					if(ammoType == 3) {
						extraAmmo = ammoType3;
					}
					pickup = true;
				} else {
					while(i < 27 && pickup == false) {
						if(inv[i] == 0) {
							inv[i] = iID;
							with (oItemTooltip) {
								if(slotID = i) { itemID = iID; }
							}
							pickup = true;
							// Create buffer to delete item
							var item_buffer = buffer_create(5, buffer_fixed, 1);
						
							//Buffer item destroy
							buffer_write(item_buffer, buffer_u8, DATA.ITEM_DESTROY);
							buffer_write(item_buffer, buffer_u8, pID);
							buffer_write(item_buffer, buffer_u8, iID);
							buffer_write(item_buffer, buffer_u16, iSID);

							// Send item destroy from server
							if (oController.is_server) {
								for (var i = 0; i<clientListSize; i++) {
									//Get socket of that client
									var soc = oController.clients[| i];
									//Skip the server
									if(soc < 0) continue;
									//Send data packet
									network_send_packet(soc, item_buffer, buffer_get_size(buffer));
								}
							}
	
							//Delete buffer
							buffer_delete(item_buffer);
						} else {
							i++;
						}
					}
				}
			}
		}
		
		with(oItem) {
			if (playerID == pID && itemID == iID && spawnID == iSID) {
				instance_destroy();
			}
		}
		
		// Server forwards item pickup to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	} else if (data == DATA.ITEM_DESTROY) { 
	//ITEM_DESTROY
		show_debug_message("Item destroyed.");
		//Read in specific item
		var pID = buffer_read(buffer, buffer_u8);
		var iID = buffer_read(buffer, buffer_u8);
		var iSID = buffer_read(buffer, buffer_u16);
		
		with (oItem) {
			if (pID == playerID && itemID == iID && spawnID == iSID) {
				instance_destroy();
			}
		}
		
		// Server forwards item destroy to other clients
		if(is_server) {
			for (var i = 0; i<clientListSize; i++) {
				var soc = clients[| i];
				
				if (soc < 0 || soc == async_load[? "buffer"]) continue;
				
				network_send_packet(soc, buffer, buffer_get_size(buffer));
			}
		}
	}
	
	//Delete buffer
	buffer_delete(buffer);	
}