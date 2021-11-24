/// @description Wander

// If just spawned then wait to move/attack
if(spawnCooldown > 0) { exit; }

//Timer between new movement
wanderTimer++;

// Server sets destination to move towards
if (oController.is_server && (wanderTimer > wanderCooldown)) {
	if (distance_to_point(xdest,ydest) < 5 || (xdest = -1 && ydest = -1)) {
		xdest = irandom_range(startx-wanderRadius,startx+wanderRadius);
		ydest = irandom_range(starty-wanderRadius,starty+wanderRadius);
	}
	wanderTimer = 0;
}