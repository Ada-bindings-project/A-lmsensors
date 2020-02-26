------------------------------------------------------------
--  This is the root for the lowlevel C interface
--  Where the Ada-specs are automaticly generated.
--  The package is private in order to guarantie that
--  no one outsite this libraray is using the internals without
--  beeing aware.
------------------------------------------------------------

private package Sensors.LibSensors is
   pragma Linker_Options ("-l" & "sensors");
   pragma Linker_Options ("-l" & "m");
end Sensors.libSensors;
