with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Server_Assets_Package; use Server_Assets_Package;
procedure Server is
   
   --| Servern behöver en Listener_type för att ta emot inkommande anslutningar
   Lyssnare  : Listener_Type;
   
   --| Socket_type används för att kunna kommunicera med en klient
   Socket1, Socket2    : Socket_Type;
   
   
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
   Connect_To_Klients(Socket1, Socket2, Lyssnare, Natural'Value(Argument(1)));
   
     Put(Socket1, "45"); Put(Socket1, Roll(1..5)); New_Line(Socket1);
     Put_Line(Socket2,"5");
   
   
   
   
   
   
   
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
