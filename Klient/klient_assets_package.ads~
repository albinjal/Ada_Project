with TJa.Sockets;         use TJa.Sockets;
package klient_assets_package is
   type Rolls_Type is private;
   type Arr is private;
   DATATYPE_ERROR: exception;
   
   procedure Bootup(Socket: out Socket_Type; Adress: in String; Port: in Positive);
   
   procedure Start_Game(Socket: in Socket_Type; Player: out Positive);
   
   function Read(C: in Character) return Natural;
   
   procedure Get_Rolls(Socket: in Socket_Type; Roll: out Rolls_Type);
   
   
   
private
   type Arr is array(1..5) of Integer;
   
   type Rolls_Type is
      record
	 I: Natural;
	 Rolls: Arr;
      end record;
   
	 
   
   
   
end Klient_Assets_Package;
