/// @description Creation Variables

//The unique id for the item
itemID = 0;
//The spawn id that is unique
spawnID = -1;
//The id of player who can loot it
playerID = -1;
//The time it was spawned to prevent duplicates
timestamp = -1;

//Despawn timer to delete old item
despawnTimer = 3600;

/*     --- Item stats ---
*/
name = "";
itemType = -1; // 1 - ammo and 2 - Gun
damage = 0;
range = 0;
magazineSize = 0;
fireRate = 0;
ammoType = 0;
quantity = 0;

image_speed = 0;
