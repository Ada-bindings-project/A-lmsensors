with Ada.Text_IO; use Ada.Text_IO;
with Sensors.Images;
procedure Sensors.Tests.Main is
   use Sensors.Images;
   S : constant Sensors.Instance := Get_Instance;
begin
   Put_Line (Sensors.Version);
   for I of S.Detected_Chips loop
      Put_Line (Image (I));
   end loop;
end;
