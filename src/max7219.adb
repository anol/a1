with Registers;    use Registers;
with MAX7219.GPIO; use MAX7219.GPIO;

package body MAX7219 is

   procedure Off (O : in out MAX7219) is
   begin
      Write (O.Id, 0);
   end Off;

end MAX7219;
