/// @description Init variables
afkTimer = 0;
moveSpeed = 4;
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
attackSpeed = 2;
attackCooldown = 2;
dir = 0;
legDir = 0;
legSprite = 0;

//				   --Statistics--
hp = 100;          //Health points
maxhp = 100;       //Current HP
stamina = 0;       //Stamina
maxStamina = 100;  //Max Stamina
staminaRegen = 10;  //Stamina Regeneration
extraAmmo = 100;   //Extra Ammo
fireRate = 600;    //Rounds per minute (RPM)
fireRateMax = 30/(fireRate/60); // 30 steps / (RPM / 60 seconds)
fireRateTimer = fireRateMax;    // Set timer to max
ammo = 25;         //Current Ammo
magazine = 25;     //Magazine
reloadTimer = 60;  //Ammo Reload
reloadMax = 60;    //Max time to reload
reloading = false; //Reloading
attacking = true;
ammoString = "";
name = "Player";


dodge = false;
dodgeMaxTimer = 60;
dodgeTimer = dodgeMaxTimer;
dodgeSpeed = 1.5;
dodgeCost = 50;
speedBoost = 1;
speedMaxBoost = 1.5;
speedDefault = 1;

statsOffset = -32;

image_speed = 0;
image_index = 0;
image_xscale = 1.5;
image_yscale = 1.5;

//Buffer Switch
//Not eveything needs to be sent every step so this breaks it up.
bufferSwitch = 1;

//Inventory Create
slots = 36; //number of Inventory Slots
equipSlots = 8;
inv = array_create(slots, 0);

//Weapon stuff
weapon = 4;
ammoType = 1;
ammoType1 = 600;
ammoType2 = 0;
ammoType3 = 0;

if(oController.is_server) { 
	alarm[1] = 1; //Stats buffer
	alarm[0] = 1; //Location buffer
	alarm[2] = 60; //AFK buffer
}