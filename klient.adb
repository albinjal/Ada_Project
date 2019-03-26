with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;

procedure Klient is
   
   --Socket_type används för att kunna kommunicera med en server
   Socket : Socket_Type;

   Text      : String(1..100); --Används för att ta emot text från användaren
   Textlangd : Natural;        --Kommer innehålla längden på denna text
   Resultat  : Natural;        --Resultatet från servern


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
   Connect(Socket, Argument(1), Positive'Value(Argument(2)));

    
   loop
      
      --Läser in en sträng från användaren
      Put_Line("Skriv en sträng, skriv exit för att avsluta");
      Get_Line(Text,Textlangd);
      if Textlangd=100 then Skip_Line; end if;
      
      --Avslutar vid exit
      exit when Text(1..4) = "exit";
      
      --Annars skickas strängen till servern
      Put_Line(Socket,Text(1..Textlangd));
      
      --Och resultatet tas emot
      Get(Socket,Resultat);
      
      --och skrivs ut på skärmen
      Put("Stänggen innehöll ");
      Put(Resultat,Width=>0);
      Put_Line(" st E");
      
   end loop;
   
   --Innan programmet avslutar stängs socketen, detta genererar ett exception
   --hos servern, pss kommer denna klient få ett exception när servern avslutas
   Close(Socket);



end Klient;
