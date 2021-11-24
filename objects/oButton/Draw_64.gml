/// @description Draw self
draw_sprite_ext(spr_button,0,x,y,10,10,0,merge_color(c_ltgray, c_white, hover),1);
draw_set_color(merge_color(c_green, c_lime, hover));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(Sans_24);
draw_text(x, y, text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);