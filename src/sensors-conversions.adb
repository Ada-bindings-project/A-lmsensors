package body Sensors.Conversions is
   use Sensors.LibSensors.Sensors_Sensors_H;
   ----------------
   -- Convert_Up --
   ----------------
   function Convert_Up
     (Source : Interfaces.C.Short)
      return Natural is (Natural (Source));

   function Convert_Up
     (Source : Interfaces.C.Int)
      return Natural is (Natural (Source));

   function Convert_Up
     (Source : sensors_feature_type)
      return Feature_Type is
     (Case Source is
         when SENSORS_FEATURE_IN        => FEATURE_IN,
         when SENSORS_FEATURE_FAN       => FEATURE_FAN,
         when SENSORS_FEATURE_TEMP      => FEATURE_TEMP,
         when SENSORS_FEATURE_POWER     => FEATURE_POWER,
         when SENSORS_FEATURE_ENERGY    => FEATURE_ENERGY,
         when SENSORS_FEATURE_CURR      => FEATURE_CURR,
         when SENSORS_FEATURE_HUMIDITY  => FEATURE_HUMIDITY,
         when SENSORS_FEATURE_MAX_MAIN  => FEATURE_MAX_MAIN,
         when SENSORS_FEATURE_VID       => FEATURE_VID,
         when SENSORS_FEATURE_INTRUSION => FEATURE_INTRUSION,
         when SENSORS_FEATURE_MAX_OTHER => FEATURE_MAX_OTHER,
         when SENSORS_FEATURE_MAX       => FEATURE_MAX,
         when others                    => FEATURE_UNKNOWN);

   function Convert_Up
     (Source : Interfaces.C.Strings.chars_ptr)
      return Ada.Strings.Unbounded.Unbounded_String is (Ada.Strings.Unbounded.To_Unbounded_String (Interfaces.C.Strings.Value (Source)));


   function Convert_Up
     (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Bus_Id)
      return Bus_Id
   is
   begin
      return Bus_Id'(Sensor_Type => Convert_Up (Source.C_Type),
                     Nr          => Convert_Up (Source.Nr));
   end Convert_Up;

   ----------------
   -- Convert_Up --
   ----------------

   function Convert_Up
     (Source : Sensors.LibSensors.Sensors_Sensors_H.sensors_chip_name)
      return chip_name
   is
   begin
      return Chip_Name'(Prefix => Convert_Up (Source.Prefix),
                        Bus    => Convert_Up (Source.Bus),
                        Addr   =>  Convert_Up (Source.Addr),
                        Path   =>  Convert_Up (Source.Path));
   end Convert_Up;

   ----------------
   -- Convert_Up --
   ----------------

   function Convert_Up
     (Source : Sensors.LibSensors.Sensors_Sensors_H.sensors_feature)
      return feature
   is
   begin
      return  Feature'(Name => Convert_Up (Source.Name),
                       Number => Convert_Up (Source.Number),
                       Kind   => Convert_Up (Source.c_type),
                       First_Subfeature => Convert_Up (Source.First_Subfeature));
   end Convert_Up;

end Sensors.Conversions;
