/// @description Create AI unit

var ai = instance_create_layer(x, y, "Instances", oAI);
ai.playerID = 3;
if (oController.is_server) {
	ai.is_local = true;
} else {
	ai.is_local = false;	
}
ai.spawnCooldown = 20;
ai.currentSpeed = 0;
ai.xdest = -1;
ai.ydest = -1;
ai.attackSpeed = 10;
ai.attackCooldown = 20;
ai.dir = 0;