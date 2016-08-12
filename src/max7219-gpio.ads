with MAX7219; use MAX7219;
with Interfaces;

package MAX7219.GPIO is

   type Register_Type is new Interfaces.Unsigned_16;

   procedure Write (Id : Id_Range; Register : Register_Type);
   procedure Flush;

end MAX7219.GPIO;
