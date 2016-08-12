package MAX7219 is

   type Id_Range is range 1 .. 4;

   type MAX7219 is tagged record
      Id : Id_Range;
   end record;

   procedure Off (O : in out MAX7219);

end MAX7219;
