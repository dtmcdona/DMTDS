/// @description Message input
// Input system
if((typing && messageLines < 3) && (string_count(chr(keyboard_key), enabled_keys)) == 1) {
	//Set any special cases for the different input that should not be written
	switch(keyboard_lastchar) {
		case "#" : word += "\#"; break;
		case vk_enter : exit;
		case vk_backspace : exit;
		default : word += keyboard_lastchar; break;
	}
	//Message is built with words and put together for word wrap
	words[wordsIndex] = word;
	if(keyboard_lastchar == " ") {
		word = "";
		wordsIndex++;
	}
	if(messageLength > 23) { 
		word = "";
		wordsIndex++;
	}
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
	if(words[i] != "" && string_length(words[i]) < 19) { message += words[i]; }
	if(string_length(words[i]) >= 19) {
		message += string_copy(words[i],1,floor(string_length(words[i])/2)) +"\n"+ string_copy(words[i],ceil(string_length(words[i])/2),string_length(words[i])-1)
		spacing += padding;
		//messageLines++;	
	}
}
//Fix spacing if it is only one line
if(string_length(message) < 24) { spacing = 0; }