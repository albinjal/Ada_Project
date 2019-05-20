with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with Klient_Assets_Package; use Klient_Assets_Package;
with Yatzy_graphics_package; use Yatzy_graphics_package;

procedure Klient is

   Player : Positive;
   --Socket_type används för att kunna kommunicera med en server
   Socket : Socket_Type;
   Own_Protocoll, Other_Protocoll: Protocoll_Type;
   Dices: Rolls_Type;




begin

	-- Denna rutin kontrollerar att programmet startas med två parametrar.
	-- Annars kastas ett fel.
	-- Argumentet skall vara serverns adress och portnummer, t.ex.:
	--> klient localhost 3400

   if Argument_Count /= 2 then
      Raise_Exception(Constraint_Error'Identity,
                      "Usage: " & Command_Name & " remotehost remoteport");
   end if;

   -- Fill_Protocoll_Empty(Own_Protocoll);
   -- Fill_Protocoll_Empty(Other_Protocoll);
   Bootup(Socket, Argument(1), Positive'Value(Argument(2)));
   graphics;
   -- update_protocoll(125,4,Own_Protocoll, Other_Protocoll, 0);
   Start_Game(Socket, Player, Own_Protocoll, Other_Protocoll);


   -- Main loop
   loop
   Dices := Roll_loop(Socket, Player, Own_Protocoll); -- We send own protocoll so we can display available points immediately after rolling

   if GetI(Dices) = 8 then
      Watch_Placement(Socket, Dices, Other_Protocoll, Player);
   else
      Place(Socket, Dices, Own_Protocoll, Player);
   end if;

	end loop;

	--Innan programmet avslutar stängs socketen, detta genererar ett exception
	--hos servern, pss kommer denna klient få ett exception när servern avslutas
	Close(Socket);

end Klient;
