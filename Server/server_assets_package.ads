with TJa.Sockets;         use TJa.Sockets;
with Klient_Assets_Package; use Klient_Assets_Package;

package Server_Assets_Package is
   
   function Generate return Integer;
   function Roll return String;
   
   procedure Connect_To_Klients(Socket1, Socket2: in out Socket_Type;
				Lyssnare : in out Listener_Type;
				Port: in Positive);
   procedure Yatzyloop(Socket1, Socket2: in out Socket_Type; Prot1, Prot2: in out Protocoll_Type; First: in Integer);
private
   
end;

