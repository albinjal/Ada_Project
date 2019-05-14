--graphics

package Yatzy_graphics_package is

  --remove after tests
  type Protocoll_Type is
    array(1..15) of Integer;

  procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type);
  procedure dice (A, X_Start, Y_Start: in Integer);
  procedure background;
  procedure logo;
  private



end Yatzy_graphics_package;
