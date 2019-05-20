with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with TJa.Sockets;         use TJa.Sockets;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Klient_Assets_Package; use Klient_Assets_Package;

package body Server_Assets_Package is
function Generate
	return Integer is

	subtype Nums is Integer range 1..6;
	package RN is
	new Ada.Numerics.Discrete_Random(Nums);
	Gen : RN.Generator;
begin
	RN.Reset(Gen);
	return RN.Random(Gen);
end;


function Roll
	return String is
	S: String(1..5);
begin

	for X in 1..5 loop

	S(X) := Integer'Image(Generate)(2);
	end loop;
	return S;
end;


procedure Connect_To_Klients(Socket1, Socket2: in out Socket_Type;
				Lyssnare : in out Listener_Type;
				Port: in Positive) is
begin

	Initiate(Lyssnare, Port, Localhost => False);
	--| *** eller ***
	--| Initierar lyssnaren på en port (klienter bara på "localhost").
	--Initiate(Lyssnare, Natural'Value(Argument(1)), Localhost => True);
	Put("Väntar på klienter");
	--| Väntar tills en anslutning bildas, krävs att en klient kör connect
	Wait_For_Connection(Lyssnare, Socket1);
	Put_Line(Socket1, "1");
	New_Line;
	Put("Klient 1 ansluten");
	New_Line;
	Wait_For_Connection(Lyssnare, Socket2);
	Put_Line(Socket2, "2");
	Put_Line(Socket1, "3");
	--| Nu har en anslutning skapats och vi kan då börja en loop eller något
	Put_Line("Klient 2 ansluten");
	end;

	function Read(C: in Character)
			return Natural is
		S: String(1..1);
		i: Natural;
	begin
		S(1) := C;
		i := Integer'Value(S);
		return i;
	end;

	procedure Yatzyloop(Socket1, Socket2: in out Socket_Type; Prot1, Prot2: in out Protocoll_Type; First: in Integer) is
		type Rerolls is array(1..5) of Integer;
		Reroll: Rerolls;
		TX: String(1..100);
		TL, I: Integer;
		Current_Rolls: String(1..5);
		temp_prot_calc: Protocoll_Type;
		temp_prot1, temp_prot2: Protocoll_Type;

		type rolls_arr_type_t is array (1..5) of Integer;
		temp_calc_rolls_arr: Arr;

		first_temp: Integer := 0;

	begin

	first_temp := First;

	temp_prot1 := Prot1;
	temp_prot2 := Prot2;

	-- DEBUG - REMOVE - REMOVE
	-- DEBUG - REMOVE - REMOVE
	for x in 1..15 loop
		Put("Socket 1 has proto var "); Put(x, 0); Put(": "); Put( temp_prot1(x) ); New_Line;
	end loop;
	New_Line;
	for x in 1..15 loop
		Put("Socket 2 has proto var "); Put(x, 0); Put(": "); Put( temp_prot2(x) ); New_Line;
	end loop;

	
	-- DEBUG - REMOVE - REMOVE
	-- DEBUG - REMOVE - REMOVE

	--------------------------------- Slutställ tärningar
		Current_Rolls := Roll(1..5);
		Put("Current_rolls = " & Current_Rolls); New_Line;  -- DEBUG
		
		for X in 1..3 loop

			-- Skicka slag till spelare 1, skicka state till 2
			Put(Socket1, "45"); Put(Socket1, Current_Rolls); New_Line(Socket1);
			Put("Sent data to SOCKET 1: 45" & Current_Rolls); New_Line; -- DEBUG

			Put_Line(Socket2,"50");
			Put("Sent data to SOCKET 2: 50"); New_Line; -- DEBUG

			-- State update från 1 till 2
			Put("[0]Listening to input from SOCKET 1.."); New_Line; -- DEBUG
			Get_Line(Socket1, TX, TL);

			Put("INPUT FROM SOCKET 1: "); Put(TX(1..TL)); New_Line; -- DEBUG
			if TX(1) = '5' then
				if TX(2) = '1' then
					
				Put(Socket2, "51");
					Put_Line(Socket2, Current_Rolls);
				Put("Sent data to SOCKET 2: 51" & Current_Rolls); New_Line; -- DEBUG

				end if;
			end if;

			Put("[1]Listening to input from SOCKET 1.."); New_Line; -- DEBUG
			Get_Line(Socket1, TX, TL);
			Put("INPUT FROM SOCKET 1: "); Put(TX(1..TL)); New_Line; -- DEBUG

			if TX(1) = '6' then
					-- Slå om !!
				I := Read(TX(2));
				for X in 3..7 loop
					Reroll(X-2) := Read(TX(X));
				end loop;
				for X in 1..5 loop
					if Reroll(X) = 1 then
						Current_Rolls(X) := Roll(1);
					end if;
				end loop;
			elsif TX(1) = '7' then -- placement mode socket 1

				Put(Socket2, "52"); -- Tell socket 2 that socket 1 is in placement mode
				Put_Line(Socket2, Current_Rolls); -- Tell socket 2 what dices socket 1 got
				Put("Sent data to SOCKET 2: 52" & Current_Rolls); New_Line; -- DEBUG

				Put("[2]Listening to input from SOCKET 1.."); New_Line; -- DEBUG -- Get placement index
				Get_Line(Socket1, TX, TL);
				Put("INPUT FROM SOCKET 1: "); Put(TX(1..TL)); New_Line; -- DEBUG

				-- CHECK IF PLACEMENT IS POSSIBLE
				Put("Is index "); Put(TX(1..TL)); Put(" possible?"); New_Line;
				
				for x in 1..15 loop
					temp_prot_calc(x) := 0;
				end loop;
				
				for x in 1..5 loop
					temp_calc_rolls_arr(x) := Integer'Value( Current_Rolls(x..x) );
				end loop;
				
				-- FLYTTAD temp_prot_calc := Calcpoints(Prot1, temp_calc_rolls_arr);

				--if temp_prot_calc( Integer'Value(TX(1..TL)) ) >= 0 then
					Put("Placement possible! Gives "); Put( temp_prot_calc( Integer'Value(TX(1..TL)) ) , 0); Put(" points."); New_Line; -- DEBUG

					-- Prot1( Integer'Value ( TX(1..TL) ) ) := temp_prot_calc(Integer'Value(TX(1..TL)));

					-- temp_prot1( Integer'Value ( TX(1..TL) ) ) := temp_prot_calc(Integer'Value(TX(1..TL)));

					--temp_prot2( Integer'Value ( TX(1..TL) ) ) := temp_prot_calc(Integer'Value(TX(1..TL)));

					if(first_temp = 1) then
						first_temp := 0;

						temp_prot_calc := Calcpoints(Prot1, temp_calc_rolls_arr);

						Put("FIRST ======================= TRUE"); New_Line; -- DEBUG
						temp_prot1( Integer'Value ( TX(1..TL) ) ) := temp_prot_calc(Integer'Value(TX(1..TL)));

						-- SEND RESPONSE
						Put_Line(Socket1, temp_prot_calc(Integer'Value(TX(1..TL))));
						
						-- SEND RESPONSE TO OTHER PLAYER

						Put(Socket2, Integer'Value(TX(1..TL)), 2);

						Put(Socket2, temp_prot_calc(Integer'Value(TX(1..TL))));

						New_Line(Socket2);
						

					elsif(first_temp = 0)then
						first_temp := 1;

						temp_prot_calc := Calcpoints(Prot2, temp_calc_rolls_arr);

						Put("FIRST ======================= FALSE"); New_Line; -- DEBUG
						temp_prot2( Integer'Value ( TX(1..TL) ) ) := temp_prot_calc(Integer'Value(TX(1..TL)));

						-- SEND RESPONSE TO PLAYER
						Put_Line(Socket1, temp_prot_calc(Integer'Value(TX(1..TL))));
						
						-- SEND RESPONSE TO OTHER PLAYER
						Put(Socket2, Integer'Value(TX(1..TL)), 2);

						Put(Socket2, temp_prot_calc(Integer'Value(TX(1..TL))));

						New_Line(Socket2);


					end if;
				--else
				--	-- Not possible!
				--	Put("Placement not possible! Handle this plz, code not written yet"); New_Line;
				--	null; -- Add code to handle this here
				--end if;

				exit;

			-- Färdig
			else
				Put("COMPLETE, EXITING");
				null;
			end if;
		end loop;
		--------------------------------- Slutställ tärningar

	-- swap players and protocolls
	Yatzyloop(Socket2, Socket1, temp_prot1, temp_prot2, first_temp);
		
	end;

end;
