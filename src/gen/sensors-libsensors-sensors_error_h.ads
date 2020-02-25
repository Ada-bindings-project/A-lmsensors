pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package Sensors.libSensors.sensors_error_h is

   SENSORS_ERR_WILDCARDS : constant := 1;  --  /usr/include/sensors/error.h:25
   SENSORS_ERR_NO_ENTRY : constant := 2;  --  /usr/include/sensors/error.h:26
   SENSORS_ERR_ACCESS_R : constant := 3;  --  /usr/include/sensors/error.h:27
   SENSORS_ERR_KERNEL : constant := 4;  --  /usr/include/sensors/error.h:28
   SENSORS_ERR_DIV_ZERO : constant := 5;  --  /usr/include/sensors/error.h:29
   SENSORS_ERR_CHIP_NAME : constant := 6;  --  /usr/include/sensors/error.h:30
   SENSORS_ERR_BUS_NAME : constant := 7;  --  /usr/include/sensors/error.h:31
   SENSORS_ERR_PARSE : constant := 8;  --  /usr/include/sensors/error.h:32
   SENSORS_ERR_ACCESS_W : constant := 9;  --  /usr/include/sensors/error.h:33
   SENSORS_ERR_IO : constant := 10;  --  /usr/include/sensors/error.h:34
   SENSORS_ERR_RECURSION : constant := 11;  --  /usr/include/sensors/error.h:35

  --    error.h - Part of libsensors, a Linux library for reading sensor data.
  --    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
  --    Copyright (C) 2007-2010   Jean Delvare <jdelvare@suse.de>
  --    This library is free software; you can redistribute it and/or
  --    modify it under the terms of the GNU Lesser General Public
  --    License as published by the Free Software Foundation; either
  --    version 2.1 of the License, or (at your option) any later version.
  --    This library is distributed in the hope that it will be useful,
  --    but WITHOUT ANY WARRANTY; without even the implied warranty of
  --    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  --    GNU Lesser General Public License for more details.
  --    You should have received a copy of the GNU General Public License
  --    along with this program; if not, write to the Free Software
  --    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  --    MA 02110-1301 USA.
  -- 

  -- This function returns a pointer to a string which describes the error.
  --   errnum may be negative (the corresponding positive error is returned).
  --   You may not modify the result!  

   function sensors_strerror (errnum : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/sensors/error.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_strerror";

  -- These functions are called when a parse error is detected. Give them new
  --   values, and your own functions are called instead of the default (which
  --   print to stderr). These functions may terminate the program, but they
  --   usually output an error and return. The first function is the original
  --   one, the second one was added later when support for multiple
  --   configuration files was added.
  --   The library code now only calls the second function. However, for
  --   backwards compatibility, if an application provides a custom handling
  --   function for the first function but not the second, then all parse
  --   errors will be reported using the first function (that is, the filename
  --   is never reported.)
  --   Note that filename can be NULL (if filename isn't known) and lineno
  --   can be 0 (if the error occurs before the actual parsing starts.)  

   sensors_parse_error : access procedure (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : int)  -- /usr/include/sensors/error.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_parse_error";

   sensors_parse_error_wfn : access procedure
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int)  -- /usr/include/sensors/error.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_parse_error_wfn";

  -- This function is called when an immediately fatal error (like no
  --   memory left) is detected. Give it a new value, and your own function
  --   is called instead of the default (which prints to stderr and ends
  --   the program). Never let it return!  

   sensors_fatal_error : access procedure (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr)  -- /usr/include/sensors/error.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_fatal_error";

end Sensors.libSensors.sensors_error_h;
