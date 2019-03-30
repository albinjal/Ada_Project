with TJa.Sockets;         use TJa.Sockets;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body Klient_Assets_Package is
   
   procedure Bootup(Socket: out Socket_Type; Adress: in String; Port: in Positive) is
   begin
      Initiate(Socket);
      Connect(Socket, Adress, Port);
      Put("Ansluten till servern");
      New_Line;
   end;
   
   procedure Start_Game(Socket: in Socket_Type; Player: out Positive) is
   TX     : String(1..100);
   TL : Natural;
   begin
      Get_Line(Socket, TX, TL);
      
      if TX(1) = '1' then
	 Put("Du är spelare 1, väntar på spelare 2");
	 Player := 1;
	 Get_Line(Socket, TX, TL);
	 New_Line;
	 if TX(1) = '3' then
	    Put("Båda spelare anslutna");
	 end if;
	 
      elsif TX(1) = '2' then
	 Put("Du är spelare 2");
	 Player := 2;
      else
	 raise DATATYPE_ERROR;
      end if;
      New_Line;
      Put("Nu startar spelet");
      New_Line;

   end;
   
   function Read(C: in Character)
		return Natural is
      S: String(1..1);
   begin
      S(1) := C;
      return Integer'Value(S);
   end;
   
   
   procedure Get_Rolls(Socket: in Socket_Type; Roll: out Rolls_Type) is
      TX: String(1..100);
      TL: Natural;
   begin
      Get_Line(Socket, TX, TL);
      New_Line;
      if TX(1) = '4' then
	 -- 4 betyder inkomande tärningar
	 Roll.I := Read(TX(2));
	 -- A betyder här antalet tärningar
	 for X in  1..Roll.I loop
	    Roll.Rolls(X) := Read(TX(X+2));
	 end loop;
   
	
      elsif TX(1) = '5' then
	 -- 5 betyder info om gamestate
	 Roll.I := 6;
   else
      raise DATATYPE_ERROR;
      
      
      end if;
   end;
   
   function GetI(Roll: in Rolls_Type)
		return Integer is
   begin
      
      return Roll.I;
   end;
   function GetR(Roll: in Rolls_Type)
		return Arr is
   begin
      return Roll.Rolls;
   end;
   

   
      
      
end Klient_Assets_Package;
