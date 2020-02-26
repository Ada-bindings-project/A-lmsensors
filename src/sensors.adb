with Interfaces.C.Strings;
with Interfaces.C_Streams;
with Sensors.Conversions;
with Sensors.LibSensors.Sensors_Sensors_H;
with Sensors.LibSensors.Sensors_Error_H;
with Ada.IO_Exceptions;
package body Sensors is

   API_VERSION : constant := 16#500#;

   pragma Compile_Time_Error (API_VERSION /= Sensors.LibSensors.Sensors_Sensors_H.SENSORS_API_VERSION, "Incompatible APIs");

   use all type Interfaces.C.int;
   use Sensors.LibSensors.Sensors_Sensors_H;

   function Error_Image (Code : Interfaces.C.int) return String is
   begin
      return "[" & Code'Img &  "] : " & Interfaces.C.Strings.Value (Sensors.LibSensors.Sensors_Error_H.Sensors_Strerror (Code));
   end;

   function Get_Instance (Config_Path : String := "") return Instance is
      Ret           : Interfaces.C.int;
      Mode          : String := "r" & ASCII.NUL;
      L_Config_Path : constant String := Config_Path & ASCII.NUL;
      F             : aliased Interfaces.C_Streams.FILEs := Interfaces.C_Streams.NULL_Stream;
      use all type Interfaces.C_Streams.FILEs;
   begin
      return Object : Instance do
         if Config_Path /= "" then
            F := Interfaces.C_Streams.Fopen (Filename => L_Config_Path'Address, Mode => Mode'Address);
            if F = Interfaces.C_Streams.NULL_Stream  then
               raise Ada.IO_Exceptions.Name_Error with "Unable to open:" & Config_Path;
            end if;
         end if;
         Ret := Sensors_Init (F);
         if F /= Interfaces.C_Streams.NULL_Stream then
            if Interfaces.C_Streams.Fclose (F) /= 0 then
               null;
            end if;
         end if;
         if Ret /= 0 then
            raise Sensors_Error with Error_Image (Ret);
         end if;
      end return;
   end;

   ------------------
   -- First_Cursor --
   ------------------

   function First_Cursor (Cont : Chips_Iterator) return Chips_Cursor is
   begin
      return Chips_Cursor'(Cont'Unrestricted_Access, 0);
   end First_Cursor;

   -------------
   -- Advance --
   -------------

   function Advance (Cont : Chips_Iterator; Position : Chips_Cursor) return Chips_Cursor
   is
   begin
      return Chips_Cursor'(Position.Ref, Position.I + 1);
   end;

   ------------------------
   -- Cursor_Has_Element --
   ------------------------

   function Cursor_Has_Element
     (Cont : Chips_Iterator; Position : Chips_Cursor) return Boolean
   is
      C   : aliased Interfaces.C.int := Position.I;
      Ret : access constant Sensors_Chip_Name;
   begin
      Ret := Sensors_Get_Detected_Chips (null, C'Access);
      return Ret /= null;
   end Cursor_Has_Element;

   -----------------
   -- Get_Element --
   -----------------

   function Get_Element
     (Cont : Chips_Iterator; Position : Chips_Cursor) return Chip_Name'Class
   is
      pragma Unreferenced (Cont);
      C : aliased Interfaces.C.int := Position.I;
   begin
      return Conversions.Convert_Up (Sensors_Get_Detected_Chips (null, C'Access).all);
   end Get_Element;

   ------------------------
   -- Get_Detected_Chips --
   ------------------------

   function Detected_Chips (Self : Instance) return Chips_Iterator'Class is
   begin
      return Ret : Chips_Iterator do
         null;
      end return;
   end Detected_Chips;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Object : in out Instance) is
      pragma Unreferenced (Object);
   begin
      Sensors.LibSensors.Sensors_Sensors_H.Sensors_Cleanup;
   end Finalize;

   function Version return String is
   begin
      return Interfaces.C.Strings.Value (Sensors.LibSensors.Sensors_Sensors_H.Libsensors_Version);
   end;


--  begin
--     if Binding_Version /= Version then
--        raise Program_Error with "Binding version missmatch";
--     end if;
end Sensors;
