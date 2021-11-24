/// @description Movement and Respawn

// If just spawned then wait to move/attack
if(spawnCooldown > 2) { hp = maxhp; }
if(spawnCooldown > 0) { spawnCooldown--; }

//Attack cooldown
if (fireRateTimer > 0) { fireRateTimer--; }

if(is_local) {
	dir = round(point_direction(x,y,mouse_x,mouse_y));
}
//Point towards direction facing
image_angle = dir;

//Leg animation
var wall = instance_nearest(x,y,oWall);
if(currentSpeed > 2 && point_distance(x,y,wall.x,wall.y) > 80) {
	legSprite++;
	if(dodgeTimer < dodgeMaxTimer) { legSprite++; }
	if(legSprite > 13) { legSprite = 0; }
	legDir = round(point_direction(x,y,xdest,ydest));
} else {
	legSprite = 0;
	if(is_local) { legDir = round(point_direction(x,y,mouse_x,mouse_y)); }
}

//Reloading
if (reloading) {
	reloadTimer--;
	if (reloadTimer <= 0 && extraAmmo+ammo >= magazine) {
		reloading = false;
		switch(ammoType) {
			case 1:
				ammoType1 += ammo;
				ammo = magazine;
				ammoType1 -= magazine;
				extraAmmo = ammoType1;
				break;
			case 2:
				ammoType2 += ammo;
				ammo = magazine;
				ammoType2 -= magazine;
				extraAmmo = ammoType2;
				break;
			case 3:
				ammoType3 += ammo;
				ammo = magazine;
				ammoType3 -= magazine;
				extraAmmo = ammoType3;
				break;
			
		}
	} else if (reloadTimer <= 0 && extraAmmo+ammo < magazine) {
		reloading = false;
		switch(ammoType) {
			case 1:
				ammoType1 += ammo;
				ammo = ammoType1;
				ammoType1 = 0;
				break;
			case 2:
				ammoType2 += ammo;
				ammo = ammoType2;
				ammoType2 = 0;
				break;
			case 3:
				ammoType3 += ammo;
				ammo = ammoType3;
				ammoType3 = 0;
				break;
			
		}
		extraAmmo = 0;
	}
}
if(ammo > magazine) {
	switch(ammoType) {
		case 1:
			ammoType1 = ammo;
			ammo = magazine;
			ammoType1 -= magazine;
			extraAmmo = ammoType1;
			break;
		case 2:
			ammoType2 = ammo;
			ammo = magazine;
			ammoType2 -= magazine;
			extraAmmo = ammoType2;
			break;
		case 3:
			ammoType3 = ammo;
			ammo = magazine;
			ammoType3 -= magazine;
			extraAmmo = ammoType3;
			break;
			
	}
	reloading = true;
}
ammoString = string(ammo)+"/"+string(extraAmmo);

//Dodge timer controls speed boost
if (dodgeTimer < dodgeMaxTimer) { 
	dodgeTimer++;
	speedBoost = speedMaxBoost;
} else if (dodgeTimer >= dodgeMaxTimer) {
	speedBoost = speedDefault;
}

//Movement and dodge
if(xdest != -1 && ydest != -1) {
	var dist = point_distance(x,y,xdest,ydest);
	if(dist > 1) { 
		currentSpeed += speedBoost*moveSpeed*delta/6;
		if(currentSpeed > speedBoost*moveSpeed*delta) {
			currentSpeed = speedBoost*moveSpeed*delta;
		}
		if (currentSpeed>dist) { currentSpeed = dist; }
		move_towards_point(xdest, ydest, currentSpeed); 
	} else {
		move_towards_point(xdest, ydest, 0); 
		currentSpeed = 0;
	}
}

//AFK
if(currentSpeed = 0) { afkTimer++; }

//Respawn if dead
if(hp <= 0) {
	hp = 0;
	spawnCooldown = spawnTimer;
	var spawn = instance_nearest(x,y,oPlayerSpawn);
	x = spawn.x;
	y = spawn.y;
	xdest = x;
	ydest = y;
	oController.AI_score++;
	alarm[1] = 1;
}

if (!is_local) { exit; }

//Only send if new xdest and ydest
if (prevX == xdest && prevY == ydest) { exit; }
prevX = xdest;
prevY = ydest;

// Create buffer with position
var buffer = buffer_create(8, buffer_fixed, 1);
//Buffer position
buffer_write(buffer, buffer_u8, DATA.PLAYER_UPDATE);
buffer_write(buffer, buffer_u8, playerID);
buffer_write(buffer, buffer_s16, xdest);
buffer_write(buffer, buffer_s16, ydest);
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