/// @desc load_JSON(filename)
/// @arg filename
function load_JSON() {

	var _filename = argument[0];

	var _buffer = buffer_load(_filename);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);

	var _json = json_decode(_string);
	return _json;


}
