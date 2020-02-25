pragma Ada_2012;
package body Sensors.Images is

   -----------
   -- Image --
   -----------

   function Image (Source : Bus_Id) return String is
   begin
      return
        "(Sensor_Type => " & Image (Source.Sensor_Type) & "," &
        " Nr => " & Image (Source.Nr) & ")";
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Source : Chip_Name) return String is
   begin
      return
        "(Prefix => " & Image (Source.Prefix) & "," &
        " Bus => " & Image (Source.Bus) & "," &
        " Addr => " & Image (Source.Addr) & "," &
        " Path => " & Image (Source.Path) & ")";
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Source : Feature_Type) return String is
      Ret : constant String := Source'Img;
   begin
      return Ret (Ret'First + 8 .. Ret'Last);
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Source : Natural) return String is
   begin
      return Source'Img;
   end Image;

   -----------
   -- Image --
   -----------

   function Image
     (Source : Ada.Strings.Unbounded.Unbounded_String) return String
   is
   begin
      return Ada.Strings.Unbounded.To_String (Source);
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Source : String) return String is
   begin
      return '"' & Source & '"';
   end Image;

end Sensors.Images;
