with Ada.Unchecked_Conversion;

with Registers;    use Registers;
with STM32F4;      use STM32F4;
with STM32F4.GPIO; use STM32F4.GPIO;

package body MAX7219.GPIO is

   type Buffer_Type is array (Id_Range) of Register_Type;
   Buffer : Buffer_Type;

   type IO_Port_Type is (Load, Clock, Data);
   for IO_Port_Type use
     (Load  => 16#0010#, -- PE4
      Clock => 16#0020#, -- PE5
      Data  => 16#0040#); -- PE6
   for IO_Port_Type'Size use Word'Size;
   subtype IO_Port_Range is Integer range 4 .. 6;

   function As_Word is new Ada.Unchecked_Conversion
     (Source => IO_Port_Type,
      Target => Word);

   procedure Write (Id : Id_Range; Register : Register_Type) is
   begin
      Buffer (Id) := Register;
   end Write;

   procedure Set (Port : IO_Port_Type) is
   begin
      GPIOD.BSRR := As_Word (Port);
   end Set;

   procedure Clear (Port : IO_Port_Type) is
   begin
      GPIOD.BSRR := Shift_Left (As_Word (Port), 16);
   end Clear;

   procedure Flush is
      X : Register_Type;
   begin
      Clear (Load);
      for K in Buffer'Range loop
         X := Buffer (K);
         for B in 1 .. Register_Type'Size loop
            Clear (Clock);
            if (X and 1) = 1 then
               Set (Data);
            else
               Clear (Data);
            end if;
            X := Shift_Right (X, 1);
            Set (Clock);
         end loop;
      end loop;
      Set (Load);
   end Flush;

   procedure Initialize is
      RCC_AHB1ENR_GPIOE : constant Word := 16#0010#;
   begin
      --  Enable clock for GPIO-E
      RCC.AHB1ENR := RCC.AHB1ENR or RCC_AHB1ENR_GPIOE;
      --  Configure PE4-6
      GPIOE.MODER (IO_Port_Range)   := (others => Mode_OUT);
      GPIOE.OTYPER (IO_Port_Range)  := (others => Type_PP);
      GPIOE.OSPEEDR (IO_Port_Range) := (others => Speed_100MHz);
      GPIOE.PUPDR (IO_Port_Range)   := (others => No_Pull);
   end Initialize;

begin
   Initialize;
end MAX7219.GPIO;
