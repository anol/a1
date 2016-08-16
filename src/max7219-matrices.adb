with Ada.Unchecked_Conversion;
with Registers;    use Registers;
with MAX7219.GPIO; use MAX7219.GPIO;

package body MAX7219.Matrices is

   function As_Register_Type is new Ada.Unchecked_Conversion
     (Source => Pixel_Number,
      Target => Register_Type);

   function As_Pixel_Range is new Ada.Unchecked_Conversion
     (Source => Register_Type,
      Target => Pixel_Range);

   procedure On (O : in out Matrix; X : Pixel_Range; Y : Pixel_Range) is
      pragma Unreferenced (O, X, Y);
   begin
      null;
   end On;

   procedure Off (O : in out Matrix; X : Pixel_Range; Y : Pixel_Range) is
      pragma Unreferenced (O, X, Y);
   begin
      null;
   end Off;

   function Column_2_Register
     (Column      : Pixsel_Column;
      Raw : Register_Type) return Register_Type
   is
      Register : constant Register_Type := ( Shift_Left(Raw, 1) and 16#0038# ) + 16#0100#;
      Pixels : Register_Type := 0;
   begin
      for R in Column'Range loop
         if Column(R) then
            Pixels := ( Pixels or 1 );
         end if;
         Pixels := Shift_Left(Pixels, 1);
      end loop;
      return (Register or Pixels);
   end Column_2_Register;

   procedure On (O : in out Matrix; Pixel : Pixel_Number) is
      Raw    : constant Register_Type := As_Register_Type (Pixel);
      Column : constant Pixel_Range   := As_Pixel_Range (Shift_Right (Raw, 3));
      Row    : constant Pixel_Range   := As_Pixel_Range ((Raw and 16#7#));
   begin
      O.Pixel_Matrix (Row)(Column) := True;
      Write (Id => O.Id, Register => Column_2_Register (O.Pixel_Matrix (Row), Raw));
   end On;

   procedure Off (O : in out Matrix; Pixel : Pixel_Number) is
      Raw    : constant Register_Type := As_Register_Type (Pixel);
      Column : constant Pixel_Range   := As_Pixel_Range (Shift_Right (Raw, 3));
      Row    : constant Pixel_Range   := As_Pixel_Range ((Raw and 16#7#));
   begin
      O.Pixel_Matrix (Row)(Column) := False;
      Write (Id => O.Id, Register => Column_2_Register (O.Pixel_Matrix (Row), Raw));
   end Off;

end MAX7219.Matrices;
