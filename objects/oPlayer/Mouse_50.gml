/// @description Movement destination

// If just spawned then wait to move/attack
if(spawnCooldown > 0) { exit; }

// Client sets destination
if (is_local) {
	xdest = mouse_x;
	ydest = mouse_y;
}

afkTimer = 0;