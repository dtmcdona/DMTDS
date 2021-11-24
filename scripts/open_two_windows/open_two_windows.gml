function open_two_windows() {
	if (parameter_count() == 3) {
		ExecuteShell(parameter_string(0) + " " +
			parameter_string(1) + " " +
			parameter_string(2) + " " +
			parameter_string(3) + " -secondary" + " -tertiary" , false, false)
	
		ExecuteShell(parameter_string(0) + " " +
			parameter_string(1) + " " +
			parameter_string(2) + " " +
			parameter_string(3) + " -secondary" + " -tertiary" + " -aaa" + " -bb" + " -zz" + " -dd" , false, false)
		
			window_set_caption("Server");
			window_set_position(50,300);
	}
	if (parameter_count() > 6) {
	
		window_set_caption("Client 1");
		window_set_position(950, 300);
	} else if (parameter_count() > 3) {
	
		window_set_caption("Client 2");
		window_set_position(950, 300);
	}


}
