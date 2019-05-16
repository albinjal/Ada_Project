	with Ada.Command_Line;    use Ada.Command_Line;
	with Ada.Exceptions;      use Ada.Exceptions;
	with Ada.Text_IO;         use Ada.Text_IO;
	with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
	with TJa.Sockets;         use TJa.Sockets;
	with TJa.Window.Text;      use TJa.Window.Text;
	with TJa.Window.Elementary; use TJa.Window.Elementary;
	with TJa.Window.Graphic; use TJa.Window.Graphic;
	with TJa.Keyboard;			use TJa.Keyboard;
	with Yatzy_graphics_package; use Yatzy_graphics_package;
	procedure Test is
	procedure Test_TJa is

	Own_Protocoll, Other_Protocoll: Protocoll_Type;
	Selected_Place : Integer;

	begin
	Reset_Colours;  -- Standard colours is supposed to be black on white ...
	Clear_Window;
	Set_Graphical_Mode(On);
	background;
	protocoll_background(125, 4);
	logo_background(24, 4);
	message(38, 18, "Hejsan");

	-- Draw a rectangle on screen ...
	--Set_Graphical_Mode(On);
	for I in 1..15 loop
		case I is
			when 1 => Own_Protocoll(I) := 1;
			when 2 => Own_Protocoll(I) := 2;
			when 3 => Own_Protocoll(I) := 3;
			when 4 => Own_Protocoll(I) := 4;
			when 5 => Own_Protocoll(I) := 5;
			when 6 => Own_Protocoll(I) := -1;
			when 7 => Own_Protocoll(I) := -1;
			when 8 => Own_Protocoll(I) := -1;
			when 9 => Own_Protocoll(I) := -1;
			when 10 => Own_Protocoll(I) := -1;
			when 11 => Own_Protocoll(I) := -1;
			when 12 => Own_Protocoll(I) := 15;
			when 13 => Own_Protocoll(I) := -1;
			when 14 => Own_Protocoll(I) := 15;
			when 15 => Own_Protocoll(I) := -1;
			when others => null;
			-- Own_Protocoll(I) := I;
		end case;
	end loop;
	for I in 1..15 loop
		Other_Protocoll(I) := I;
	end loop;



	update_protocoll(125, 4, Own_Protocoll, Other_Protocoll);

	for x in 1..5 loop
		dice(x,8 + 15 * x, 38);
	end loop;



	logo(24, 4);

	Set_Graphical_Mode(Off);

	place(Own_Protocoll, Selected_Place);


	Reset_Colours;
	Reset_Text_Modes;  -- Resets boold mode ...



	end Test_TJa;

	begin
		Test_TJa;
		Skip_Line;
	end;
