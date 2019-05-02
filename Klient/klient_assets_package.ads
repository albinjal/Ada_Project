with TJa.Sockets;         use TJa.Sockets;
package klient_assets_package is
   type Rolls_Type is private;
   type Protocoll_Type is array (1..15) of Integer;
   type Arr is array (1..5) of Integer;
   DATATYPE_ERROR: exception;
   
   procedure Bootup(Socket: out Socket_Type; Adress: in String; Port: in Positive);
   
   procedure Start_Game(Socket: in Socket_Type; Player: out Positive; Prot1, Prot2: out Protocoll_Type);
   
   function Read(C: in Character) return Natural;
   
   procedure Get_Rolls(Socket: in Socket_Type; Roll: out Rolls_Type);
   
    function GetR(Roll: in Rolls_Type)
		 return Arr;
     function GetI(Roll: in Rolls_Type)
		  return Integer;
     
     procedure Playerroll(Socket: in Socket_Type);
     
     function Calcpoints(Prot: Protocoll_Type; Rolls: Arr)
		      return Protocoll_Type;

    function Rolloop(Socket: Socket_Type; Player: Positive)
          return Rolls_Type;

	procedure Watch_Placement(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: Protocoll_Type);

	procedure Place(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: Protocoll_Type);
   
private
   
   
   type Rolls_Type is
      record
	 I: Natural;
	 Rolls: Arr;
      end record;
   
	 
   
   
   
end Klient_Assets_Package;
