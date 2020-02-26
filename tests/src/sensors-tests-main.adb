with Ada.Text_IO; use Ada.Text_IO;
with Sensors.Images;
procedure Sensors.Tests.Main is
   use Sensors.Images;
   S : constant Sensors.Instance := Get_Instance;
begin
   Put_Line (Sensors.Version);
   for chip  of S.Detected_Chips loop
      Put_Line (Image (chip));
--        for Sensor of Chip loop
--           null;
--        end loop;

   end loop;
end;
