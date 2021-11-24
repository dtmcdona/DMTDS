/// @description Insert description here
// You can write your code in this editor
if(showInventory) {
	draw_sprite(spr_inventory,1,x+192,y);
	draw_set_color(c_gray);
	draw_rectangle_color(x+64,y-44-yOffset*6,x+128+xOffset*6,y-yOffset*6,c_gray,c_gray,c_gray,c_gray,c_black);
	draw_set_alpha(.5);
	draw_rectangle_color(x+64,y-44-yOffset*6,x+128+xOffset*6,y-yOffset*6,c_gray,c_black,c_gray,c_black,c_black);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_text(x+120,y-32-yOffset*6,"Inventory");
	draw_set_color(c_white);
	//Weapon
	draw_set_color(c_gray);
	draw_rectangle_color(x+64,y-88-equipYOffset-yOffset*6,x+128+xOffset*6,y-equipYOffset+20,c_gray,c_gray,c_gray,c_gray,c_black);
	draw_set_alpha(.5);
	draw_rectangle_color(x+64,y-88-equipYOffset-yOffset*6,x+128+xOffset*6,y-equipYOffset+20,c_gray,c_black,c_gray,c_black,c_black);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_text(x+120,y-80-equipYOffset-yOffset*6,name[global.myPlayer.weapon]);
	draw_text(x+paddingX*1+equipXOffset,y+32-equipYOffset-paddingY*4-yOffset*1,name[1] + " (" +string(global.myPlayer.ammoType1) +")");
	draw_text(x+paddingX*1+equipXOffset,y+32-equipYOffset-paddingY*3-yOffset*1,name[2] + " (" +string(global.myPlayer.ammoType2) +")");
	draw_text(x+paddingX*1+equipXOffset,y+32-equipYOffset-paddingY*2-yOffset*1,name[3] + " (" +string(global.myPlayer.ammoType3) +")");
	draw_set_color(c_white);	
	draw_sprite_ext(spr_items,global.myPlayer.weapon,x+paddingX*1.5+equipXOffset,y-equipYOffset-paddingY*5.5-yOffset*2,3,3,0,c_white,1);
} else {
	draw_sprite_ext(spr_items,global.myPlayer.weapon,x,y,2,2,0,c_white,1);
	draw_sprite_ext(spr_items,global.myPlayer.weapon-3,x+64,y,2,2,0,c_white,1);
	draw_sprite_ext(spr_items,0,x+128,y,2,2,0,c_white,1);
	draw_text(x+136,y+16,string(global.myPlayer.ammo)+"/");
	
	draw_text(x+156,y+28,string(global.myPlayer.extraAmmo));
	draw_sprite(spr_inventory,0,x+192,y);
}