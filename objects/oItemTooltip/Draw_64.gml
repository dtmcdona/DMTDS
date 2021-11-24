/// @description Draw item and display tooltip
if(!oInventory.showInventory) { exit; }

if(itemID != 0) { 
	if(tooltip) {
		//     --- Display all stats listed ---
		draw_set_color(c_gray);
		draw_rectangle(x-192,y-background,x+32,y+32,c_black);
		var position = 16;
		draw_set_color(c_white);
		if(itemType = 2 && ammoType = 1) { draw_text(x-160,y-position,"Ammo: 7.62 cal"); position += offsetY; }
		if(itemType = 2 && ammoType = 2) { draw_text(x-160,y-position,"Ammo: 45 cal"); position += offsetY; }
		if(itemType = 2 && ammoType = 3) { draw_text(x-160,y-position,"Ammo: 12 gauge"); position += offsetY; }
		if(itemType = 1 && quantity != 0) { draw_text(x-160,y-position,"Quantity: "+string(quantity)); position += offsetY; }
		if(magazineSize != 0) { draw_text(x-160,y-position,"Magazine: "+string(magazineSize)); position += offsetY; }
		if(range != 0) { draw_text(x-160,y-position,"Range: "+string(range)); position += offsetY; }
		if(fireRate != 0) { draw_text(x-160,y-position,"RPM: "+string(fireRate)); position += offsetY; }
		if(damage != 0) { draw_text(x-160,y-position,"Damage: "+string(damage)); position += offsetY; }
		draw_text(x-160,y-position,name);
		position += offsetY;
		draw_sprite(spr_items,itemID,x,y);
		//draw_text(x,y,string(itemID));
		if(active) { draw_sprite(spr_activeItem,0,x,y); }
	} else {
		draw_sprite(spr_items,itemID,x,y);
		//draw_text(x,y,string(itemID));
		if(active) { draw_sprite(spr_activeItem,0,x,y); }
	}
} else {
	draw_sprite(spr_items,0,x,y);	
}