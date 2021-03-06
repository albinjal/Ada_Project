with TJa.Sockets;         use TJa.Sockets;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Yatzy_graphics_package; use Yatzy_graphics_package;
with TJa.Window.Text;      use TJa.Window.Text;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Graphic; use TJa.Window.Graphic;
with TJa.Keyboard;        use TJa.Keyboard;

package body Klient_Assets_Package is

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Fill_Protocoll_Empty(Proto: in out Protocoll_Type) is
begin
	Proto(1) := 12;
	Proto(2) := -1;
	Proto(3) := -1;
	Proto(4) := -1;
	Proto(5) := -1;
	Proto(6) := -1;
	Proto(7) := -1;
	Proto(8) := -1;
	Proto(9) := -1;
	Proto(10) := -1;
	Proto(11) := -1;
	Proto(12) := -1;
	Proto(13) := -1;
	Proto(14) := -1;
	Proto(15) := -1;
end Fill_Protocoll_Empty;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Bootup(Socket: out Socket_Type; Adress: in String; Port: in Positive) is
begin
	Initiate(Socket);
	Connect(Socket, Adress, Port);
	Put("Ansluten till servern");
	New_Line;
end Bootup;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure graphics is
begin
	Clear_Window;
	Set_Graphical_Mode(On);
	background;
	protocoll_background(125, 4);
	logo_background(24, 4);
	logo(24, 4);
end graphics;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Start_Game(Socket: in Socket_Type; Player: out Positive; Prot1, Prot2: out Protocoll_Type) is
	TX     : String(1..100);
	TL : Natural;
begin  --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --
	for I in 1..15 loop
		Prot1(I) := -1;
	end loop;
	
	Prot2 := Prot1;
	Get_Line(Socket, TX, TL);

	if TX(1) = '1' then
		message(33, 18, "Du är spelare 1, väntar på spelare 2");
		Player := 1;
		Get_Line(Socket, TX, TL);
		New_Line;
	if TX(1) = '3' then
		message(33, 18, "Båda spelare anslutna");
	end if;

	elsif TX(1) = '2' then
		message(33, 18, "Du är spelare 2");
		Player := 2;
	else
		raise DATATYPE_ERROR;
	end if;
	
	New_Line;

	message(33, 18, "Nu startar spelet");
	New_Line;

end Start_Game;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

function Read(C: in Character)
	return Natural is
	
	S: String(1..1);
begin
	S(1) := C;
	return Integer'Value(S);
end Read;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Get_Rolls(Socket: in Socket_Type; Roll: out Rolls_Type) is
	TX: String(1..100);
	TL: Natural;
begin

	Get_Line(Socket, TX, TL);
	New_Line;

	if TX(1) = '4' then -- 4 betyder inkomande tärningar
		
		Roll.I := Read(TX(2));
	
		for X in  1..Roll.I loop -- A betyder här antalet tärningar
			Roll.Rolls(X) := Read(TX(X+2));
		end loop;

	elsif TX(1) = '5' then -- 5 betyder info om gamestate
		if TX(2) = '0' then -- Annan spelare slår
			Roll.I := 6;
		elsif TX(2) = '1' then -- Annan spelare har slagit
			Roll.I := 7;
			
			for X in 1..5 loop
				Roll.Rolls(X) := Read(TX(X+2));
			end loop;
		elsif TX(2) = '2' then -- Annan spelare vill placera
			Roll.I := 8;
			
			for X in 1..5 loop
				Roll.Rolls(X) := Read(TX(X+2));
			end loop;
		end if;
	else
		raise DATATYPE_ERROR;
	end if;
end Get_Rolls;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

function GetI(Roll: in Rolls_Type)
	return Integer is
begin
	return Roll.I;
end GetI;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

function GetR(Roll: in Rolls_Type)
	return Arr is
begin
	return Roll.Rolls;
end GetR;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Playerroll(Socket: in Socket_Type) is
begin
	Put_Line(Socket, "51");
end Playerroll;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Sort(Arrayen_Med_Talen: in out Arr) is
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	procedure Swap(Tal_1,Tal_2: in out Integer) is
		Tal_B : Integer; -- Temporary buffer
	begin
		Tal_B := Tal_1;
		Tal_1 := Tal_2;
		Tal_2 := Tal_B;
	end Swap;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	Minsta_Talet, Minsta_Talet_Index : Integer;
begin
	Minsta_Talet := 0;

	for IOuter in Arrayen_Med_Talen'Range loop
		for I in IOuter..Arrayen_Med_Talen'Last loop
			if I = IOuter or Arrayen_Med_Talen(I) > Minsta_Talet then
				Minsta_Talet := Arrayen_Med_Talen(I);
				Minsta_Talet_Index := I;
			end if;
		end loop;
		
		Swap(Arrayen_Med_Talen(IOuter), Arrayen_Med_Talen(Minsta_Talet_Index));
	end loop;
end Sort;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
																																						 -- -- --
function Calcpoints(Prot: Protocoll_Type; Rolls: Arr)																									 -- -- --
	return Protocoll_Type is																															 -- -- --
																																						 -- -- --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 																			 -- -- --
	function Ental(I: Integer; Rolls: Arr)																												 -- -- --
		return Integer is																																 -- -- --
																																						 -- -- --
		C : Integer := 0;																																 -- -- --
	begin																																				 -- -- --
		for X in 1..5 loop																																 -- -- --
			if Rolls(X) = I then																														 -- -- --
				C := C + I;																																 -- -- --
			end if;																																		 -- -- --
		end loop;																																		 -- -- --
		return C;																																		 -- -- --
	end Ental;																																			 -- -- --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 																			 -- -- --
	function FourPair(Rolls: Arr)																														 -- -- --
		return Integer is																																 -- -- --
																																						 -- -- --
	begin																																				 -- -- --
		for I in 1..2 loop																																 -- -- --
			if Rolls(I) = Rolls(I+1) and Rolls(I) = Rolls(I+2) and Rolls(I) = Rolls(I+3) then															 -- -- --
				return 4 * Rolls(I);																													 -- -- --
			end if;																																		 -- -- --
		end loop;																																		 -- -- --
																																						 -- -- --
		return 0;																																		 -- -- --
	end FourPair;																																		 -- -- --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 																			 -- -- --
	function Pair(Rolls: Arr)																															 -- -- --
		return Integer is																																 -- -- --
	begin																																				 -- -- --
	for I in 1..4 loop
		if Rolls(I) = Rolls(I+1) then
		return 2 * Rolls(I);
		end if;
	end loop;
	return 0;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function TwoPair(Rolls: Arr)
			return Integer is
	begin
	if FourPair(Rolls) /= 0 then
		return 0;
	end if;

	for I in 1..2 loop
		if Rolls(I) = Rolls(I+1) then
		for X in (I+2)..4 loop
		if Rolls(X) = Rolls(X+1) then
			return 2 * ( Rolls(I) + Rolls(X) );
		end if;
		end loop;
		return 0;
		end if;
	end loop;
	return 0;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function Triss(Rolls: Arr)
			return Integer is

	begin
	for I in 1..3 loop
		if Rolls(I) = Rolls(I+1) and Rolls(I) = Rolls(I+2) then
		return 3 * Rolls(I);
		end if;
	end loop;
	return 0;

	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function Stege(I: Integer; Rolls: Arr)
			return Integer is
	begin
		case I is
			when 11 =>
			--Liten
			for X in  1..5 loop

			if Rolls(6-X) /= X then
				return 0;
			end if;
			end loop;
			return 15;
			when 12 =>
			--Stor
			for X in 2..6 loop
			if Rolls(7-X) /= X then
				return 0;
			end if;
			end loop;
			return 20;
			when others =>
			null;
			return 0;
		end case;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function Chans(Rolls: Arr)
			return Integer is
	X : Integer := 0;
	begin
	for I in 1..5 loop
		X := X + Rolls(I);
	end loop;
	return X;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function Kaok(Rolls: Arr)
		return Integer is
	begin
	for X in 1..2 loop
		exit when Rolls(X) /= Rolls(X+1);

		if X = 2 then
		if Rolls(4) = Rolls(5) and Rolls(5) /= Rolls(1) then
		return Chans(Rolls);
		else
		return 0;
		end if;
		end if;

	end loop;

	if Rolls(1) = Rolls(2) then
		if Rolls(3) = Rolls(4) and Rolls(3) = Rolls(5) then
		return Chans(Rolls);
		end if;
	end if;

	return 0;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	function Yatzy(Rolls: Arr)
		return Integer is	
	begin
		for X in 1..4 loop
			if Rolls(X) /= Rolls(X+1) then
			return 0;
			end if;
		end loop;
		return 50;
	end;
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	TRolls: Arr := Rolls;
	Result: Protocoll_Type;
begin
	Sort(TRolls);

	for I in 1..15 loop
		if Prot(I) /= -1 then
			Result(I) := -1;
		else
			case I is
			when 1..6 =>
			Result(I) := Ental(I, TRolls);
			when 7 =>
			Result(I) := Pair(TRolls);
			when 8 =>
			Result(I) := TwoPair(TRolls);
			when 9 =>
			Result(I) := Triss(Trolls);
			when 10 =>
			Result(I) := FourPair(Trolls);
			when 11..12 =>
			Result(I) := Stege(I, Trolls);
			when 13 =>
			Result(I) := Kaok(Trolls);
			when 14 =>
			Result(I) := Chans(Trolls);
			when 15 =>
			Result(I) := Yatzy(Trolls);
			when others =>
			Result(I) := 0;
			end case;
		end if;
	end loop;

	return Result;
end;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

function Roll_loop(Socket: Socket_Type; Player: Positive)
	return Rolls_Type is

	type Rerolls is array(1..5) of Integer;
	
	B: Integer;
	Continue, Switches: Integer;
	Reroll: Rerolls;
	Result : Arr;
	Roll: Rolls_Type;
	Key  : Key_Type;
	temp_resp_int: Integer;
	--C0 : Character := 0;
	--C1 : Character := 1;

begin --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --      --

	Get_Rolls(Socket, Roll);
	-- Slår Jag?
	if GetI(Roll) > 5 then -- Jag slår inte - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		
		loop
			if GetI(Roll) = 6 then
				message(33, 18, "Spelare " & Integer'Image(3-Player) & " slår");
			elsif GetI(Roll) = 7 then
				message(33, 18, "Spelare " & Integer'Image(3-Player) & " har slagit:");
				Result := GetR(Roll);
				dice_placement(Roll.Rolls(1), Roll.Rolls(2), Roll.Rolls(3), Roll.Rolls(4), Roll.Rolls(5));
			end if;
			
			Get_Rolls(Socket, Roll);
			exit when Roll.I = 8;
		end loop;

	else -- Jag slår - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		for I in 1..5 loop
			Reroll(I) := 0;
		end loop;

		message(33, 18, "Din tur");

		for I in 1..3 loop -- Man kan slå max 3 gånger totalt per omgång
		
		Result := GetR(Roll);
		message(33, 18, "Tryck enter för att slå...");

		--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --
		Set_Buffer_Mode(Off);
		Set_Echo_Mode(Off);		
		loop  -- Infinite loop waiting for return key
			Get_Immediate(Key);					
			if Is_Return(Key) then
				exit;
			end if;
		end loop;
		Set_Echo_Mode(On);
		Set_Buffer_Mode(On);
		--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --

		message(33, 18, "Wow, du fick:");
		dice_placement(Roll.Rolls(1), Roll.Rolls(2), Roll.Rolls(3), Roll.Rolls(4), Roll.Rolls(5));
		
		-- If third time, exit loop and do not allow user to roll again
		exit when I = 3;

		message(33, 18, "Tryck 1 för att slå igen och 0 för att placera: ");
		
		--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --
		Set_Buffer_Mode(Off);
		Set_Echo_Mode(Off);
		loop  -- Infinite loop waiting for either 1 or 0
			Get_Immediate(Key);

			if To_String(Key) = "0" then
				temp_resp_int := 0;
				exit;
			elsif To_String(Key) = "1" then
				temp_resp_int := 1;
				exit;
			end if;
		end loop;
		Set_Echo_Mode(On);
		Set_Buffer_Mode(On);
		--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --

		if temp_resp_int = 0 then
			exit; -- exit loop, move to placement
		elsif temp_resp_int = 1 then
			message(33, 18, "Välj hur många tätningar du vill slå om: ");
			Get(Switches);

			for A in 1..Switches loop
				message(33, 18, "Välj en tärning att slå om: ");
				Get(B);
				Reroll(B) := 1;
			end loop;

			Put(Socket,'6'); Put(Socket,Switches,0);

			for A in 1..5 loop
				Put(Socket,Reroll(A),0);
			end loop;

			New_Line(Socket);
			Get_Rolls(Socket, Roll);
		end if;
	end loop;
	Put_Line(Socket, "7");

	end if;
	
	return Roll;
end Roll_loop;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Watch_Placement(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: Protocoll_Type) is

begin
	message(33, 18, "Annan spelare ska placera");
	Skip_Line;
end Watch_Placement;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

procedure Place(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: Protocoll_Type) is
	selected_index: Integer;
begin
	message(33, 18, "Du ska placera");
	New_Line; New_Line; Put("-FFS " & Integer'Image(GetR(Dices)(1)) & "+" & Integer'Image(GetR(Dices)(2)) & "+" & Integer'Image(GetR(Dices)(3)) & "+" & Integer'Image(GetR(Dices)(4)) & "+" & Integer'Image(GetR(Dices)(5)) & " FFS-");
	place_graphics( Calcpoints(Protocoll, GetR(Dices)), selected_index );
end Place;




-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
end Klient_Assets_Package;