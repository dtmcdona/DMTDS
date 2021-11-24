function create_item_list() {
	var file = file_text_open_read("item_list.txt");
	for (var i = 0; i < 10; ++i;)
	{
	    file_text_write_string(file, "itemID = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "itemType = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "name = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "strength = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "dexterity = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "magic = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "vitality = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "movementSpeed = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "fireRes = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "coldRes = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "lightRes = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "hp = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "mp = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "armor = " +string(i));
	    file_text_writeln(file);
		file_text_write_string(file, "damage = " +string(i));
	    file_text_writeln(file);
	}
	file_text_close(file);



}
