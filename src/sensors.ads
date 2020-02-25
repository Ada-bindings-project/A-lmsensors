--------------------------------------------------------------
--
-- This is a highlevel binding to the lm-sensors interface
--
---------------------------------------------------------------

with Ada.Strings.Unbounded;
private with Ada.Finalization;
private with Interfaces.C;
package Sensors is
   Binding_Version : constant String := "3.5.0";

   type Instance (<>) is tagged private;
   function Get_Instance (Config_Path : String := "/etc/sensors3.conf") return Instance;
   type Bus_Id is record
      Sensor_Type : Natural;
      Nr          : Natural;
   end record;

   type Chip_Name is record
      Prefix : Ada.Strings.Unbounded.Unbounded_String;
      Bus    : Bus_Id;
      Addr   : Integer;
      Path   : Ada.Strings.Unbounded.Unbounded_String;
   end record;
   type Cursor (<>) is private;
   type Chips_Iterator (<>) is tagged limited private with
     Iterable => (First           => First_Cursor,
                  Next            => Advance,
                  Has_Element     => Cursor_Has_Element,
                  Element         => Get_Element);

   function First_Cursor (Cont : Chips_Iterator) return Cursor;
   function Advance (Cont : Chips_Iterator; Position : Cursor) return Cursor;
   function Cursor_Has_Element (Cont : Chips_Iterator; Position : Cursor) return Boolean;
   function Get_Element (Cont : Chips_Iterator; Position : Cursor) return Chip_Name;
   type Feature_Type is (FEATURE_IN,
                         FEATURE_FAN,
                         FEATURE_TEMP,
                         FEATURE_POWER,
                         FEATURE_ENERGY,
                         FEATURE_CURR,
                         FEATURE_HUMIDITY,
                         FEATURE_MAX_MAIN,
                         FEATURE_VID,
                         FEATURE_INTRUSION,
                         FEATURE_MAX_OTHER,
                         FEATURE_BEEP_ENABLE,
                         FEATURE_MAX,
                         FEATURE_UNKNOWN);

   type Feature is record
      Name             : Ada.Strings.Unbounded.Unbounded_String;
      Number           : Natural;
      Kind             : Feature_Type;
      First_Subfeature : Natural;
   end record;


   function Detected_Chips (Self : Instance) return Chips_Iterator'Class;
   Sensors_Error : exception ;
   function Version return String;
private

   type Cursor (Ref : not null access Chips_Iterator) is record
      I : aliased Interfaces.C.Int := 0;
   end record;

   type Instance is new Ada.Finalization.Controlled with record
      null;
   end record;

   procedure Finalize   (Object : in out Instance);
   function Error_Image (Code : Interfaces.C.Int) return String;

   type Chips_Iterator is new Ada.Finalization.Limited_Controlled with record
      null;
   end record;

end Sensors;
