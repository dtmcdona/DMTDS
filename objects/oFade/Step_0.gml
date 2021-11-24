/// @description Insert description here
// You can write your code in this editor
if(loadTimer > 0) {
	loadTimer--;
} else if(fadeTimer > 0) {
	fadeTimer--;
} else if (fadeTimer <= 0) {
	instance_destroy();	
}