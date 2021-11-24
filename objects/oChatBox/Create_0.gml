/// @description Instance variables

width = window_get_width()/3;       //Chat window width
height = window_get_height()/3;     //Chat window height
text = array_create(30, "");		//Chat array with the messages
chatSpacing = array_create(30, 0);	//Spacing between messages
word = "";							//Current word for string builder
words = array_create(30, "");		//String builder array for message
wordsIndex = 0;						//Index in string builder
messageLines = 0;					//number of lines for message
spacing = 0;						//Spacing for current written message
padding = 24;						//The amount of space between lines
messageLength = 0;					//Length of lines for word wrap
numMessages = 0;					//Number of messages in chat
message = "";						//Current message that is being written with string builder
cursorSpeed = 20;					//Cursor for the chat window
typing = false;						//The player is typing
enabled_keys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890"
showChat = false;