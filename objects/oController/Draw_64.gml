/// @description Score board
if(room == rMenu) {
	//draw_sprite_ext(spr_logo,0,460,210,3,3,0,c_black,.75);
	draw_sprite_ext(spr_logo,0,RES_W*RES_SCALE/2,RES_H*RES_SCALE/4,5,5,0,c_white,.70);
} else if (room == rGame) {
	draw_set_font(Sans_12)
	draw_set_color(c_gray);
	draw_rectangle(-128+RES_W/2,-10+RES_H/20,128+RES_W/2,30+RES_H/20,c_black);
	draw_set_color(c_green);
	draw_text(-112+RES_W/2,RES_H/20,"Green Team: " +string(player_score));
	draw_set_color(c_red);
	draw_text(16+RES_W/2,RES_H/20,"Red Team: " +string(AI_score));
	draw_set_color(c_white);
}