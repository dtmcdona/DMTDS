/// @description Insert description here
// You can write your code in this editor
draw_sprite(spr_Buttons,0,x-128,y);
draw_sprite(spr_Buttons,1,x-64,y);
draw_sprite(spr_Buttons,2,x,y);
draw_sprite(spr_Buttons,3,x+64,y);

draw_set_color(c_black);
draw_set_alpha(.2);
if(dodgeCooldown > 0) { draw_rectangle(x-128,y,x-128+64*(dodgeCooldown/dodgeCooldownMax),y+64,0); }
if(blockCooldown > 0) { draw_rectangle(x-64,y,x-64+64*(blockCooldown/blockCooldownMax),y+64,0); }
if(heavyCooldown > 0) { draw_rectangle(x,y,x+64*(heavyCooldown/heavyCooldownMax),y+64,0); }
if(aoeCooldown > 0) { draw_rectangle(x+64,y,x+64+64*(aoeCooldown/aoeCooldownMax),y+64,0); }
draw_set_color(c_white);
draw_set_alpha(1);
