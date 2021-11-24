/// @description Core Behavior

// If just spawned then wait to move/attack
if(spawnCooldown > 0) {
	spawnCooldown--;
	var spawn = instance_nearest(x,y,oEnemySpawn);
	if(x != spawn.x && y != spawn.y) {
		x = spawn.x;
		y = spawn.y;
		xdest = -1;
		ydest = -1;
		prevX = xdest;
		prevY = ydest;
		patrolX = -1;
		patrolY = -1;
		hp = maxhp;
	}
	exit;
}

//Leg animation
var wall = instance_nearest(x,y,oWall);
if(currentSpeed > 2 && point_distance(x,y,wall.x,wall.y) > 80) {
	legSprite++;
	if(dodgeCooldown < dodgeCooldownMax) { legSprite++; }
	if(legSprite > 13) { legSprite = 0; }
	legDir = round(point_direction(x,y,xdest,ydest));
} else {
	legSprite = 0;
	if(is_local) { legDir = dir; }
}

//Can I see player
var target = instance_nearest(x, y, oPlayer);
lineOfSight = collision_line(x,y,target.x,target.y,oWall,false,true);

// If player close then attack
if (lineOfSight == noone && distance_to_object(instance_nearest(x, y, oPlayer)) < attackRadius) {
	//Point towards player
	image_angle = point_direction(x,y,target.x,target.y);
	event_user(1);	
} else {
	image_angle = point_direction(x,y,xdest,ydest);
}

//Attack cooldown
if (fireRateTimer > 0) { fireRateTimer--; }

//Reloading
if (reloading) {
	reloadTimer--;
	if (reloadTimer <= 0) {
		reloading = false;
		ammo = magazine;
		extraAmmo -= magazine;
	}
}

//Dodge cooldown/Speed
if (dodgeCooldown > 0) {
	dodgeCooldown--; 
	speedBoost = dodgeSpeed;
	image_speed = 1;
} else {
	speedBoost = 1;
	image_speed = 0;
	image_index = 0;
}

//Dodge incoming attack
var dodgeAttack = instance_nearest(x,y,oAttack);
if ((dodgeAttack != noone) && (stamina >= dodgeCost)) {
	var enemyAttack = distance_to_object(dodgeAttack);
	if ((playerID != dodgeAttack.playerID) && (enemyAttack < 128) && (dodgeCooldown <= 0)) {
		dodgeChance = irandom_range(1,4);
		if (dodgeChance < 3 && stamina >= dodgeCost) {
			stamina -= dodgeCost;
			dodgeCooldown = 30;
			wanderTimer = wanderCooldown;
			event_user(0);
		}
	}
}

//Respawn if dead
if(hp <= 0) {
	var killingBlow = instance_nearest(x,y,oPlayer);
	var pID = killingBlow.playerID;
	if(dodgeAttack != noone && dodgeAttack.playerID != playerID) {
		pID = dodgeAttack.playerID;
	}
	oController.player_score++;
	
	//Create item on server
	if(oController.is_server) {
		show_debug_message("Sending item spawn!");
		
		//Increase spawn ID
		oController.spawnID++;
		//Randomise seed
		randomize();
		//Create item ID
		var iID = irandom_range(1,oInventory.numItems);
		
		// Create buffer with position
		var item_buffer = buffer_create(9, buffer_fixed, 1);
		//Buffer position
		buffer_write(item_buffer, buffer_u8, DATA.ITEM_SPAWN);
		buffer_write(item_buffer, buffer_u8, pID);
		buffer_write(item_buffer, buffer_u8, iID);
		buffer_write(item_buffer, buffer_s16, x);
		buffer_write(item_buffer, buffer_s16, y);
		buffer_write(item_buffer, buffer_u16, oController.spawnID);
		
		for (var i=0; i<ds_list_size(oController.clients); i++) {
			//Get socket of that client
			var soc = oController.clients[| i];
			//Skip the server
			if(soc < 0) continue;
			//Send data packet
			network_send_packet(soc, item_buffer, buffer_get_size(item_buffer));
		}
	
		//Delete buffer
		buffer_delete(item_buffer);
		
		//Create item
		var inst = instance_create_layer(x, y, "Instances", oItem);
		inst.playerID = pID;
		inst.itemID = iID;
		inst.spawnID = oController.spawnID;
	}
	
	//Reset AI unit
	spawnCooldown = spawnTimer;
	var spawn = instance_nearest(x,y,oEnemySpawn);
	x = spawn.x;
	y = spawn.y;
	xdest = x;
	ydest = y;
	prevX = xdest;
	prevY = ydest;
	patrolX = -1;
	patrolY = -1;
	hp = maxhp;		
}

//AI can use different movement types
if(movementType == 1) {
	//Patrol
	event_user(2);
} else if(movementType == 2) { 
	//Wander
	if(wander) {
		//Set x and y destination for wander
		event_user(0);
	}
}

//Movement and dodge
if(xdest != -1 && ydest != -1) {
	var dist = point_distance(x,y,xdest,ydest);
	currentSpeed += speedBoost*moveSpeed*delta/6;
	if(currentSpeed > speedBoost*moveSpeed*delta) {
		currentSpeed = speedBoost*moveSpeed*delta;
	}

	if (currentSpeed>dist) { currentSpeed = dist; }
	
	move_towards_point(xdest, ydest, currentSpeed);
}

if (!is_local) { exit; }


//Only send if new xdest and ydest
if (prevX == xdest && prevY == ydest) { exit; }
prevX = xdest;
prevY = ydest;

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