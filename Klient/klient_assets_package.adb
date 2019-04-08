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
      
      Put("STAT111"); New_Line;
      Get_Line(Socket, TX, TL);
      
      New_Line;
      
      Put("STAT222"); New_Line;
      
      if TX(1) = '4' then
	 -- 4 betyder inkomande tärningar
	 Roll.I := Read(TX(2));
	 -- A betyder här antalet tärningar
	 for X in  1..Roll.I loop
	    Roll.Rolls(X) := Read(TX(X+2));
	 end loop;
	 
	 Put("STAT333"); New_Line;
	
      elsif TX(1) = '5' then
	 -- 5 betyder info om gamestate
	 if TX(2) = '0' then
	    Roll.I := 6;
	 elsif TX(2) = '1' then
	    Roll.I := 7;
	 end if;
	 
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
   
   procedure Playerroll(Socket: in Socket_Type) is
   begin
      Put_Line(Socket, "51");
   end;

   procedure Sort(Arrayen_Med_Talen: in out Arr) is
      procedure Swap(Tal_1,Tal_2: in out Integer) is 
	 Tal_B : Integer; -- Temporary buffer
      begin
	 Tal_B := Tal_1;
	 Tal_1 := Tal_2;
	 Tal_2 := Tal_B;
	 
	 
      end Swap;
      

      Minsta_Talet, Minsta_Talet_Index : Integer;
   begin
      Minsta_Talet := 0;
      
      for IOuter in Arrayen_Med_Talen'Range loop

         for I in IOuter..Arrayen_Med_Talen'Last loop

	    if I = IOuter or Arrayen_Med_Talen(I) > Minsta_Talet then
	       Minsta_Talet := Arrayen_Med_Talen(I);
	       Minsta_Talet_Index := I;
	    end if;
         end loop;
	 
	 Swap(Arrayen_Med_Talen(IOuter), Arrayen_Med_Talen(Minsta_Talet_Index));

      end loop;
   end Sort;
   
   
   function Calcpoints(Prot: Protocoll_Type; Rolls: Arr)
		      return Protocoll_Type is
      
      function Ental(I: Integer; Rolls: Arr)
		    return Integer is
	 
	 C : Integer := 0;
	 
      begin
	 for X in 1..5 loop
	    if Rolls(X) = I then
	       C := C + I;
	    end if;
	 end loop;
	 return C;	    
      end;
      
            function FourPair(Rolls: Arr)
		       return Integer is
	 
      begin
	 for I in 1..2 loop
	       if Rolls(I) = Rolls(I+1) and Rolls(I) = Rolls(I+2) and Rolls(I) = Rolls(I+3) then
	       return 4 * Rolls(I);
	    end if;
	 end loop;
	 return 0;
      end;
      function Pair(Rolls: Arr)
		   return Integer is
      begin
	 for I in 1..4 loop
	    if Rolls(I) = Rolls(I+1) then
	       return 2 * Rolls(I);
	    end if;
	 end loop;
	 return 0;
      end;
      
      function TwoPair(Rolls: Arr)
		      return Integer is
      begin
	 if FourPair(Rolls) /= 0 then
	    return 0;
	 end if;
	 
	 for I in 1..2 loop
	    if Rolls(I) = Rolls(I+1) then
	       for X in (I+2)..4 loop
		  if Rolls(X) = Rolls(X+1) then
		    return 2 * ( Rolls(I) + Rolls(X) );
		  end if;
	       end loop;
	       return 0;
	    end if;
	 end loop;
	 return 0;
      end;
      function Triss(Rolls: Arr)
		    return Integer is
	 
      begin
	 for I in 1..3 loop
	    if Rolls(I) = Rolls(I+1) and Rolls(I) = Rolls(I+2) then
	       return 3 * Rolls(I);
	    end if;
	 end loop;
	 return 0;
	 
      end;
      function Stege(I: Integer; Rolls: Arr)
		    return Integer is
      begin

	 case I is
	    when 11 =>
	       --Liten
	       for X in  1..5 loop
		  
		  if Rolls(6-X) /= X then
		     return 0;
		  end if;
	       end loop;
	       return 15;
	    when 12 =>
	       --Stor
	       for X in 2..6 loop 
		  if Rolls(7-X) /= X then
		     return 0;
		  end if;
	       end loop;
	       return 20;
	    when others =>
	      null;
	       return 0;
	 end case;
	 
      end;
      
      function Chans(Rolls: Arr)
		    return Integer is
	 X : Integer := 0;
      begin
	 for I in 1..5 loop
	    X := X + Rolls(I);
	 end loop;
	 return X;
      end;
      
      function Kaok(Rolls: Arr)
		   return Integer is
      begin
	 for X in 1..2 loop
	    exit when Rolls(X) /= Rolls(X+1);
	    
	    if X = 2 then
	       if Rolls(4) = Rolls(5) and Rolls(5) /= Rolls(1) then
		  return Chans(Rolls);
	       else
		  return 0;
	       end if;
	    end if;
	    
	 end loop;
	 
	 if Rolls(1) = Rolls(2) then
	    if Rolls(3) = Rolls(4) and Rolls(3) = Rolls(5) then
	       return Chans(Rolls);
	    end if;
	 end if;
	
	 return 0;
      end;
      
      function Yatzy(Rolls: Arr)
	   return Integer is
      begin
	 for X in 1..4 loop
	    if Rolls(X) /= Rolls(X+1) then
	      return 0;
	    end if;
	 end loop;
	 return 50;
      end;
      
      
      
      
      
      
      
      TRolls: Arr := Rolls;
      Result: Protocoll_Type;
   begin
      Sort(TRolls);
     
      
      for I in 1..15 loop
	 if Prot(I) /= -1 then
	    Result(I) := -1;
	 else
	    case I is
	       when 1..6 =>
		  Result(I) := Ental(I, TRolls);
	       when 7 =>
		  Result(I) := Pair(TRolls);
	       when 8 =>
		  Result(I) := TwoPair(TRolls);
	       when 9 =>
		  Result(I) := Triss(Trolls);
	       when 10 =>
		  Result(I) := FourPair(Trolls);
	       when 11..12 =>
		  Result(I) := Stege(I, Trolls);
	       when 13 =>
		  Result(I) := Kaok(Trolls);
	       when 14 =>
		  Result(I) := Chans(Trolls);
	       when 15 =>
		  Result(I) := Yatzy(Trolls);
	       when others =>
		  Result(I) := 0;
	    end case;
	    
		    
		  
	 end if;
      end loop;
	 
      return Result;
   end;
     

   
      
      
end Klient_Assets_Package;
