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
  widthcol1 : constant Integer := 13;
  widthcol2 : constant Integer := 5;
  widthcol3 : constant Integer := 5;
  height: constant Integer := 39;
  text_width: constant Integer := 12;
  points_width: constant Integer := 5;

begin
  -- Frame

  -- Skriver ut horisontella linjer
  while y < Y_Start + height loop
    Goto_XY(X_Start + 1, y);
    Put(Horisontal_Line, Times => widthcol1);
    Goto_XY(X_Start + 2 + widthcol1, y);
    Put(Horisontal_Line, Times => widthcol2);
    Goto_XY(X_Start + 3 + widthcol1 + widthcol2, y);
    Put(Horisontal_Line, Times => widthcol3);
    Goto_XY(X_Start + 4 + widthcol1 + widthcol2 + widthcol3, y);
    y := y + 2;
  end loop;

  for I in Y_Start..(Y_Start+height -1) loop
    Goto_XY(X_Start,I);
    if (I + Y_Start) mod 2 /= 0 then
      Put(Vertical_Line);
      Goto_XY(X_Start + 1 + widthcol1,I);
      Put(Vertical_Line);
      Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
      Put(Vertical_Line);
      Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
      Put(Vertical_Line);
    else
      if I =  Y_Start then
        Put(Upper_Left_Corner);
        Goto_XY(X_Start + 1 + widthcol1,I);
        Put(Horisontal_Down);
        Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
        Put(Horisontal_Down);
        Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
        Put(Upper_Right_Corner);
      elsif I = Y_Start+height - 1  then
        Put(Lower_Left_Corner);
        Goto_XY(X_Start + 1 + widthcol1,I);
        Put(Horisontal_Up);
        Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
        Put(Horisontal_Up);
        Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
        Put(Lower_Right_Corner);
      else
        Put(Vertical_Right);
        Goto_XY(X_Start + 1 + widthcol1,I);
        Put(Cross);
        Goto_XY(X_Start + 2 + widthcol1 + widthcol2,I);
        Put(Cross);
        Goto_XY(X_Start + 3 + widthcol1 + widthcol2 + widthcol3,I);
        Put(Vertical_Left);
      end if;
    end if;
  end loop;

Set_Graphical_Mode(Off);

  For I in 1..19 loop
      Goto_XY(X_Start + 2, Y_Start - 1 + I * 2);
      case I is
        when 1 => Set_Text_Modes(On, Off, Off); Put("Spelare:"); Set_Text_Modes(Off, Off, On);
        when 2 => Put("Ettor");
        when 3 => Put("Tvåor");
        when 4 => Put("Treor");
        when 5 => Put("Fyror");
        when 6 => Put("Femmor");
        when 7 => Put("Sexor"); Set_Text_Modes(On, Off, Off);
        when 8 => Put("Summa:");
        when 9 => Put("BONUS"); Set_Text_Modes(Off, Off, On);
        when 10 => Put("Par");
        when 11 => Put("Två par");
        when 12 => Put("Triss");
        when 13 => Put("Fyrtal");
        when 14 => Put("Kåk");
        when 15 => Put("Liten stege");
        when 16 => Put("Stor stege");
        when 17 => Put("Chans");
        when 18 => Put("Yatzy"); Set_Text_Modes(On, Off, Off);
        when 19 => Put("Summa:");

        when others => null;
      end case;
  end loop;


  For I in 1..19 loop
    Goto_XY(X_Start + 2 + widthcol1, Y_Start - 1 + I * 2);
    case I is
      when 1 => Set_Text_Modes(Off, Off, Off); Put("P1"); Set_Text_Modes(Off, Off, On);
    when 2..7 => if Prot1(I - 1) /= -1 then Put(Prot1(I - 1), 1 + widthcol2 / 2); end if;
      when 8 => Put("Sum:");
      when 9 => Put("BON");
    when 10..18 => if Prot1(I - 3) /= -1 then Put(Prot1(I - 3), 1 + widthcol2 / 2); end if;
      when 19 => Put("Sum:");

      when others => null;
    end case;
  end loop;

  For I in 1..19 loop
    Goto_XY(X_Start + 3 + widthcol1 + widthcol2, Y_Start - 1 + I * 2);
    case I is
      when 1 => Set_Text_Modes(Off, Off, Off); Put("P1"); Set_Text_Modes(Off, Off, On);
    when 2..7 => if Prot2(I - 1) /= -1 then Put(Prot2(I - 1), 1 + widthcol2 / 2); end if;
      when 8 => Put("Sum:");
      when 9 => Put("BON");
    when 10..18 => if Prot2(I - 3) /= -1 then Put(Prot2(I - 3), 1 + widthcol2 / 2); end if;
      when 19 => Put("Sum:");

      when others => null;
    end case;
  end loop;



end update_protocoll;

procedure dice (A, X_Start, Y_Start: in Integer) is

begin
  Goto_XY(X_Start, Y_Start);
  for I in 1..5 loop
    if I = 1 then
      Put(Upper_Left_Corner);
      Put(Horisontal_Line, Times => 9);
      Put(Upper_Right_Corner);
      Goto_XY(X_Start, Y_Start + I);
    elsif I = 5 then
      Put(Lower_Left_Corner);
      Put(Horisontal_Line, Times => 9);
      Put(Lower_Right_Corner);
    else
      case A is
        when 1 =>
        Put(Vertical_Line);
        if I = 3 then
        Put("    •    ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 2 or I = 4 then
        Put("         ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        end if;

        when 2 =>
        Put(Vertical_Line);
        if I = 2 then
        Put("  •      ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 3 then
        Put("         ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 4 then
        Put("      •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        end if;

        when 3 =>
        Put(Vertical_Line);
        if I = 2 then
        Put("  •      ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 3 then
        Put("    •    ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 4 then
        Put("      •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        end if;

        when 4 =>
        Put(Vertical_Line);
        if I = 2 then
        Put("  •   •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 3 then
        Put("         ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 4 then
        Put("  •   •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        end if;

        when 5 =>
        Put(Vertical_Line);
        if I = 2 then
        Put("  •   •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 3 then
        Put("    •    ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        elsif I = 4 then
        Put("  •   •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);
        end if;

        when 6 =>
        Put(Vertical_Line);
        Put("  •   •  ");
        Put(Vertical_Line);
        Goto_XY(X_Start, Y_Start + I);

        when others => null;
      end case;
    end if;
  end loop;


end dice;




end;
