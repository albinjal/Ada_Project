with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;

with TJa.Sockets;         use TJa.Sockets;

procedure Server is

   --| Servern behöver en Listener_type för att ta emot inkommande anslutningar
   Lyssnare  : Listener_Type;
   
   --| Socket_type används för att kunna kommunicera med en klient
   Socket    : Socket_Type;
   
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

   --| Initierar lyssnaren på en port (klienter bara utanför "localhost").\
   Initiate(Lyssnare, Natural'Value(Argument(1)), Localhost => False);
   --| *** eller ***
   --| Initierar lyssnaren på en port (klienter bara på "localhost").
   --Initiate(Lyssnare, Natural'Value(Argument(1)), Localhost => True);
   
   --| Väntar tills en anslutning bildas, krävs att en klient kör connect
   Wait_For_Connection(Lyssnare, Socket);
     
   --| Nu har en anslutning skapats och vi kan då börja en loop eller något
   Put_Line("Klient ansluten...");
   
   loop
      --| Väntar på en sträng från klienten
      Get_Line(Socket, Text, Textlangd);
      
      --| Letar rätt på antalet 'E' i denna text
      Antal_E := 0;
      for I in 1 .. Textlangd loop
	 if Text(I) = 'E' then
	    Antal_E := Antal_E + 1;
	 end if;
      end loop;
      
      --| Skickar resultatet tillbaka
      Put_Line(Socket, Antal_E);
   end loop;
   
exception
   --| Lite felhantering       
   when Constraint_Error =>
      Put_Line("Du matade inte in en parameter innehållande portnummer");
      
   when others => --| kanske end_error eller socket_error, det betyder att
		  --| klienten stängt sin socket. Då skall den stängas även
		  --| här.
      Put_Line("Nu dog klienten");
      Close(Socket);
end Server;
