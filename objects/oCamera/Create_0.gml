/// @description Insert description here
// You can write your code in this editor
#macro RES_W 960
#macro RES_H 540
#macro RES_SCALE 2

#macro CAM_SMOOTH .1

//Enable views
view_enabled = true;
view_visible[0] = true;

player = -1;
camera = camera_create_view(0, 0, RES_W, RES_H);

view_set_camera(0, camera);

//Resize the window & app surface
window_set_size(RES_W * RES_SCALE, RES_H * RES_SCALE);
surface_resize(application_surface, RES_W * RES_SCALE, RES_H * RES_SCALE);

display_set_gui_size(RES_W, RES_H);

var display_width = display_get_width();
var display_height = display_get_height();

var window_width = RES_W * RES_SCALE;
var window_height = RES_H * RES_SCALE;

//Center the window
//window_set_position(display_width/2 - window_width/2, display_height/2 - window_height/2);