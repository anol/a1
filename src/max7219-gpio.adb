with Registers;    use Registers;
with STM32F4;      use STM32F4;
with STM32F4.GPIO; use STM32F4.GPIO;

package body MAX7219.GPIO is


   procedure Write(Id : Id_Range; Value : Register_Type) is
   begin
      null;
   end Write;

   procedure Initialize is
      RCC_AHB1ENR_GPIOE : constant Word := 16#10#;
   begin
      --  Enable clock for GPIO-E
      RCC.AHB1ENR := RCC.AHB1ENR or RCC_AHB1ENR_GPIOE;
      --  Configure PE4-6
      GPIOE.MODER (4 .. 6)   := (others => Mode_OUT);
      GPIOE.OTYPER (4 .. 6)  := (others => Type_PP);
      GPIOE.OSPEEDR (4 .. 6) := (others => Speed_100MHz);
      GPIOE.PUPDR (4 .. 6)   := (others => No_Pull);
   end Initialize;

begin
   Initialize;
end MAX7219.GPIO;
