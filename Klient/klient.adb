with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with Klient_Assets_Package; use Klient_Assets_Package;
procedure Klient is
   
   Player : Positive;
   --Socket_type används för att kunna kommunicera med en server
   Socket : Socket_Type;
   Own_Protocoll, Other_Protocoll: Protocoll_Type;
   Dices: Rolls_Type;


begin
   

   --Denna rutin kontrollerar att programmet startas med två parametrar.
   --Annars kastas ett fel.
   --Argumentet skall vara serverns adress och portnummer, t.ex.:
   --> klient localhost 3400

   if Argument_Count /= 2 then
      Raise_Exception(Constraint_Error'Identity,
                      "Usage: " & Command_Name & " remotehost remoteport");
   end if;


   Bootup(Socket, Argument(1), Positive'Value(Argument(2)));
   Start_Game(Socket, Player);

   -- Main loop
   loop
   Dices := Rolloop(Socket, Player);
   Put(GetI(Dices),0);
   if GetI(Dices) = 8 then
      Put("Annan spelare ska placera");
   else
      Put("Du ska placera");
   end if;
   for I in 1..5 loop
      Put(GetR(Dices)(I),0);
   end loop;
   -- Place(Socket, Dices);

   end loop;



   Skip_Line;
   --Innan programmet avslutar stängs socketen, detta genererar ett exception
   --hos servern, pss kommer denna klient få ett exception när servern avslutas
   Close(Socket);



end Klient;
