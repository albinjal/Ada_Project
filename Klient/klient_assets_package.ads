with TJa.Sockets;         use TJa.Sockets;

package klient_assets_package is
	type Arr is array (1..5) of Integer;
	type Protocoll_Type is array (1..15) of Integer;
	type Rolls_Type is private;

	DATATYPE_ERROR: exception;
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
	procedure Bootup(Socket: out Socket_Type; Adress: in String; Port: in Positive);

	-- procedure Fill_Protocoll_Empty(Proto: in out Protocoll_Type); REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE REMOVE

	procedure Get_Rolls(Socket: in Socket_Type; Roll: out Rolls_Type);

	procedure graphics;

	procedure Place(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: in out Protocoll_Type; Player: in Positive);

	procedure Playerroll(Socket: in Socket_Type);

	procedure Start_Game(Socket: in Socket_Type; Player: out Positive; Prot1, Prot2: out Protocoll_Type);

	procedure Watch_Placement(Socket: Socket_Type; Dices: Rolls_Type; Protocoll: in out Protocoll_Type; Player: in Positive);

  --procedure protocoll (Prot1, Prot2 : in Protocoll_Type);
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
	function Calcfirstsum(Prot: in Protocoll_Type) return Integer;

	function Calctotsum(Prot: in Protocoll_Type) return Integer;

	function Bonus(Prot: in Protocoll_Type) return Integer;

	function Read(C: in Character) return Natural;

	function GetR(Roll: in Rolls_Type)
		return Arr;

	function GetI(Roll: in Rolls_Type)
		return Integer;

	function Calcpoints(Prot: Protocoll_Type; Rolls: Arr)
		return Protocoll_Type;

	function Roll_loop(Socket: Socket_Type; Player: Positive; Own_Protocoll: in Protocoll_Type)
		return Rolls_Type;
	------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------
	private
  type Rolls_Type is
		record
			I: Natural;
			Rolls: Arr;
		end record;
end Klient_Assets_Package;
