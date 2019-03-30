with TJa.Sockets;         use TJa.Sockets;
package Server_Assets_Package is
   
   function Generate return Integer;
   function Roll return String;
   
   procedure Connect_To_Klients(Socket1, Socket2: in out Socket_Type;
				Lyssnare : in out Listener_Type;
			       Port: in Positive);
private
   
end;

