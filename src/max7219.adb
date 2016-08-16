with Registers;    use Registers;
with MAX7219.GPIO;

package body MAX7219 is

   procedure Off (O : in out MAX7219) is
   begin
      GPIO.Write (O.Id, 0);
   end Off;

   procedure Flush is
   begin
      GPIO.Flush;
   end Flush;

end MAX7219;
