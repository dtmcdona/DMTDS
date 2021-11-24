/// @description Destroy UI
instance_destroy(oButton);

if(is_server) {
	create_label(0,0,150, 50, "Server")
} else {
	create_label(0,0,150, 50, "Client")
}