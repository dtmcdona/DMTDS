/// @description Insert description here
// You can write your code in this editor
image_speed = 0;

var top = collision_point(x,y-64,oWall,false,true);
var right = collision_point(x+64,y,oWall,false,true);
var bottom = collision_point(x,y+64,oWall,false,true);
var left = collision_point(x-64,y,oWall,false,true);

if(top && !bottom) {
	if(right && !left) {
		image_index = 2;
	} else if (left && !right) {
		image_index = 1;
	} else {
		sprite_index = spr_roof;
		image_index = 0;
	}
} else if (!top && bottom) {
	if(right && !left) {
		image_index = 3;
	} else if (left && !right) {
		image_index = 0;
	} else {
		sprite_index = spr_roof;
		image_index = 0;
	}
} else {
	sprite_index = spr_roof;
	image_index = 0;
}

if(top && right && bottom && left) {
	sprite_index = spr_roof;
	image_index = 1;
} else if(!top && !right && !bottom && !left) {
	sprite_index = spr_box;
}