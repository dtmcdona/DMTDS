/// @description Attack

//Skip if not my player
if(!is_local) { exit; }
//Check if mouse right pressed
if(!mouse_check_button(mb_right)) { exit; }
//Skip if reloading
if(reloading) { exit; }
// If just spawned then wait to move/attack
if(spawnCooldown > 0) { exit; }
// Reset AFK Timer
afkTimer = 0;
//Player has attacked too soon
if (fireRateTimer > 0) {
	exit; 
}
if (ammo < 1) {
	reloading = true;
	reloadTimer = reloadMax;
	exit; 
}
ammo -= 1;
ammoString = string(ammo)+"/"+string(extraAmmo);

//Get the angle to fire the projectile
dir = round(point_direction(x,y,mouse_x,mouse_y));
//Make sure attack ID does not exceed 255 bits for buffer
if (attackID < 254) {
	attackID++;
} else {
	attackID = 1;
}
fireRateTimer = fireRateMax/delta;
//Create attack
var inst = instance_create_layer(x, y, "Instances", oAttack);
inst.playerID = playerID;
inst.attackID = attackID;
inst.enemyID = -1;
inst.dir = dir;
inst.is_local = true;

//Debug Log
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

// Send buffer to server
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