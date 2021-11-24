/// @description Init variables

moveSpeed = 6;
spawnCooldown = 20;
spawnTimer = 20;
currentSpeed = 0;
is_local = true;
playerID = -1;
attackID = 1;
xdest = -1;
ydest = -1;
prevX = xdest;
prevY = ydest;
dir = 0;
legDir = 0;
legSprite = 0;
attackSpeed = 2;
attackCooldown = 2;
//				   --Statistics--
hp = 100;          //Health points
maxhp = 100;       //Current HP
stamina = 0;       //Stamina
maxStamina = 100;  //Max Stamina
staminaRegen = 1;  //Stamina Regeneration
extraAmmo = 100;   //Extra Ammo
fireRateTimer = 5;
fireRateMax = 5;
ammo = 25;         //Current Ammo
magazine = 25;     //Magazine
reloadTimer = 60;  //Ammo Reload
reloadMax = 60;    //Max time to reload
reloading = false; //Reloading

statsOffset = -32;

image_speed = 0;
image_index = 0;
image_xscale = 1.5;
image_yscale = 1.5;

//				   --AI STUFF--
lineOfSight = noone;
patrolX = -1;
patrolY = -1;
wander = true;
wanderRadius = 500;
wanderCooldown = 100;
wanderTimer = 0;
startx = x;
starty = y;
attackRadius = 120;
movementType = 1;    //Patrol, wander and stationary
dodge = -1;          //Dodge (No dodge is -1 default)
attackType = -1;     //Types of attacks (-1 Default)
attackSpeed = 20;    //Set speed between attacks
attackCooldown = 20; //Cooldown timer for attacks
attackCost = 50;
dodgeCooldownMax = 30;
dodgeCooldown = dodgeCooldownMax;
dodgeSpeed = 1.5;
dodgeChance = 0;
dodgeCost = 50;
speedBoost = 1;

if(oController.is_server) { 
	alarm[1] = 1; //Stats buffer
	alarm[0] = 10; //Location buffer
}