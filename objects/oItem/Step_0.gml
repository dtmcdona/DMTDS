/// @description Despawn
despawnTimer--;
if(despawnTimer < 0) { instance_destroy(); }