with Klient_assets_package; use Klient_assets_package;
--graphics

package Yatzy_graphics_package is

  --remove after tests
  --type Protocoll_Type is
  --  array(1..15) of Integer;

  procedure update_protocoll(X_Start, Y_Start: in Integer; prot1, prot2: in Protocoll_Type; Which_Protocoll_Or_Both: in Integer; Other_Color: in Integer);
  procedure update_reroll_arrow_graphics(d1, d2, d3, d4, d5: in Integer);
  procedure dice (A, X_Start, Y_Start: in Integer);
  procedure background;
  procedure clear_protocoll(X_Start, Y_Start: in Integer; Which_Protocoll_Or_Both: in Integer);
  procedure protocoll_background (X_Start, Y_Start: in Integer);
  procedure Start_screen (X_Start, Y_Start : in integer);
  procedure logo(X_Start, Y_Start : in Integer);
  procedure vinst (X_Start, Y_Start : in Integer);
  Procedure logo_background (X_Start, Y_Start : in Integer);
  procedure place_graphics (avail_points : in Protocoll_Type; select_place : out Integer; Player: in Positive);
  procedure message (X_Start, Y_Start : in Integer; S : in String);
  procedure message2 (X_Start, Y_Start : in Integer; S : in String);
  procedure message3 (X_Start, Y_Start : in Integer; S : in String);
  procedure message4 (X_Start, Y_Start : in Integer; S : in String);
  procedure dice_placement (D1, D2, D3, D4, D5 : in Integer);
  private

end Yatzy_graphics_package;
