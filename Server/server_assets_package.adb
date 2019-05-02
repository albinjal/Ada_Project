with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with TJa.Sockets;         use TJa.Sockets;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

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
   Put_Line("Klienter anslutna...");

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

   procedure Yatzyloop(Socket1, Socket2: in out Socket_Type) is
      type Rerolls is array(1..5) of Integer;
      Reroll: Rerolls;
      TX: String(1..100);
      TL, I: Integer;
      CurrentRolls: String(1..5);

   begin
     CurrentRolls := Roll(1..5);
     
     

     for X in 1..3 loop

     -- Skicka slag till spelare 1, skicka state till 2
      Put(Socket1, "45"); Put(Socket1, CurrentRolls); New_Line(Socket1);
      Put_Line(Socket2,"50");
      
      -- State update från 1 till 2
      Get_Line(Socket1, TX, TL);
      if TX(1) = '5' then
        if TX(2) = '1' then
        	Put(Socket2, "51");
			Put_Line(Socket2, CurrentRolls);
        end if;
      end if;


      Get_Line(Socket1, TX, Tl);
	  Put(TX(1));
    if TX(1) = '6' then
             -- Slå om !!
    	I := Read(TX(2));
          for X in 3..7 loop
             Reroll(X-2) := Read(TX(X));
          end loop;
        for X in 1..5 loop
             if Reroll(X) = 1 then
                CurrentRolls(X) := Roll(1);
             end if;
        end loop;
    else
		Put(Socket2, "52");
		Put_Line(Socket2, CurrentRolls);
    -- Färdig
    exit;
     end if;

     end loop;
     


             


   end;

end;
