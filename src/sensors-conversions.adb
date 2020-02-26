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
     (Source : Sensors_Feature_Type)
      return Feature_Type is
     (case Source is
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
     (Source : Interfaces.C.Strings.Chars_Ptr)
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
     (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Chip_Name)
      return Chip_Name
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
     (Source : Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature)
      return Feature
   is
   begin
      return  Feature'(Name             => Convert_Up (Source.Name),
                       Number           => Convert_Up (Source.Number),
                       Kind             => Convert_Up (Source.C_Type),
                       First_Subfeature => Convert_Up (Source.First_Subfeature));
   end Convert_Up;

   function Convert_Down (Source : Bus_Id) return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Bus_Id is
   begin
      return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Bus_Id'(C_Type => Convert_Down (Source.Sensor_Type),
                                                                  Nr     => Convert_Down (Source.Nr));
   end;

   function Convert_Down (Source : Chip_Name) return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Chip_Name is
   begin
      return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Chip_Name'(Prefix => Convert_Down (Source.Prefix),
                                                                     Bus    => Convert_Down (Source.Bus),
                                                                     Addr   =>  Convert_Down (Source.Addr),
                                                                     Path   =>  Convert_Down (Source.Path));
   end;

   function Convert_Down (Source : Feature_Type)return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature_Type is
        (case Source is
            when FEATURE_IN        => SENSORS_FEATURE_IN,
            when FEATURE_FAN       => SENSORS_FEATURE_FAN,
            when FEATURE_TEMP      => SENSORS_FEATURE_TEMP,
            when FEATURE_POWER     => SENSORS_FEATURE_POWER,
            when FEATURE_ENERGY    => SENSORS_FEATURE_ENERGY,
            when FEATURE_CURR      => SENSORS_FEATURE_CURR,
            when FEATURE_HUMIDITY  => SENSORS_FEATURE_HUMIDITY,
            when FEATURE_MAX_MAIN  => SENSORS_FEATURE_MAX_MAIN,
            when FEATURE_VID       => SENSORS_FEATURE_VID,
            when FEATURE_INTRUSION => SENSORS_FEATURE_INTRUSION,
            when FEATURE_MAX_OTHER => SENSORS_FEATURE_MAX_OTHER,
            when FEATURE_MAX       => SENSORS_FEATURE_MAX,
            when others            => SENSORS_FEATURE_UNKNOWN);

   function Convert_Down (Source : Feature)return Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature is
   begin
      return  Sensors.LibSensors.Sensors_Sensors_H.Sensors_Feature'(Name             => Convert_Down (Source.Name),
                                                                    Number           => Convert_Down (Source.Number),
                                                                    C_Type           => Convert_Down (Source.Kind),
                                                                    First_Subfeature => Convert_Down (Source.First_Subfeature),
                                                                    Padding1         => 0);
   end;

   function Convert_Down (Source : Natural) return Interfaces.C.Short is (Interfaces.C.Short (Source));
   function Convert_Down (Source : Natural) return Interfaces.C.Int is (Interfaces.C.Int (Source));

   function Convert_Down (Source : Ada.Strings.Unbounded.Unbounded_String)return Interfaces.C.Strings.Chars_Ptr is
     (Interfaces.C.Strings.New_String (Ada.Strings.Unbounded.To_String (Source)));

end Sensors.Conversions;
