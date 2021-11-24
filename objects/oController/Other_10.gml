/// @description Create UI
var _width = 300;
var _height = 100;
var spacing = 0;
var xOffset = RES_W*RES_SCALE/2;
var yOffset = RES_H*RES_SCALE*3/4;

create_button(xOffset - _width, yOffset, _width, _height, "Make Game", create_server);
create_button(xOffset, yOffset, _width, _height, "Join Game", join_server);
create_button(xOffset  + _width, yOffset, _width, _height, "Exit", on_click);