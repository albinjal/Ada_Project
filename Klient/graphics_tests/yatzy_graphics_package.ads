--graphics

package Yatzy_graphics_package is

  --remove after tests
  type Protocoll_Type is
    array(1..15) of Integer;

  procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type);
  procedure dice (A, X_Start, Y_Start: in Integer);
  procedure background;
  procedure protocoll_background (X_Start, Y_Start: in Integer);
  procedure logo(X_Start, Y_Start : in Integer);
  Procedure logo_background (X_Start, Y_Start : in Integer);
  procedure place (avaial_points : in Protocoll_Type; select_place : out Integer);
  procedure message (X_Start, Y_Start : in Integer);
  private



end Yatzy_graphics_package;
