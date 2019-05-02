with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with TJa.Window.Text;      use TJa.Window.Text;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Graphic; use TJa.Window.Graphic;
with TJa.Keyboard;			use TJa.Keyboard;

procedure Test is
procedure Test_TJa is

  X_Start : constant Integer := 1;
  Y_Start : constant Integer := 1;

begin
  Reset_Colours;  -- Standard colours is supposed to be black on white ...
  Clear_Window;

  -- Draw a rectangle on screen ...
  Set_Graphical_Mode(On);

  Goto_XY(X_Start, Y_Start);
  Put(Upper_Left_Corner);
  Put(Horisontal_Line, Times => 7);
  Put(Upper_Right_Corner);
for I in 1..17 loop
  Goto_XY(X_Start, Y_Start + I);
  Put(Vertical_Line);


  Goto_XY(X_Start + 7 + 1, Y_Start + I);
  Put(Vertical_Line);
end loop;
  Goto_XY(X_Start, Y_Start + 18);
  Put(Lower_Left_Corner);
  Put(Horisontal_Line, 7);
  Put(Lower_Right_Corner);

  Set_Graphical_Mode(Off);

  Reset_Colours;
  Reset_Text_Modes;  -- Resets boold mode ...
   Goto_XY(2,2);
Put(10,0);
  Goto_XY(1, Y_Start + 4);
 

end Test_TJa;

begin
    Test_TJa;
    Skip_Line;
end;
