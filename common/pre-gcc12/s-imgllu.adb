------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       S Y S T E M . I M G _ L L U                        --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2017, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
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

with System.Unsigned_Types; use System.Unsigned_Types;

--  Modified from GCC 7.1.0 to remove recursion for FreeRTOS-Ada.

package body System.Img_LLU is

   ------------------------------
   -- Image_Long_Long_Unsigned --
   ------------------------------

   procedure Image_Long_Long_Unsigned
     (V : System.Unsigned_Types.Long_Long_Unsigned;
      S : in out String;
      P : out Natural)
   is
      pragma Assert (S'First = 1);
   begin
      S (1) := ' ';
      P := 1;
      Set_Image_Long_Long_Unsigned (V, S, P);
   end Image_Long_Long_Unsigned;

   ----------------------------------
   -- Set_Image_Long_Long_Unsigned --
   ----------------------------------

   procedure Set_Image_Long_Long_Unsigned
     (V : Long_Long_Unsigned;
      S : in out String;
      P : in out Natural)
   is
      Local_V : Long_Long_Unsigned := V;
      Local_P : Natural := P;
      Reversed : String (S'Range);
   begin
      while Local_V >= 10 loop
         Local_P := Local_P + 1;
         Reversed (Local_P) := Character'Val (48 + (Local_V rem 10));
         Local_V := Local_V / 10;
      end loop;
      Local_P := Local_P + 1;
      Reversed (Local_P) := Character'Val (48 + Local_V);
      for J in 0 .. (Local_P - P) loop
         S (P + 1 + J) := Reversed (Local_P - J);
      end loop;
      P := Local_P;
   end Set_Image_Long_Long_Unsigned;

end System.Img_LLU;
