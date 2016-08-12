with MAX7219; use MAX7219;

package MAX7219.Numbers is

   type DP_Range_Type is range 0 .. 8;

   type Number is new MAX7219 with record
      DP    : DP_Range_Type;
      Value : Integer;
   end record;

   procedure SetDP (O : Number; DP : DP_Range_Type);
   procedure Set (O : Number; Value : Integer);

end MAX7219.Numbers;
