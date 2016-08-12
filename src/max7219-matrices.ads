with MAX7219; use MAX7219;

package MAX7219.Matrices is

   type Pixel_Range is range 0 .. 7;
   type Pixel_Number is mod 2**6;

   type Pixels is array (Pixel_Range, Pixel_Range) of Boolean;

   type Matrix is new MAX7219 with record
      Pixel_Matrix : Pixels;
   end record;

   procedure On (O : in out Matrix; X : Pixel_Range; Y : Pixel_Range);
   procedure Off (O : in out Matrix; X : Pixel_Range; Y : Pixel_Range);
   procedure On (O : in out Matrix; Pixel : Pixel_Number);
   procedure Off (O : in out Matrix; Pixel : Pixel_Number);

end MAX7219.Matrices;
