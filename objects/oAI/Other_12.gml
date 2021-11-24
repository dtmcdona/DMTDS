/// @description Patrol

if(patrolX = -1 && patrolY = -1) {
	if(instance_exists(oPatrolPoint)) {
		//Pick a random patrol point nearby
		var randX = irandom_range(x-16,x+16);
		var randY = irandom_range(y-16,y+16);
		var patrolPoint = instance_nearest(randX,randY,oPatrolPoint);
		//Set new destination for movement
		xdest = patrolPoint.x;
		ydest = patrolPoint.y;
		//Set AI to go to position till it collides
		patrolX = xdest;
		patrolY = ydest;
	}
	
	// Create buffer with position
	var buffer = buffer_create(6, buffer_fixed, 1);
	//Buffer position
	buffer_write(buffer, buffer_u8, DATA.AI_UPDATE);
	buffer_write(buffer, buffer_u8, playerID);
	buffer_write(buffer, buffer_s16, xdest);
	buffer_write(buffer, buffer_s16, ydest);

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
}