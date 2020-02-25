package Sensors.Images is

   function Image (Source : Bus_Id) return String;
   function Image (Source : Chip_Name) return String;
   function Image (Source : Feature_Type)return String;

   function Image (Source : Natural)return String;

   function Image (Source : Ada.Strings.Unbounded.Unbounded_String)return String;
   function Image (Source : String)return String;

end Sensors.Images;
