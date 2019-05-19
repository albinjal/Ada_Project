with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Integer_Text_IO;               use Ada.Integer_Text_IO;

with TJa.Window.Elementary;             use TJa.Window.Elementary;
with TJa.Keyboard;                      use TJa.Keyboard;
with TJa.Misc;                          use TJa.Misc;

procedure Test_Keyboard_Simple is

  Key  : Key_Type;
  X, Y : Integer := 10;

begin
  Clear_Window;
  Put_Line("Förflytta dig med pilarna och avsluta med ESC");
  Put_Line("Sätt ett kryss med SPACE");

  Set_Buffer_Mode(Off);
  Set_Echo_Mode(Off);
  loop
    Goto_XY(1, 20);
    Put("Current position: (");
    Put(X, Width => 2);
    Put(", ");
    Put(Y, Width => 2);
    Put(")");

    Goto_XY(X, Y);
    Get_Immediate(Key);
  
    exit when Is_Esc(Key);

    if Is_Character(Key) and then To_Character(Key) = ' ' then
      Put('X');
    elsif Is_Up_Arrow(Key) then
      Y := Integer'Max(3, Y - 1);
    elsif Is_Down_Arrow(Key) then
      Y := Integer'Min(19, Y + 1);
    elsif Is_Left_Arrow(Key) then
      X := Integer'Max(1, X - 1);
    elsif Is_Right_Arrow(Key) then
      X := Integer'Min(79, X + 1);
    else
      Beep;
    end if;
  end loop;
  Set_Echo_Mode(On);
  Set_Buffer_Mode(On);
end Test_Keyboard_Simple;

