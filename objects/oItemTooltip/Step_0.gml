/// @description Show tooltip
if(!oInventory.showInventory) { exit; }

if(itemID != prevID  && itemID != -1) {
	//Name the item
	name = oInventory.name[itemID];
	//     --- Stats ---
	damage = oInventory.damage[itemID];
	fireRate = oInventory.fireRate[itemID];
	range = oInventory.range[itemID];
	magazineSize = oInventory.magazineSize[itemID];
	itemType = oInventory.itemType[itemID];
	ammoType = oInventory.ammoType[itemID];
	quantity = oInventory.quantity[itemID];
	
	if(damage != 0) { background += offsetY; }
	if(fireRate != 0) { background += offsetY; }
	if(range != 0) { background += offsetY; }
	if(magazineSize != 0) { background += offsetY; }
	if(itemType = 1 && quantity != 0) { background += offsetY; }
	if(itemType = 2 && ammoType != 0) { background += offsetY; }

	prevID = itemID;
}

var hover = get_hover();
if(hover) {
	tooltip = true;
} else {
	tooltip = false;	
}

var mouseClick = hover && mouse_check_button_pressed(mb_left);

if(mouseClick && itemID > 3) {
	var iID = itemID;
	var aType = ammoType;
	var magSize = magazineSize;
	with(oPlayer) {
		if(is_local) {
			weapon = iID;
			fireRate = oInventory.fireRate[iID];
			fireRateMax = 30/(fireRate/60); // 30 steps / (RPM / 60 seconds)
			fireRateTimer = fireRateMax;
			ammo = 0;
			ammoType = aType;
			magazine = magSize;
			reloading = true;
		}
	}
}