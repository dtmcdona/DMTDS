/// @description Init variables
open_two_windows();

draw_texture_flush();
sprite_prefetch(spr_player);

show_debug_overlay(true);

randomize();

menuOpen = false;

server_ip = "127.0.0.1";
server_port = 8000;
max_players = 4;
player_score = 0;
AI_score = 0;

is_server = false;

//Item data
spawnID = 1;
playerID = -1;
timestamp = -1;
numItems = 255;

//Used to identify the types of buffers sent to players
enum DATA {
	INIT_DATA,
	PLAYER_UPDATE,
	PLAYER_LOCATION,
	PLAYER_JOINED,
	PLAYER_DISCONNECT,
	ATTACK_SPAWN,
	ATTACK_UPDATE,
	ATTACK_DESTROY,
	AI_SPAWN,
	AI_UPDATE,
	AI_LOCATION,
	AI_ATTACK,
	PLAYER_STATS,
	PLAYER_RELOAD,
	PLAYER_DODGE,
	AI_STATS,
	PUBLIC_CHAT,
	ITEM_SPAWN,
	ITEM_DESTROY,
	ITEM_PICKUP
}

//List of all the current client socket ID
clients = ds_list_create();
clientSockets = ds_list_create();

//Constant movement speed
global.delta_factor = 1;
#macro delta global.delta_factor