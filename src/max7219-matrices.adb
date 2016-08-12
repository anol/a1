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
     (O      : Matrix;
      Column : Pixel_Range) return Register_Type
   is
      pragma Unreferenced (O, Column);
      --      Value : Register_Type := As_Register_Type(Shift_Left(Column, 4));
      Value : constant Register_Type := 0;
   begin
      return Value;
   end Column_2_Register;

   procedure On (O : in out Matrix; Pixel : Pixel_Number) is
      Raw    : constant Register_Type := As_Register_Type (Pixel);
      Column : constant Pixel_Range   := As_Pixel_Range (Shift_Right (Raw, 3));
      Row    : constant Pixel_Range   := As_Pixel_Range ((Raw and 16#7#));
   begin
      O.Pixel_Matrix (Row, Column) := True;
      Write (Id => O.Id, Register => Column_2_Register (O, Column));
   end On;

   procedure Off (O : in out Matrix; Pixel : Pixel_Number) is
      pragma Unreferenced (O, Pixel);
   begin
      null;
   end Off;

end MAX7219.Matrices;
