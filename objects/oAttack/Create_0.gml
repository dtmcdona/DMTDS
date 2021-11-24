/// @description All variables
//Local instance
is_local = true;
//ID of player that created attack
playerID = -1;
//ID of the type of attack
attackID = -1;
//ID of the enemy hit
enemyID = -1;
//Direction of the attack
dir = -1;
//Duration of the attack
duration = 120;

show = false;

//Specific information for the attack
moveSpeed = 20;
stun = false; //Attack stun
stunDuration = 0; //Duration of stun
multishot = -1; //Multiple projectiles (-1 is no multishot)
acceleration = 0; //Acceleration
damage = 18; //Amount of damage to inflict
radius = 1; //How big the attack would be (1 being default)
is_spawn = false; //Spawn at mouse click or cast from player
attackType = -1; //Default is -1
is_dot = false; //Damage over time
dotDuration = -1; //How long does DoT last
is_leech = false; //Life leech
leechType = -1; //Type of leech
is_aoe = false; //Area of effect
aoeType = -1; //Type of area of effect
is_heal = false; //Heal target
heal = 0; //Amount of heal
is_hot = false; //Instant or heal over time (HoT)
hotDuration = -1; //Duration of the heal over time