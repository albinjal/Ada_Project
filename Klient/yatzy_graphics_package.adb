	-- graphics
	with TJa.Window.Text;      use TJa.Window.Text;
	with TJa.Window.Elementary; use TJa.Window.Elementary;
	with TJa.Window.Graphic; use TJa.Window.Graphic;
	with TJa.Keyboard;        use TJa.Keyboard;
	with Ada.Text_IO;         use Ada.Text_IO;
	with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
	with klient_assets_package; use klient_assets_package;
	package body Yatzy_graphics_package is

	-- Colors
	bg_color : String := "[48;5;22m";
	protocoll_frame_bg : String := "[48;5;232m";
	logo_frame_bg : String := "[48;5;232m";
	message_frame_color1 : String := "[48;5;178m";
	message_frame_color2 : String := "[48;5;220m";




	procedure update_reroll_arrow_graphics(d1, d2, d3, d4, d5: in Integer) is
		x_start: Integer := 28;
		y_start: Integer := 36;
		arrow_color: String := "[38;5;196m";
		black_color: String := "[38;5;0m";
	begin
		-- clear arrows
		Goto_XY(x_start + 15 * 0, y_start); Put(ASCII.ESC & bg_color); Put(" "); Goto_XY(x_start + 15 * 0, y_start - 1); Put(" "); -- 1
		Goto_XY(x_start + 15 * 1, y_start); Put(ASCII.ESC & bg_color); Put(" "); Goto_XY(x_start + 15 * 1, y_start - 1); Put(" "); -- 2
		Goto_XY(x_start + 15 * 2, y_start); Put(ASCII.ESC & bg_color); Put(" "); Goto_XY(x_start + 15 * 2, y_start - 1); Put(" "); -- 3
		Goto_XY(x_start + 15 * 3, y_start); Put(ASCII.ESC & bg_color); Put(" "); Goto_XY(x_start + 15 * 3, y_start - 1); Put(" "); -- 4
		Goto_XY(x_start + 15 * 4, y_start); Put(ASCII.ESC & bg_color); Put(" "); Goto_XY(x_start + 15 * 4, y_start - 1); Put(" "); -- 5

		if d1 = 1 then Goto_XY(x_start + 15 * 0, y_start); Put(ASCII.ESC & arrow_color); Put("V"); Goto_XY(x_start + 15 * 0, y_start - 1); Put("|"); end if; -- 1
		if d2 = 1 then Goto_XY(x_start + 15 * 1, y_start); Put(ASCII.ESC & arrow_color); Put("V"); Goto_XY(x_start + 15 * 1, y_start - 1); Put("|"); end if; -- 2
		if d3 = 1 then Goto_XY(x_start + 15 * 2, y_start); Put(ASCII.ESC & arrow_color); Put("V"); Goto_XY(x_start + 15 * 2, y_start - 1); Put("|"); end if; -- 3
		if d4 = 1 then Goto_XY(x_start + 15 * 3, y_start); Put(ASCII.ESC & arrow_color); Put("V"); Goto_XY(x_start + 15 * 3, y_start - 1); Put("|"); end if; -- 4
		if d5 = 1 then Goto_XY(x_start + 15 * 4, y_start); Put(ASCII.ESC & arrow_color); Put("V"); Goto_XY(x_start + 15 * 4, y_start - 1); Put("|"); end if; -- 5

		-- move cursor out of the way
		Goto_XY(1000, 1000);

		-- reset color to black
		Put(ASCII.ESC & black_color);

	end update_reroll_arrow_graphics;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure place_graphics (avail_points : in Protocoll_Type; select_place : out Integer; Player: in Positive) is

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
				if avail_points(Curr_Index_Selected) >= 0 then
					exit;
				end if;
				if Curr_Index_Selected = 1 then
					Curr_Index_Selected := 16;
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
				if avail_points(Curr_Index_Selected) >= 0 then
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
			if avail_points(x) >= 0 then
				temp_arraysize := temp_arraysize + 1;
			end if;
		end loop;

		declare
			test_array : dynamic_array(0..temp_arraysize);
			begin
			for x in 1..15 loop
				if avail_points(x) >= 0 then
					test_array(temp_array_index) := temp_array_index * 2;
					temp_array_index := temp_array_index + 1;
				end if;
			end loop;
		end;

		-- Display available points in protocoll
		update_protocoll(125, 4, avail_points, avail_points, Player, 1);


		--New_Line; Put("Arraystorlek: "); Put(temp_arraysize,0); -- DEBUG

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
				select_place := Curr_Index_Selected;
				exit;
			end if;

		end loop;

		Set_Buffer_Mode(On);
		Set_Echo_Mode(On);
	end place_graphics;

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
	procedure Start_screen (X_Start, Y_Start : in integer) is

	begin
		Set_Foreground_Colour(white);
		Set_Graphical_Mode(off);

		goto_xy(X_Start, Y_Start);
		Put("YYYYYYY       YYYYYYY                      ttttttt                                                     ");
		goto_xy(X_Start, Y_Start + 1);
		Put("Y:::::Y       Y:::::Y                      t:::::t                                                     ");
		goto_xy(X_Start, Y_Start + 2);
		Put("Y:::::Y       Y:::::Y                      t:::::t                                                     ");
		goto_xy(X_Start, Y_Start + 3);
		Put("Y::::::Y     Y::::::Y                      t:::::t                                                     ");
		goto_xy(X_Start, Y_Start + 4);
		Put(" YY:::::Y   Y:::::YY aaaaaaaaaaaaa   ttttttt:::::ttttttt   zzzzzzzzzzzzzzzzz yyyyyyy           yyyyyyy ");
		goto_xy(X_Start, Y_Start + 5);
		Put("   Y:::::Y Y:::::Y   a::::::::::::a  t:::::::::::::::::t   z:::::::::::::::z  y:::::y         y:::::y  ");
		goto_xy(X_Start, Y_Start + 6);
		Put("    Y:::::Y:::::Y    aaaaaaaaa:::::a t:::::::::::::::::t   z::::::::::::::z    y:::::y       y:::::y  ");
		goto_xy(X_Start, Y_Start + 7);
		Put("     Y:::::::::Y              a::::a tttttt:::::::tttttt   zzzzzzzz::::::z      y:::::y     y:::::y   ");
		goto_xy(X_Start, Y_Start + 8);
		Put("       Y:::::Y       aa::::::::::::a       t:::::t               z::::::z         y:::::y y:::::y     ");
		goto_xy(X_Start, Y_Start + 9);
		Put("       Y:::::Y     a::::a    a:::::a       t:::::t    tttttt    z::::::z            y:::::::::y       ");
		goto_xy(X_Start, Y_Start + 10);
		Put("    YYYY:::::YYYY  a:::::aaaa::::::a       tt::::::::::::::t  z::::::::::::::z        y:::::y         ");
		goto_xy(X_Start, Y_Start + 11);
		Put("    Y:::::::::::Y   a::::::::::aa:::a       tt:::::::::::tt  z:::::::::::::::z       y:::::y          ");
		goto_xy(X_Start, Y_Start + 12);
		Put("    YYYYYYYYYYYYY    aaaaaaaaaa  aaaa        ttttttttttttt  zzzzzzzzzzzzzzzzzz      y:::::y           ");
		goto_xy(X_Start, Y_Start + 13);
		Put("                                                                                   y:::::y            ");
		goto_xy(X_Start, Y_Start + 14);
		Put("                                                                                  y:::::y             ");
		goto_xy(X_Start, Y_Start + 15);
		Put("                                                                                 y:::::y              ");
		goto_xy(X_Start, Y_Start + 16);
		Put("                                                                                y:::::y               ");
		goto_xy(X_Start, Y_Start + 17);
		Put("                                                                               yyyyyyy                ");

		goto_xy(X_Start + 20, Y_Start + 16);
		Set_Foreground_Colour(Red);
		Put("Tryck enter för att starta spelet...");



	end Start_screen;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	procedure vinst (X_Start, Y_Start : in Integer) is

	begin

	Set_Foreground_Colour(white);
	Set_Graphical_Mode(off);
	goto_xy(X_Start, Y_Start);

	Put("DDDDDDDDDDDDD                                                                                                             ");
	goto_xy(X_Start, Y_Start + 1);
	Put("D::::::::::::DDD                                                                                                          ");
	goto_xy(X_Start, Y_Start + 2);
	Put("D:::::::::::::::DD                                                                                                        ");
	goto_xy(X_Start, Y_Start + 3);
	Put("DDD:::::DDDDD:::::D                                                                                                       ");
	goto_xy(X_Start, Y_Start + 4);
	Put("D:::::D    D:::::D  uuuuuu    uuuuuu       vvvvvvv           vvvvvvv  aaaaaaaaaaaaa   nnnn  nnnnnnnn    nnnn  nnnnnnnn    ");
	goto_xy(X_Start, Y_Start + 5);
	Put("D:::::D     D:::::D u::::u    u::::u        v:::::v         v:::::v   a::::::::::::a  n:::nn::::::::nn  n:::nn::::::::nn  ");
	goto_xy(X_Start, Y_Start + 6);
	Put("D:::::D     D:::::D u::::u    u::::u         v:::::v       v:::::v    aaaaaaaaa:::::a n::::::::::::::nn n::::::::::::::nn ");
	goto_xy(X_Start, Y_Start + 7);
	Put("D:::::D     D:::::D u::::u    u::::u          v:::::v     v:::::v              a::::a nn:::::::::::::::nnn:::::::::::::::n");
	goto_xy(X_Start, Y_Start + 8);
	Put("D:::::D     D:::::D u::::u    u::::u           v:::::v   v:::::v        aaaaaaa:::::a   n:::::nnnn:::::n  n:::::nnnn:::::n");
	goto_xy(X_Start, Y_Start + 9);
	Put("D:::::D     D:::::D u::::u    u::::u            v:::::v v:::::v       aa::::::::::::a   n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 10);
	Put("D:::::D     D:::::D u::::u    u::::u             v:::::v:::::v       a::::aaaa::::::a   n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 11);
	Put(" D:::::D    D:::::D u:::::uuuu:::::u              v:::::::::v       a::::a    a:::::a   n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 12);
	Put("DDD:::::DDDDD:::::D  u:::::::::::::::uu            v:::::::v        a::::a    a:::::a   n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 13);
	Put("D:::::::::::::::DD    u:::::::::::::::u             v:::::v         a:::::aaaa::::::a   n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 14);
	Put("D::::::::::::DDD       uu::::::::uu:::u              v:::v           a::::::::::aa:::a  n::::n    n::::n  n::::n    n::::n");
	goto_xy(X_Start, Y_Start + 15);
	Put("DDDDDDDDDDDDD            uuuuuuuu  uuuu               vvv             aaaaaaaaaa  aaaa  nnnnnn    nnnnnn  nnnnnn    nnnnnn");


end vinst;
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	procedure clear_protocoll(X_Start, Y_Start: in Integer; Which_Protocoll_Or_Both: in Integer) is
		x : Integer := X_Start;
		y : Integer := Y_Start;
		widthcol1 : constant Integer := 13;
		widthcol2 : constant Integer := 5;
	begin
		if Which_Protocoll_Or_Both = 0 or Which_Protocoll_Or_Both = 1 then
			For I in 1..19 loop
				Goto_XY(X_Start + 2 + widthcol1, Y_Start - 1 + I * 2);
				case I is
				when 1 => Set_Text_Modes(Off, Off, On);
				when 2..7 => Put("   ");
				when 8 => null;
				when 9 => null;
				when 10..18 => Put("   ");
				when 19 => null;

				when others => null;
				end case;
			end loop;
		end if;

		if Which_Protocoll_Or_Both = 0 or Which_Protocoll_Or_Both = 2 then
			For I in 1..19 loop
				Goto_XY(X_Start + 3 + widthcol1 + widthcol2, Y_Start - 1 + I * 2);
				case I is
				when 1 => Set_Text_Modes(Off, Off, On);
				when 2..7 => Put("   ");
				when 8 => null;
				when 9 => null;
				when 10..18 => Put("   ");
				when 19 => null;

				when others => null;
				end case;
			end loop;
		end if;
	end clear_protocoll;

	procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type; Which_Protocoll_Or_Both: in Integer; Other_Color: in Integer) is
	x : Integer := X_Start;
	y : Integer := Y_Start;
	widthcol1 : constant Integer := 13;
	widthcol2 : constant Integer := 5;
	widthcol3 : constant Integer := 5;
	height: constant Integer := 39;
	text_width: constant Integer := 12;
	points_width: constant Integer := 5;
	avail_place_text_color1: String := "[38;5;208m";
	temp1, temp2 : Protocoll_Type;

	procedure other_color_chk is
	begin
		if Other_Color = 1 then
			Put(ASCII.ESC & avail_place_text_color1);
		end if;
	end other_color_chk;

	procedure reset_black_color is
	begin
		Put(ASCII.ESC & "[38;5;0m");
	end reset_black_color;

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

	if Which_Protocoll_Or_Both = 0 or Which_Protocoll_Or_Both = 1 then
		For I in 1..19 loop
			Goto_XY(X_Start + 2 + widthcol1, Y_Start - 1 + I * 2);

			temp1 := prot1;
			temp2 := prot2;

			case I is
			when 1 => Set_Text_Modes(Off, Off, Off); Put("P1"); Set_Text_Modes(Off, Off, On);
			when 2..7 => other_color_chk; if Prot1(I - 1) /= -1 then Put(Prot1(I - 1), 1 + widthcol2 / 2); end if;
			when 8 => reset_black_color; Put(Calcfirstsum(temp1), 1 + widthcol2 / 2);
			when 9 => reset_black_color; Put(Bonus(temp1), 1 + widthcol2 / 2);
			when 10..18 => other_color_chk; if Prot1(I - 3) /= -1 then Put(Prot1(I - 3), 1 + widthcol2 / 2); end if;
			when 19 => reset_black_color; Put(Calctotsum(temp1), 1 + widthcol2 / 2);

			when others => null;
			end case;
		end loop;
	end if;

	if Which_Protocoll_Or_Both = 0 or Which_Protocoll_Or_Both = 2 then
		For I in 1..19 loop
			Goto_XY(X_Start + 3 + widthcol1 + widthcol2, Y_Start - 1 + I * 2);
			case I is
			when 1 => Set_Text_Modes(Off, Off, Off); Put("P2"); Set_Text_Modes(Off, Off, On);
			when 2..7 => other_color_chk; if Prot2(I - 1) /= -1 then Put(Prot2(I - 1), 1 + widthcol2 / 2); end if;
			when 8 => reset_black_color; Put(Calcfirstsum(temp2), 1 + widthcol2 / 2);
			when 9 => reset_black_color; Put(Bonus(temp2), 1 + widthcol2 / 2);
			when 10..18 => other_color_chk; if Prot2(I - 3) /= -1 then Put(Prot2(I - 3), 1 + widthcol2 / 2); end if;
			when 19 => reset_black_color; Put(Calctotsum(temp2), 1 + widthcol2 / 2);

			when others => null;
			end case;
		end loop;
	end if;

	reset_black_color;

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
procedure dice_placement (D1, D2, D3, D4, D5 : in Integer) is

begin

	-- Only update dice if input is bigger than 0
	if D1 > 0 then Dice(D1, 8 + 15 * 1, 38); end if;
	if D2 > 0 then Dice(D2, 8 + 15 * 2, 38); end if;
	if D3 > 0 then Dice(D3, 8 + 15 * 3, 38); end if;
	if D4 > 0 then Dice(D4, 8 + 15 * 4, 38); end if;
	if D5 > 0 then Dice(D5, 8 + 15 * 5, 38); end if;

end dice_placement;














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

	procedure message4 (X_Start, Y_Start : in Integer; S : in String) is

	begin

	Set_Graphical_Mode(Off);

	-- reset white first
	for X in 1..51 loop
		Put(ASCII.ESC & "[38;5;0m");
			goto_xy((X_Start + X), Y_Start + 22);
		Put(' ');
	end loop;

	goto_xy(X_Start + 3, Y_Start + 25);
	Put(S);

	end message4;


	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure message3 (X_Start, Y_Start : in Integer; S : in String) is

	begin

	Set_Graphical_Mode(Off);

	-- reset white first
	for X in 1..51 loop
		Put(ASCII.ESC & "[38;5;196m");
			goto_xy((X_Start + X), Y_Start + 25);
		Put(' ');
	end loop;

	goto_xy(X_Start + 3, Y_Start + 25);
	Put(S);

	end message3;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------



	procedure message2 (X_Start, Y_Start : in Integer; S : in String) is

	begin

	Set_Graphical_Mode(Off);

	-- White inner frame
	for X in 1..51 loop
		for Y in 1..9 loop
		Put(ASCII.ESC & "[48;5;15m");
		if Y /= 5 then
			goto_xy((X_Start + X), (Y_Start + Y));
		else
			goto_xy((X_Start + X), (Y_Start + Y + 1));
		end if;
		Put(' ');
		end loop;
	end loop;

	goto_xy(X_Start + 3, Y_Start + 8);
	Put(S);
	end message2;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	procedure message (X_Start, Y_Start : in Integer; S : in String) is

	begin

	Set_Graphical_Mode(Off);

	for Y in 1..11 loop
		for X in 1..55 loop

			-- om inte första eller inte sista raden
			if Y = 1 OR Y = 11 then
					if X mod 2 = 0 then
						Put(ASCII.ESC & message_frame_color1);
					else
						Put(ASCII.ESC & message_frame_color2);
					end if;
			else
				if X = 1 OR X = 55 then
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
	for X in 1..51 loop
		for Y in 1..9 loop
		Put(ASCII.ESC & "[48;5;15m");
		goto_xy((X_Start + X), (Y_Start + Y));
		Put(' ');
		end loop;
	end loop;

	goto_xy(X_Start + 3, Y_Start + 5);
  Set_Foreground_Colour(Black);
	Put(S);
	end message;

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------








end;
