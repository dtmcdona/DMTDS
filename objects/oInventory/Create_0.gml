/// @description Insert description here
// You can write your code in this editor

slots = 36; //number of Inventory Slots
equipSlots = 8;
weight = 120; //The amount of weight to carry in a bag
width = 256;
height = 64;

xOffset = 32;
yOffset = 32;
paddingX = 32;
paddingY = 32;

equipXOffset = 64;
equipYOffset = 256;

showInventory = false;

//Generate Item List
numItems = 0;
item_generator();

//Create grid of items
if (!instance_exists(oItemTooltip)) {
	//Inventory
	var i = 0;
	for (var a = 0; a<6 ; a++ ) {
		for (var b = 0; b<6 ; b++ ) {
			//Create item tooltip
			var item = instance_create_layer(x+64+xOffset*a, y-32-yOffset*b, "Tooltip", oItemTooltip);
			item.itemID = oPlayer.inv[i];
			item.slotID = i;
			item.depth = -item.y-i;
			i++;
		}
	}
}