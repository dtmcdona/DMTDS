/// @description Init Server/Cleint
if (room == rMenu) {
	//Set cursor to a sprite
	window_set_cursor(cr_none);
	var cursor = instance_create_layer(mouse_x,mouse_y,"Cursor",oCursor);
	
	menuOpen = true;
	// Create menu buttons
	event_user(0);
	
	if (keyboard_check_pressed(vk_space)) {
		create_server();
	} else if (keyboard_check_pressed(vk_enter)) {
		join_server();
	}
} else {
	event_user(1);
}

//Game room
if (room == rGame) {
	var window_width = window_get_width()/RES_SCALE;
	var window_height = window_get_height()/RES_SCALE;
	//Fade out the menu
	var menuFade = instance_create_layer(0,0,"Cursor",oFade);
	
	//Spawn player and set id
	var player = instance_create_layer(oPlayerSpawn.x, oPlayerSpawn.y, "Instances", oPlayer);
	player.playerID = 0;
	player.moveSpeed = 6;
	player.spawnCooldown = 20;
	player.currentSpeed = 0;
	player.xdest = -1;
	player.ydest = -1;
	player.attackSpeed = 2;
	player.attackCooldown = 2;
	player.dir = 0;
	player.stamina = 0;
	player.maxStamina = 100;
	player.staminaRegen = 10;
	
	//Store my player as a reference for other objects
	global.myPlayer = player;
	
	var camera = instance_create_layer(oPlayerSpawn.x, oPlayerSpawn.y, "Instances", oCamera);
	camera.player = player;
	
	var chat_width = window_width/3;
	var chat_height = window_height/3;
	var chatBox = instance_create_layer(0, -64+chat_height*2, "GUI", oChatBox);
	chatBox.width = chat_width;
	chatBox.height = chat_height;

	var chatButton = instance_create_layer(0, window_height-64, "GUI", oChatButton);	
	var inventory = instance_create_layer(window_width-256, window_height-64, "GUI", oInventory);
	
	//Add server to the client list
	if (is_server) {
		ds_list_add(clients, -1);
	}
} 