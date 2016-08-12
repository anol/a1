with Interfaces;

package MAX7219 is

   type Default_Op_Codes is
     (NoOp,
      Digit0,
      Digit1,
      Digit2,
      Digit3,
      Digit4,
      Digit5,
      Digit6,
      Digit7,
      CodeB,
      Intensity,
      ScanLimit,
      Shutdown,
      Test);

   for Default_Op_Codes use
     (NoOp      => 16#000#,
      Digit0    => 16#100#,
      Digit1    => 16#200#,
      Digit2    => 16#300#,
      Digit3    => 16#400#,
      Digit4    => 16#500#,
      Digit5    => 16#600#,
      Digit6    => 16#700#,
      Digit7    => 16#800#,
      CodeB     => 16#9FF#, -- Code-B: No Decode=16#00#, Decode All=16#FF#
      Intensity => 16#A08#, -- Intensity: Minimum=16#00#, Maximum=16#0F
      ScanLimit => 16#B07#, -- Scan Limit: Digit0=16#00#, All Digits=16#07#
      Shutdown  => 16#C01#, -- Shutdown Mode=0, Normal Operation=1
      Test      => 16#F00#); -- Display Test=1, Normal Operation=0

   type Id_Range is new Interfaces.Unsigned_16 range 1 .. 4;

   type MAX7219 is tagged record
      Id : Id_Range;
   end record;

   procedure Off (O : in out MAX7219);

end MAX7219;
