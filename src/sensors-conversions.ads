with Interfaces.C.Strings;
with Sensors.LibSensors.Sensors_Sensors_H;
private package Sensors.Conversions is

   function Convert_Up (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Bus_Id) return Bus_Id;
   function Convert_Up (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Chip_Name) return Chip_Name;
   function Convert_Up (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature_Type)return Feature_Type;
   function Convert_Up (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature)return Feature;

   function Convert_Up (Source : Interfaces.C.Short) return Natural;
   function Convert_Up (Source : Interfaces.C.Int) return Natural;

   function Convert_Up (Source : Interfaces.C.Strings.Chars_Ptr)return Ada.Strings.Unbounded.Unbounded_String;

   function Convert_Down (Source : Bus_Id) return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Bus_Id;
   function Convert_Down (Source : Chip_Name) return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Chip_Name;
   function Convert_Down (Source : Feature_Type)return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature_Type;
   function Convert_Down (Source : Feature)return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature;

   function Convert_Down (Source : Natural) return Interfaces.C.Short;
   function Convert_Down (Source : Natural) return Interfaces.C.Int;

   function Convert_Down (Source : Ada.Strings.Unbounded.Unbounded_String)return Interfaces.C.Strings.Chars_Ptr;

end Sensors.Conversions;
