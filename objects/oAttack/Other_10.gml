/// @description Send Destroy from server
if (!oController.is_server) { exit; }

//No enemy ID
if (enemyID == -1) { exit; }

// Create buffer with position
var buffer = buffer_create(6, buffer_fixed, 1);
//Buffer position
buffer_write(buffer, buffer_u8, DATA.ATTACK_DESTROY);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_u8, attackID);
buffer_write(buffer, buffer_u8, enemyID);
buffer_write(buffer, buffer_u8, damage);

var pID = playerID;
var eID = enemyID;
var dmg = damage

//Damage the enemy
with(oPlayer) {
	if(eID == playerID) {
		hp -= dmg;
	}
}

//Damage the enemy
with(oAI) {
	if(eID == playerID) {
		hp -= dmg;
	}
}

//Reward the player
with(oPlayer) {
	if(pID == playerID) {
		//Give xp, loot and etc
	}
}

//Send buffer
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

instance_destroy();