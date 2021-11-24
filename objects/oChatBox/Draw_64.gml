/// @description Draw chatbox
if(showChat) {
	//Draw clear chat box
	draw_set_alpha(.5);
	draw_set_color(c_dkgray);
	draw_rectangle(x,y-48-spacing,x+width,y+height,c_black);
	//Draw message chat box
	if(typing) { draw_rectangle(x, y+height-32-spacing,x+width,y+height,c_black); }
	//Draw chat box
	draw_set_alpha(1);
	draw_set_color(c_white);
	for (i = 1; i<8; i++) {
		draw_text(x+16,160-spacing-chatSpacing[i-1]*padding+y-padding*i,text[i-1]);
		i += chatSpacing[i-1];
	}
	//Draw current message
	draw_text(x+16,y+height-padding-spacing,message);
	//draw_text(x,y,wordsIndex);
}