function item_generator() {
	var index = 0;
	name[index] = "None";
	itemType[index] = 0; //Ammo
	damage[index] = 0;
	magazineSize[index] = 0;
	fireRate[index] = 0;
	ammoType[index] = 0;
	quantity[index] = 0;
	
	index++;
	name[index] = "7.62 Cal";
	itemType[index] = 1; //Ammo
	damage[index] = 0;
	magazineSize[index] = 0;
	fireRate[index] = 0;
	ammoType[index] = 1;
	quantity[index] = 120;
	
	index++;	
	name[index] = "45 Cal";
	itemType[index] = 1; //Ammo
	damage[index] = 0;
	magazineSize[index] = 0;
	fireRate[index] = 0;
	ammoType[index] = 2;
	quantity[index] = 120;
	
	index++;	
	name[index] = "12 Gauge";
	itemType[index] = 1; //Ammo
	damage[index] = 0;
	magazineSize[index] = 0;
	fireRate[index] = 0;
	ammoType[index] = 3;
	quantity[index] = 28;
	
	index++;	
	name[index] = "AK-47";
	itemType[index] = 2; //Gun
	damage[index] = 36;
	range[index] = 21;
	magazineSize[index] = 30;
	fireRate[index] = 600;
	ammoType[index] = 1; //7.62
	quantity[index] = 1;
	
	index++;	
	name[index] = "MAC-10";
	itemType[index] = 2; //Gun
	damage[index] = 29;
	range[index] = 11;
	magazineSize[index] = 30;
	fireRate[index] = 800;
	ammoType[index] = 2; //45 cal
	quantity[index] = 1;
	
	index++;	
	name[index] = "Auto Shotgun";
	itemType[index] = 2; //Gun
	damage[index] = 105;
	range[index] = 4;
	magazineSize[index] = 30;
	fireRate[index] = 240;
	ammoType[index] = 3; //12 gauge
	quantity[index] = 1;
	
	oInventory.numItems = index;
}
