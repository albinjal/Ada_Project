with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with TJa.Sockets;         use TJa.Sockets;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Server is
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

   
   --| Servern behöver en Listener_type för att ta emot inkommande anslutningar
   Lyssnare  : Listener_Type;
   
   --| Socket_type används för att kunna kommunicera med en klient
   Socket1, Socket2    : Socket_Type;
   
   Text      : String(1 .. 100); --| Används för att ta emot text
   Textlangd : Natural;          --| Kommer innehålla längden på denna text
   Antal_E   : Natural;          --| Ska beräknas till antalet 'E' i Text
   
begin
   --| Denna rutin kontrollerar att programmet startas med en parameter.
   --| Annars kastas ett fel.
   --| Argumentet skall vara portnummret, programmet kan t.ex. startas med:
   --| > server 3400
   if Argument_Count /= 1 then
      Raise_Exception(Constraint_Error'Identity,
                      "Usage: " & Command_Name & " port");
   end if;
   Put(Roll);
   --| Initierar lyssnaren på en port (klienter bara utanför "localhost").\
   Initiate(Lyssnare, Natural'Value(Argument(1)), Localhost => False);
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
   
   Put(Socket1, "45"); Put(Socket1, Roll(1..5)); New_Line(Socket1);
   
   
   
   
   
   
   
exception
   --| Lite felhantering       
   when Constraint_Error =>
      Put_Line("Du matade inte in en parameter innehållande portnummer");
      
   when others => --| kanske end_error eller socket_error, det betyder att
		  --| klienten stängt sin socket. Då skall den stängas även
		  --| här.
      Put_Line("Nu dog klienten");
      Close(Socket1);
      Close(Socket2);
end Server;
