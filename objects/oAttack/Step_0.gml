/// @description Movement and collisions
//Activate/Deactivate objects I can't see
var player = instance_nearest(x,y,oPlayer);
var distance = point_distance(x,y,player.x,player.y);
if(show == false && player.is_local && distance < RES_W) {
	show = true;
} else if (show && player.is_local && distance > RES_W) {
	show = false;	
}

if (duration > 0) { 
	duration--; 
} else {
	instance_destroy();
}

var wall = instance_nearest(x,y,oWall);
if(point_distance(x,y,wall.x, wall.y) < 36) { instance_destroy(); }

//Only the server sends attack position updates
//if (!oController.is_server) { exit; }

//Move projectile towards the destination
image_angle = dir;
direction = dir;
speed = moveSpeed*delta;

//Hit AI
var enemy = instance_nearest(x,y,oAI);
if(point_distance(x,y,enemy.x,enemy.y) <= 48 && enemy.playerID != playerID) {
	enemyID = enemy.playerID;
	event_user(0);
} else if (point_distance(x,y,enemy.x,enemy.y) <= 48 && enemy.playerID = playerID) {
	show = false;
} else {
	show = true;
}
//Hit Player
var enemy = instance_nearest(x,y,oPlayer);
if(point_distance(x,y,enemy.x,enemy.y) <= 48 && enemy.playerID != playerID) {
	enemyID = enemy.playerID;
	event_user(0);
} else if (point_distance(x,y,enemy.x,enemy.y) <= 48 && enemy.playerID = playerID) {
	show = false;
} else {
	show = true;
}
if(duration <= 0) {
	event_user(0);
} else {
	duration--;
}

/***This is old code to update position from the server end
// Create buffer with position
var buffer = buffer_create(13, buffer_fixed, 1);
//Buffer position
buffer_write(buffer, buffer_u8, DATA.ATTACK_UPDATE);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_u8, attackID);
buffer_write(buffer, buffer_s32, x);
buffer_write(buffer, buffer_s32, y);
buffer_write(buffer, buffer_u16, dir);

// Send position from server to the clients
for (var i=0; i<ds_list_size(oController.clients); i++) {
		//Get socket of that client
		var soc = oController.clients[| i];
		//Skip the server
		if(soc < 0) continue;
		//Send data packet
		network_send_packet(soc, buffer, buffer_get_size(buffer));
}
//Delete buffer
buffer_delete(buffer);
*/