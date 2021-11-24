/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg text
function create_label() {

	// Arguments
	var _x = argument[0];
	var _y = argument[1];
	var _width = argument[2];
	var _height = argument[3];
	var _text = argument[4];

	// Create button
	var _button = instance_create_layer(_x, _y, "GUI", oLabel);

	// Set values
	with (_button) {
		width = _width;
		height = _height;
		text = _text;
	}

	return _button


}
