with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with Klient_Assets_Package; use Klient_Assets_Package;
procedure Klient is
   type Rerolls is array(1..5) of Integer;
   Reroll: Rerolls;
   --Socket_type används för att kunna kommunicera med en server
   Socket : Socket_Type;
   Player : Positive;
   Roll: Rolls_Type;
   Result : Arr;
   Placement, B: Integer;
   Pro : Protocoll_Type;
   Continue, Switches: Integer;
   TX : String(1..100);
   TL : Integer;

begin
   for I in 1..5 loop
      Reroll(I) := 0;
   end loop;

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
   Get_Rolls(Socket, Roll);
   if GetI(Roll) > 5 then
      loop
	 if GetI(Roll) = 6 then
	    Put("Spelare "); Put(3-Player,1); Put(" slår");
	    Get_Rolls(Socket, Roll);
	 elsif GetI(Roll) = 7 then
	    Put("Spelare ");  Put(3-Player,1); Put(" har slagit");
	    exit;

	 end if;
      end loop;

   else
      Put("Din tur"); New_Line;
      for I in 1..3 loop
	 Result := GetR(Roll);

	 Put("Tryck enter för att slå...");
	 Skip_Line;
	 Playerroll(Socket);
	 Put("Wow, du fick:"); New_Line;
	 for X in 1..GetI(Roll) loop
	    Put(Result(X),2);
	 end loop;
	 New_Line;
	 Put("Tryck 1 för att slå igen och 0 för att placera");
	   Get(Continue);
	   exit when Continue = 0;
	   Put("Hur många tärningar vill du slå om?");
	   Get(Switches);
	   for A in 1..Switches loop
	      Get(B);
	      Reroll(B) := 1;
	   end loop;

	   Put("STAT1"); New_Line;


	   Put(Socket,'6'); Put(Socket,Switches,0);

	   Put("STAT2"); New_Line;

	   for A in 1..5 loop
	      Put(Socket,Reroll(A),0);
	   end loop;

	   Put("STAT3"); New_Line;

	   New_Line(Socket);
	   Get_Rolls(Socket, Roll);


      end loop;

   end if;





   Skip_Line;
   --Innan programmet avslutar stängs socketen, detta genererar ett exception
   --hos servern, pss kommer denna klient få ett exception när servern avslutas
   Close(Socket);



end Klient;
