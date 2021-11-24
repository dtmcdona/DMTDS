/// @description Insert description here
// You can write your code in this editor
if(typing) {
	//Remove the last letter out of the word array
	var temp = word;
	word = string_copy(words[wordsIndex],1,string_length(words[wordsIndex])-2);
	if(temp = word) { wordsIndex--; }
	//Copy the shorter word into word array
	words[wordsIndex] = word;
	//If the word is empty then go to previous word index
	if(word == "" && wordsIndex != 0) { word = words[wordsIndex-1]; wordsIndex--; }
	//If the word is a new line then set to null and go back to previous index
	if(word == "\n" && wordsIndex != 0) { words[wordsIndex] = ""; word = words[wordsIndex-1]; wordsIndex--; }
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
	if(words[i] != "" && string_length(words[i]) < 18) { message += words[i]; }
	if(string_length(words[i]) >= 18) {
		message += string_copy(words[i],1,floor(string_length(words[i])/2)) +"\n"+ string_copy(words[i],floor(string_length(words[i])/2),string_length(words[i])-1)
		spacing += padding;
		//messageLines++;	
	}
}
//Fix spacing if it is only one line
if(string_length(message) < 24) { spacing = 0; }