with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;         use TJa.Sockets;
with TJa.Window.Text;      use TJa.Window.Text;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Graphic; use TJa.Window.Graphic;
with TJa.Keyboard;			use TJa.Keyboard;
with Yatzy_graphics_package; use Yatzy_graphics_package;
procedure Test is
procedure Test_TJa is

  Own_Protocoll, Other_Protocoll: Protocoll_Type;

begin
  Reset_Colours;  -- Standard colours is supposed to be black on white ...
  Clear_Window;
  Set_Graphical_Mode(On);
  background;
  protocoll_background(130, 4);
  logo_background(15, 4);
  logo(15, 4);
  -- Draw a rectangle on screen ...
  --Set_Graphical_Mode(On);
  for I in 1..15 loop
    Own_Protocoll(I) := I;
  end loop;
  for I in 1..15 loop
    Other_Protocoll(I) := I;
  end loop;



  update_protocoll(130, 4, Own_Protocoll, Other_Protocoll);

  for x in 1..5 loop
    dice(x,10 + 15 * x, 38);
  end loop;

  logo(8, 4);

  Set_Graphical_Mode(Off);

  Reset_Colours;
  Reset_Text_Modes;  -- Resets boold mode ...


end Test_TJa;

begin
    Test_TJa;
    Skip_Line;
end;
