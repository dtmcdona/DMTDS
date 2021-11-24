var _hover = get_hover();
var _click = _hover && mouse_check_button_pressed(mb_left);

if (_click) {
	with (oChatBox) {
		showChat = !showChat;	
	}
}