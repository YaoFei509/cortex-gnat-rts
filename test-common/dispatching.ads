--  Copyright (C) 2016 Free Software Foundation, Inc.

--  This file is part of the FreeRTOS-Ada package.
--
--  The FreeRTOS-Ada package is free software; you can redistribute
--  it and/or modify it under the terms of the GNU General Public
--  License as published by the Free Software Foundation; either
--  version 3 of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; see the file COPYING3.  If not, see
--  <http://www.gnu.org/licenses/>.

package Dispatching is

private

   type Base is abstract tagged null record;
   function Value (B : Base) return Integer is abstract;
   function Basis (B : Base) return Character;

   type Derived is new Base with null record;
   overriding
   function Value (D : Derived) return Integer;

end Dispatching;
