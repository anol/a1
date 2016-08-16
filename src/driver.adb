------------------------------------------------------------------------------
--                                                                          --
--                             GNAT EXAMPLE                                 --
--                                                                          --
--             Copyright (C) 2014, Free Software Foundation, Inc.           --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with LEDs;             use LEDs;
with Button;           use Button;
with MAX7219;          use MAX7219;
with MAX7219.Matrices; use MAX7219.Matrices;
with Ada.Real_Time;    use Ada.Real_Time;

package body Driver is

   type Index is mod 4;

   Pattern : constant array (Index) of User_LED := (Orange, Red, Blue, Green);
   --  The LEDs are not physically laid out "consecutively" in such a way that
   --  we can simply go in enumeral order to get circular rotation. Thus we
   --  define this mapping, using a consecutive index to get the physical LED
   --  blinking order desired.

   task body Controller is
      Period     : constant Time_Span := Milliseconds (100);  -- arbitrary
      Next_Start : Time               := Clock;
      Next_LED   : Index              := 0;
      Counter    : Pixel_Number       := 0;
      Display    : Matrix             :=
        (Id => 1, Pixel_Matrix => (others => (others => False)));
   begin
      loop
         Off (Pattern (Next_LED));
         Display.Off (Counter);
         Counter := Counter + 1;
         Display.On (Counter);
         Flush;
         if Button.Current_Direction = Clockwise then
            Next_LED := Next_LED - 1;
         else
            Next_LED := Next_LED + 1;
         end if;
         On (Pattern (Next_LED));
         Next_Start := Next_Start + Period;
         delay until Next_Start;
      end loop;
   end Controller;

end Driver;
