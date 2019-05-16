	-- graphics
	with TJa.Window.Text;      use TJa.Window.Text;
	with TJa.Window.Elementary; use TJa.Window.Elementary;
	with TJa.Window.Graphic; use TJa.Window.Graphic;
	with TJa.Keyboard;        use TJa.Keyboard;
	with Ada.Text_IO;         use Ada.Text_IO;
	with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
	package body Yatzy_graphics_package is

	-- Colors
	bg_color : String := "[48;5;22m";
	protocoll_frame_bg : String := "[48;5;232m";
	logo_frame_bg : String := "[48;5;232m";
	message_frame_color1 : String := "[48;5;178m";
	message_frame_color2 : String := "[48;5;220m";






	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure place (avaial_points : in Protocoll_Type; select_place : out Integer) is

		Coord_Config_X : Integer := 120;
		Coord_Config_Y : Integer := 5;

		Curr_Index_Selected : Integer := 0;

		Key: Key_Type;
		temp_arraysize: Integer := 0;
		temp_array_index: Integer := 0;
		type dynamic_array is array(Integer range <>) of Integer;

		procedure goto_prev is
			
		begin
			-- Clear screen
			for X in 1..17 loop
				Goto_XY(Coord_Config_X, Coord_Config_Y + X * 2);
				Put(ASCII.ESC & bg_color);
				Put("  ");
				Goto_XY(1000,1000);
			end loop;

			if Curr_Index_Selected = 1 then
				Curr_Index_Selected := 16;
			end if;

			loop
				Curr_Index_Selected := Curr_Index_Selected - 1;
				if avaial_points(Curr_Index_Selected) >= 0 then
					exit;
				end if;
			end loop;

			if Curr_Index_Selected > 6 then
				Goto_XY(Coord_Config_X, Coord_Config_Y + Curr_Index_Selected * 2 + 4);
			else
				Goto_XY(Coord_Config_X, Coord_Config_Y + Curr_Index_Selected * 2);
			end if;
			
			Put("->");
			Goto_XY(1000,1000);
		end goto_prev;

		procedure goto_next is
		
		begin
			-- Clear screen
			for X in 1..17 loop
				Goto_XY(Coord_Config_X, Coord_Config_Y + X * 2);
				Put(ASCII.ESC & bg_color);
				Put("  ");
				Goto_XY(1000,1000);
			end loop;

			if Curr_Index_Selected = 15 then
				Curr_Index_Selected := 0;
			end if;

			loop
				Curr_Index_Selected := Curr_Index_Selected + 1;
				if avaial_points(Curr_Index_Selected) >= 0 then
					exit;
				end if;
				if Curr_Index_Selected = 15 then
					Curr_Index_Selected := 0;
				end if;
			end loop;

			if Curr_Index_Selected > 6 then
				Goto_XY(Coord_Config_X, Coord_Config_Y + Curr_Index_Selected * 2 + 4);
			else
				Goto_XY(Coord_Config_X, Coord_Config_Y + Curr_Index_Selected * 2);
			end if;

			Put("->");
			Goto_XY(1000,1000);
		end goto_next;

	begin

		-- Build array of available slots
		for x in 1..15 loop
			if avaial_points(x) >= 0 then
				temp_arraysize := temp_arraysize + 1;
			end if;
		end loop;

		declare
			test_array : dynamic_array(0..temp_arraysize);
			begin
			for x in 1..15 loop
				if avaial_points(x) >= 0 then
					test_array(temp_array_index) := temp_array_index * 2;
					temp_array_index := temp_array_index + 1;
				end if;
			end loop;
		end;


		--Put("Arraystorlek: "); Put(temp_arraysize,0);

		Set_Buffer_Mode(Off);
		Set_Echo_Mode(Off);

		goto_next;

		loop
			Get_Immediate(Key);

			Goto_XY(Coord_Config_X,Coord_Config_Y);

			if Is_Up_Arrow(Key) then
				goto_prev;
			elsif Is_Down_Arrow(Key) then
				goto_next;
			elsif Is_Return(Key) then
				Put("Index "); Put(Curr_Index_Selected,0); Put(" was selected.");
				select_place := Curr_Index_Selected;
				exit;
			end if;

		end loop;

		Set_Buffer_Mode(On);
		Set_Echo_Mode(On);
	end place;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------













	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure background is

	begin

	-- Skriver ut bakgrundsfärgen för hela terminalen
	for X in 1..300 loop
		for Y in 1..50 loop
			Put(ASCII.ESC & bg_color);
			goto_xy(X, Y);
			Put(' ');
		end loop;
	end loop;
	end background;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure protocoll_background (X_Start, Y_Start: in Integer) is

	begin

	-- Skriver ut ramen kring protokollet
	for X in 1..31 loop
		for Y in 1..41 loop
		Put(ASCII.ESC & protocoll_frame_bg);
		goto_xy((X_Start - 3 + X), (Y_Start - 2 + Y));
		Put(' ');
		end loop;
	end loop;

	-- Skriver ut protokollets bakgrund
	for X in 1..25 loop
		for Y in 1..38 loop
		Put(ASCII.ESC & "[48;5;15m");
		goto_xy(X_Start + X, Y_Start + Y);
		Put(' ');
		end loop;
	end loop;

	end protocoll_background;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type) is
	x : Integer := X_Start;
	y : Integer := Y_Start;
	widthcol1 : constant Integer := 13;
	widthcol2 : constant Integer := 5;
	widthcol3 : constant Integer := 5;
	height: constant Integer := 39;
	text_width: constant Integer := 12;
	points_width: constant Integer := 5;

	begin
	-- Frame
	Set_Background_Colour(White);
	Set_Foreground_Colour(Black);
	-- Skriver ut horisontella linjer
	while y < Y_Start + height loop
		Goto_XY(X_Start + 1, y);
		Put(Horisontal_Line, Times => widthcol1);
		Goto_XY(X_Start + 2 + widthcol1, y);
		Put(Horisontal_Line, Times => widthcol2);
		Goto_XY(X_Start + 3 + widthcol1 + widthcol2, y);
		Put(Horisontal_Line, Times => widthcol3);
		Goto_XY(X_Start + 4 + widthcol1 + widthcol2 + widthcol3, y);
		y := y + 2;
	end loop;

	for I in Y_Start..(Y_Start+height -1) loop
		Goto_XY(X_Start,I);
		if (I + Y_Start) mod 2 /= 0 then
		Put(Vertical_Line);
		Goto_XY(X_Start + 1 + widthcol1,I);
		Put(Vertical_Line);
		Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
		Put(Vertical_Line);
		Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
		Put(Vertical_Line);
		else
		if I =  Y_Start then
			Put(Upper_Left_Corner);
			Goto_XY(X_Start + 1 + widthcol1,I);
			Put(Horisontal_Down);
			Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
			Put(Horisontal_Down);
			Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
			Put(Upper_Right_Corner);
		elsif I = Y_Start+height - 1  then
			Put(Lower_Left_Corner);
			Goto_XY(X_Start + 1 + widthcol1,I);
			Put(Horisontal_Up);
			Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
			Put(Horisontal_Up);
			Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
			Put(Lower_Right_Corner);
		else
			Put(Vertical_Right);
			Goto_XY(X_Start + 1 + widthcol1,I);
			Put(Cross);
			Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
			Put(Cross);
			Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
			Put(Vertical_Left);
		end if;
		end if;
	end loop;

	Set_Graphical_Mode(Off);

	For I in 1..19 loop
		Goto_XY(X_Start + 2, Y_Start - 1 + I * 2);
		--Set_Background_Colour(Blue);
		case I is
			when 1 => Set_Text_Modes(On, Off, Off); Put("Spelare:"); Set_Text_Modes(Off, Off, On);
			when 2 => Put("Ettor");
			when 3 => Put("Tvåor");
			when 4 => Put("Treor");
			when 5 => Put("Fyror");
			when 6 => Put("Femmor");
			when 7 => Put("Sexor"); Set_Text_Modes(On, Off, Off);
			when 8 => Put("Summa:");
			when 9 => Put("BONUS"); Set_Text_Modes(Off, Off, On);
			when 10 => Put("Par");
			when 11 => Put("Två par");
			when 12 => Put("Triss");
			when 13 => Put("Fyrtal");
			when 14 => Put("Kåk");
			when 15 => Put("Liten stege");
			when 16 => Put("Stor stege");
			when 17 => Put("Chans");
			when 18 => Put("Yatzy"); Set_Text_Modes(On, Off, Off);
			when 19 => Put("Summa:");

			when others => null;
		end case;
	end loop;


	For I in 1..19 loop
		Goto_XY(X_Start + 2 + widthcol1, Y_Start - 1 + I * 2);

		case I is
		when 1 => Set_Text_Modes(Off, Off, Off); Put("P1"); Set_Text_Modes(Off, Off, On);
		when 2..7 => if Prot1(I - 1) /= -1 then Put(Prot1(I - 1), 1 + widthcol2 / 2); end if;
		when 8 => Put("Sum:");
		when 9 => Put("BON");
		when 10..18 => if Prot1(I - 3) /= -1 then Put(Prot1(I - 3), 1 + widthcol2 / 2); end if;
		when 19 => Put("Sum:");

		when others => null;
		end case;
	end loop;

	For I in 1..19 loop
		Goto_XY(X_Start + 3 + widthcol1 + widthcol2, Y_Start - 1 + I * 2);
		case I is
		when 1 => Set_Text_Modes(Off, Off, Off); Put("P1"); Set_Text_Modes(Off, Off, On);
		when 2..7 => if Prot2(I - 1) /= -1 then Put(Prot2(I - 1), 1 + widthcol2 / 2); end if;
		when 8 => Put("Sum:");
		when 9 => Put("BON");
		when 10..18 => if Prot2(I - 3) /= -1 then Put(Prot2(I - 3), 1 + widthcol2 / 2); end if;
		when 19 => Put("Sum:");

		when others => null;
		end case;
	end loop;

	end update_protocoll;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------









	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure dice (A, X_Start, Y_Start: in Integer) is

	begin
	Goto_XY(X_Start, Y_Start);
	for I in 1..5 loop
		--Set_Background_Colour(White);
		if I = 1 then
		Put(Upper_Left_Corner);
		Put(Horisontal_Very_High_Line, Times => 9);
		Put(Upper_Right_Corner);
		Goto_XY(X_Start, Y_Start + I);
		elsif I = 5 then
		Put(Lower_Left_Corner);
		Put(Horisontal_Very_Low_Line, Times => 9);
		Put(Lower_Right_Corner);
		else
		case A is
			when 1 =>
			Put(Vertical_Line);
			if I = 3 then
			Put("    •    ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 2 or I = 4 then
			Put("         ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			end if;

			when 2 =>
			Put(Vertical_Line);
			if I = 2 then
			Put("  •      ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 3 then
			Put("         ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 4 then
			Put("      •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			end if;

			when 3 =>
			Put(Vertical_Line);
			if I = 2 then
			Put("  •      ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 3 then
			Put("    •    ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 4 then
			Put("      •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			end if;

			when 4 =>
			Put(Vertical_Line);
			if I = 2 then
			Put("  •   •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 3 then
			Put("         ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 4 then
			Put("  •   •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			end if;

			when 5 =>
			Put(Vertical_Line);
			if I = 2 then
			Put("  •   •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 3 then
			Put("    •    ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			elsif I = 4 then
			Put("  •   •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);
			end if;

			when 6 =>
			Put(Vertical_Line);
			Put("  •   •  ");
			Put(Vertical_Line);
			Goto_XY(X_Start, Y_Start + I);

			when others => null;
		end case;
		end if;
	end loop;


	end dice;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------















	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	Procedure logo_background (X_Start, Y_Start : in Integer) is

	begin
	for X in 1..76 loop
		for Y in 1..9 loop
		Put(ASCII.ESC & logo_frame_bg);
		goto_xy((X_Start - 3 + X), (Y_Start - 2 + Y));
		Put(' ');
		end loop;
	end loop;
	end logo_background;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------












	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	Procedure logo (X_Start, Y_Start : in Integer) is

	begin
	Set_Background_Colour(White);
	Set_Foreground_Colour(Blue);
	Set_Bold_Mode(on);

	goto_xy(X_Start, Y_Start);
	Put("  ____  ____         __         _________      ________      ____  ____ ");
	goto_xy(X_Start, Y_Start + 1);
	Put(' ');
	Put(Vertical_Line);
	Put("_  _");
	Put(Vertical_Line, Times => 2);
	Put("_  _");
	Put(Vertical_Line);
	Put("       /  \       ");
	Put(Vertical_Line);
	Put("  _   _  ");
	Put(Vertical_Line);
	Put("    ");
	Put(Vertical_Line);
	Put("  __  __");
	Put(Vertical_Line);
	Put("    ");
	Put(Vertical_Line);
	Put("_  _");
	Put(Vertical_Line, Times => 2);
	Put("_  _");
	Put(Vertical_Line);
	goto_xy(X_Start, Y_Start + 2);
	Put("   \ \  / /        / /\ \      ");
	Put(Vertical_Line);
	Put("_/ ");
	Put(Vertical_Line);
	Put(' ');
	Put(Vertical_Line);
	Put(" \_");
	Put(Vertical_Line);
	Put("    ");
	Put(Vertical_Line);
	Put("_/ / /         \ \  / /  ");
	goto_xy(X_Start, Y_Start + 3);
	Put("    \ \/ /        / ____ \         ");
	Put(Vertical_Line);
	Put(' ');
	Put(Vertical_Line);
	Put("           / /  _        \ \/ /   ");
	goto_xy(X_Start, Y_Start + 4);
	Put("    _");
	Put(Vertical_Line);
	Put("  ");
	Put(Vertical_Line);
	Put("_      _/ /    \ \_      _");
	Put(Vertical_Line);
	Put(' ');
	Put(Vertical_Line);
	Put("_         / /__/ ");
	Put(Vertical_Line);
	Put("       _");
	Put(Vertical_Line);
	Put("  ");
	Put(Vertical_Line);
	Put("_   ");
	goto_xy(X_Start, Y_Start + 5);
	Put("   ");
	Put(Vertical_Line);
	Put("______");
	Put(Vertical_Line);
	Put("    ");
	Put(Vertical_Line);
	Put("____");
	Put(Vertical_Line);
	Put("  ");
	Put(Vertical_Line);
	Put("____");
	Put(Vertical_Line);
	Put("    ");
	Put(Vertical_Line);
	Put("_____");
	Put(Vertical_Line);
	Put("       ");
	Put(Vertical_Line);
	Put("_______");
	Put(Vertical_Line);
	Put("      ");
	Put(Vertical_Line);
	Put("______");
	Put(Vertical_Line);
	Put("  ");
	goto_xy(X_Start, Y_Start + 6);
	Put("                                                                        ");

	--  ____  ____         __         _________      ________      ____  ____
	-- |_  _||_  _|       /  \       |  _   _  |    |  __  __|    |_  _||_  _|
	--   \ \  / /        / /\ \      |_/ | | \_|    |_/ / /         \ \  / /
	--    \ \/ /        / ____ \         | |           / /  _        \ \/ /
	--    _|  |_      _/ /    \ \_      _| |_         / /__/ |       _|  |_
	--   |______|    |____|  |____|    |_____|       |_______|      |______|

	end logo;
	
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	
	
	
	
	
	
	
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	
	procedure message (X_Start, Y_Start : in Integer) is

	begin

	Set_Graphical_Mode(Off);
	
	for Y in 1..11 loop
		for X in 1..42 loop

			-- om inte första eller inte sista raden
			if Y = 1 OR Y = 11 then
					if X mod 2 = 0 then
						Put(ASCII.ESC & message_frame_color1);
					else
						Put(ASCII.ESC & message_frame_color2);
					end if;
			else
				if X = 1 OR X = 41 then
					if Y mod 2 = 0 then
						Put(ASCII.ESC & message_frame_color1);
					else
						Put(ASCII.ESC & message_frame_color2);
					end if;
				else
					if Y mod 2 = 0 then
						Put(ASCII.ESC & message_frame_color2);
					else
						Put(ASCII.ESC & message_frame_color1);
					end if;
				end if;
			end if;

		goto_xy((X_Start - 2 + X), (Y_Start - 1 + Y));
		Put(' ');

		end loop;
	end loop;



	-- White inner frame
	for X in 1..38 loop
		for Y in 1..9 loop
		Put(ASCII.ESC & "[48;5;15m");
		goto_xy((X_Start + X), (Y_Start + Y));
		Put(' ');
		end loop;
	end loop;

	goto_xy(X_Start + 3, Y_Start + 5);
	Put("Hejsan, vi spelar!");
	end message;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








end;
