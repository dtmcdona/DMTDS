/// @description Draw self and stats
draw_sprite_ext(spr_HP2,0,x,y+statsOffset-24,1,1,0,c_red,1);
draw_sprite_ext(spr_HP1,0,x,y+statsOffset-24,hp/maxhp,1,0,c_lime,1);
draw_sprite_ext(spr_Stats1,0,x,y+statsOffset,1,1,0,c_black,1);
draw_sprite_ext(spr_Stamina1,0,x,y+statsOffset-12,stamina/maxStamina,1,0,c_yellow,1);
draw_sprite_ext(spr_Energy1,0,x,y+statsOffset,ammo/magazine,1,0,c_aqua,1);
//draw_text(x-32,y+statsOffset-16,ammoString);
draw_sprite_ext(spr_playerLegs,legSprite,x,y,2.5,2.5,legDir,c_white,1);
draw_sprite_ext(spr_player,0,x,y,1.5,1.5,dir,c_white,1);

draw_set_color(c_black);
draw_text(x-16, y+statsOffset-44, playerID);
draw_set_color(c_white);