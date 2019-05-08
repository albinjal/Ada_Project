-- graphics
with TJa.Window.Text;      use TJa.Window.Text;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Graphic; use TJa.Window.Graphic;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body Yatzy_graphics_package is


procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type) is
  x : Integer := X_Start;
  y : Integer := Y_Start;
  width : constant Integer := 26;
  height: constant Integer := 39;
  text_width: constant Integer := 12;
  points_width: constant Integer := 5;

begin
  -- Frame

  while y < Y_Start + height loop
    Goto_XY(X_Start, y);
    Put(Horisontal_Line, Times => width);
    y := y + 2;
  end loop;







end update_protocoll;





end;
