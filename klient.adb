with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
procedure Klient is
   function Read(C: in Character)
		return Integer is
      S: String(1..1);
   begin
      S(1) := C;
      return Integer'Value(S);
   end;
   
   --Socket_type används för att kunna kommunicera med en server
   Socket : Socket_Type;
   TX     : String(1..100); --Används för att ta emot text från användaren
   TL : Natural;        --Kommer innehålla längden på denna text
   A: Natural;        --Resultatet från servern
   


begin
   --Denna rutin kontrollerar att programmet startas med två parametrar.
   --Annars kastas ett fel.
   --Argumentet skall vara serverns adress och portnummer, t.ex.:
   --> klient localhost 3400
   if Argument_Count /= 2 then
      Raise_Exception(Constraint_Error'Identity,
                      "Usage: " & Command_Name & " remotehost remoteport");
   end if;

   -- Initierar en socket, detta krävs för att kunna ansluta denna till
   -- servern.
   Initiate(Socket);

   -- Ansluter till servern
   -------------------------------------------------------------
   Connect(Socket, Argument(1), Positive'Value(Argument(2)));
   Get_Line(Socket, TX, TL);
   if TX(1) = '1' then
      Put("Du är spelare 1, väntar på spelare 2");
      Get_Line(Socket, TX, TL);
      New_Line;
      if TX(1) = '3' then
	 Put("Båda spelare anslutna");
      end if;
      
   elsif TX(1) = '2' then
      Put("Du är spelare 2");
   end if;
   New_Line;
   Put("Nu startar spelet");
   --------------------------------------------------------------
   Put("4");
   Get_Line(Socket, TX, TL);
   Put("5");
   if TX(1) = '4' then
      A := Read(TX(2));
      Put(A, 1);
      for X in  1..A loop
	Put("Tärning "); Put(X, 1);
	New_Line;
	Put(TX(X+2));
	New_Line;
	
      end loop;
      
   end if;
   
  
   
   
   
   --Innan programmet avslutar stängs socketen, detta genererar ett exception
   --hos servern, pss kommer denna klient få ett exception när servern avslutas
   Close(Socket);



end Klient;
