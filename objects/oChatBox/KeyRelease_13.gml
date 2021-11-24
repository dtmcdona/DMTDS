/// @description Text input
typing = !typing;
if(!typing && message != "") {
	//Clear the message builder
	for (i=0; i<30; i++;) {
		if(words[i] != "") { words[i] = "" }
	}
	
	var bufferSpacing = spacing/padding;
	if(oController.is_server) {
		//Add message to chat box
		for (i = array_length_1d(text); i>0; i--) {
			text[i] = text[i-1];
			chatSpacing[i] = chatSpacing[i-1];
		}
		text[0] = message;
		chatSpacing[0] = bufferSpacing;
		numMessages++;
	}
	
	// Create buffer with message
	var buffer = buffer_create(45, buffer_grow, 1);
	//Buffer position
	buffer_write(buffer, buffer_u8, DATA.PUBLIC_CHAT);
	buffer_write(buffer, buffer_u8, bufferSpacing);
	buffer_write(buffer, buffer_string, message);

	// Send position to server
	if (!oController.is_server) {
		network_send_packet(oController.server, buffer, buffer_get_size(buffer));
	} else {
		for (var i=0; i<ds_list_size(oController.clients); i++) {
			//Get socket of that client
			var soc = oController.clients[| i];
			//Skip the server
			if(soc < 0) continue;
			//Send data packet
			network_send_packet(soc, buffer, buffer_get_size(buffer));
		}
	}
	//Delete buffer
	buffer_delete(buffer);

	//Reset the message variables
	word = "";
	message = "";
	spacing = 0;
	messageLength = 0;
	messageLines = 0;
}
// Reset variables
spacing = 0;
messageLines = 0;
messageLength = 0;
message = "";
//Calculate accurate spacing for the message
for (i=0; i<30; i++;) {
	messageLength += string_length(words[i]);
	if(messageLength > 24) { message += "\n"; spacing += padding; messageLines++; messageLength=0;}
	if(words[i] != "") { message += words[i]; }
}
//Fix spacing if it is only one line
if(string_length(message) < 24) { spacing = 0; }