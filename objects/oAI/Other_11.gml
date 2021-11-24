/// @description AI Attack

//Skip if reloading
if(reloading) { exit; }
//Create attack on local
if(!is_local) { exit; }
// If just spawned then wait to move/attack
if(spawnCooldown > 0) { exit; }
//AI has attacked too soon
if (fireRateTimer > 0) {
	exit; 
}
if (ammo < 1) {
	reloading = true;
	reloadTimer = reloadMax;
	exit; 
}
ammo -= 1;

// If player close then attack
if (distance_to_object(instance_nearest(x, y, oPlayer)) < attackRadius) {
	var target = instance_nearest(x, y, oPlayer);
	//Get the angle to fire the projectile
	dir = round(point_direction(x,y,target.x,target.y));
} else {
	exit;
}

fireRateTimer = fireRateMax/delta;

//Make sure attack ID does not exceed 255 bits for buffer
if (attackID < 254) {
	attackID++;
} else {
	attackID = 1;
}
attackCooldown = attackSpeed/delta;
//Create attack
var inst = instance_create_layer(x, y, "Instances", oAttack);
inst.playerID = playerID;
inst.attackID = attackID;
inst.enemeyID = -1;
inst.dir = dir;
inst.is_local = true;

//Debug information
//show_debug_message("Attack Spawned by playerID: " + string(playerID));
//show_debug_message("attackID: " + string(attackID));
//show_debug_message("direction: " + string(dir));

// Create buffer with position
var buffer = buffer_create(13, buffer_fixed, 1);
//Buffer position and direction
buffer_write(buffer, buffer_u8, DATA.ATTACK_SPAWN);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_u8, attackID);
buffer_write(buffer, buffer_s32, x);
buffer_write(buffer, buffer_s32, y);
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