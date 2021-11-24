/// @description Draw Self and Stats
//Draw if player can see me!
if(lineOfSight == noone && spawnCooldown == 0) {
	draw_sprite_ext(spr_HP2,0,x,y+statsOffset-24,1,1,0,c_red,1);
	draw_sprite_ext(spr_HP1,0,x,y+statsOffset-24,hp/maxhp,1,0,c_lime,1);
	draw_sprite_ext(spr_Stats1,0,x,y+statsOffset,1,1,0,c_black,1);
	draw_sprite_ext(spr_Stamina1,0,x,y+statsOffset-12,stamina/maxStamina,1,0,c_yellow,1);
	draw_sprite_ext(spr_Energy1,0,x,y+statsOffset,ammo/magazine,1,0,c_aqua,1);
	draw_sprite_ext(spr_enemyLegs,legSprite,x,y,2.5,2.5,legDir,c_white,1);
	draw_self();
}