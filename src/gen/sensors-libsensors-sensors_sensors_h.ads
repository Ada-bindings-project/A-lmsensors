pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C_Streams;


package Sensors.libSensors.sensors_sensors_h is

   SENSORS_API_VERSION : constant := 16#500#;  --  /usr/include/sensors/sensors.h:34
   --  unsupported macro: SENSORS_CHIP_NAME_PREFIX_ANY NULL

   SENSORS_CHIP_NAME_ADDR_ANY : constant := (-1);  --  /usr/include/sensors/sensors.h:37

   SENSORS_BUS_TYPE_ANY : constant := (-1);  --  /usr/include/sensors/sensors.h:39
   SENSORS_BUS_TYPE_I2C : constant := 0;  --  /usr/include/sensors/sensors.h:40
   SENSORS_BUS_TYPE_ISA : constant := 1;  --  /usr/include/sensors/sensors.h:41
   SENSORS_BUS_TYPE_PCI : constant := 2;  --  /usr/include/sensors/sensors.h:42
   SENSORS_BUS_TYPE_SPI : constant := 3;  --  /usr/include/sensors/sensors.h:43
   SENSORS_BUS_TYPE_VIRTUAL : constant := 4;  --  /usr/include/sensors/sensors.h:44
   SENSORS_BUS_TYPE_ACPI : constant := 5;  --  /usr/include/sensors/sensors.h:45
   SENSORS_BUS_TYPE_HID : constant := 6;  --  /usr/include/sensors/sensors.h:46
   SENSORS_BUS_TYPE_MDIO : constant := 7;  --  /usr/include/sensors/sensors.h:47
   SENSORS_BUS_TYPE_SCSI : constant := 8;  --  /usr/include/sensors/sensors.h:48
   SENSORS_BUS_NR_ANY : constant := (-1);  --  /usr/include/sensors/sensors.h:49
   SENSORS_BUS_NR_IGNORE : constant := (-2);  --  /usr/include/sensors/sensors.h:50

   SENSORS_MODE_R : constant := 1;  --  /usr/include/sensors/sensors.h:134
   SENSORS_MODE_W : constant := 2;  --  /usr/include/sensors/sensors.h:135
   SENSORS_COMPUTE_MAPPING : constant := 4;  --  /usr/include/sensors/sensors.h:136

  --    sensors.h - Part of libsensors, a Linux library for reading sensor data.
  --    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
  --    Copyright (C) 2007-2014   Jean Delvare <jdelvare@suse.de>
  --    This library is free software; you can redistribute it and/or
  --    modify it under the terms of the GNU Lesser General Public
  --    License as published by the Free Software Foundation; either
  --    version 2.1 of the License, or (at your option) any later version.
  --    This library is distributed in the hope that it will be useful,
  --    but WITHOUT ANY WARRANTY; without even the implied warranty of
  --    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  --    GNU Lesser General Public License for more details.
  --    You should have received a copy of the GNU General Public License
  --    along with this program; if not, write to the Free Software
  --    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  --    MA 02110-1301 USA.
  -- 

  -- Publicly accessible library functions  
  -- libsensors API version define, first digit is the major version (changed
  --   when the API or ABI breaks), the third digit is incremented to track small
  --   API additions like new flags / enum values. The second digit is for tracking
  --   larger additions like new methods.  

   libsensors_version : Interfaces.C.Strings.chars_ptr  -- /usr/include/sensors/sensors.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "libsensors_version";

   type sensors_bus_id is record
      c_type : aliased short;  -- /usr/include/sensors/sensors.h:59
      nr : aliased short;  -- /usr/include/sensors/sensors.h:60
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/sensors/sensors.h:58

  -- A chip name is encoded in this structure  
   type sensors_chip_name is record
      prefix : Interfaces.C.Strings.chars_ptr;  -- /usr/include/sensors/sensors.h:65
      bus : aliased sensors_bus_id;  -- /usr/include/sensors/sensors.h:66
      addr : aliased int;  -- /usr/include/sensors/sensors.h:67
      path : Interfaces.C.Strings.chars_ptr;  -- /usr/include/sensors/sensors.h:68
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/sensors/sensors.h:64

  -- Load the configuration file and the detected chips list. If this
  --   returns a value unequal to zero, you are in trouble; you can not
  --   assume anything will be initialized properly. If you want to
  --   reload the configuration file, call sensors_cleanup() below before
  --   calling sensors_init() again.  

   function sensors_init (input : Interfaces.C_Streams.FILEs) return int  -- /usr/include/sensors/sensors.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_init";

  -- Clean-up function: You can't access anything after
  --   this, until the next sensors_init() call!  

   procedure sensors_cleanup  -- /usr/include/sensors/sensors.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_cleanup";

  -- Parse a chip name to the internal representation. Return 0 on success, <0
  --   on error.  

   function sensors_parse_chip_name (orig_name : Interfaces.C.Strings.chars_ptr; res : access sensors_chip_name) return int  -- /usr/include/sensors/sensors.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_parse_chip_name";

  -- Free memory allocated for the internal representation of a chip name.  
   procedure sensors_free_chip_name (chip : access sensors_chip_name)  -- /usr/include/sensors/sensors.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_free_chip_name";

  -- Print a chip name from its internal representation. Note that chip should
  --   not contain wildcard values! Return the number of characters printed on
  --   success (same as snprintf), <0 on error.  

   function sensors_snprintf_chip_name
     (str : Interfaces.C.Strings.chars_ptr;
      size : size_t;
      chip : access constant sensors_chip_name) return int  -- /usr/include/sensors/sensors.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_snprintf_chip_name";

  -- This function returns the adapter name of a bus,
  --   as used within the sensors_chip_name structure. If it could not be found,
  --   it returns NULL  

   function sensors_get_adapter_name (bus : access constant sensors_bus_id) return Interfaces.C.Strings.chars_ptr  -- /usr/include/sensors/sensors.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_adapter_name";

   type sensors_feature;
  -- Look up the label for a given feature. Note that chip should not
  --   contain wildcard values! The returned string is newly allocated (free it
  --   yourself). On failure, NULL is returned.
  --   If no label exists for this feature, its name is returned itself.  

   function sensors_get_label (name : access constant sensors_chip_name; feature : access constant sensors_feature) return Interfaces.C.Strings.chars_ptr  -- /usr/include/sensors/sensors.h:106
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_label";

  -- Read the value of a subfeature of a certain chip. Note that chip should not
  --   contain wildcard values! This function will return 0 on success, and <0
  --   on failure.   

   function sensors_get_value
     (name : access constant sensors_chip_name;
      subfeat_nr : int;
      value : access double) return int  -- /usr/include/sensors/sensors.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_value";

  -- Set the value of a subfeature of a certain chip. Note that chip should not
  --   contain wildcard values! This function will return 0 on success, and <0
  --   on failure.  

   function sensors_set_value
     (name : access constant sensors_chip_name;
      subfeat_nr : int;
      value : double) return int  -- /usr/include/sensors/sensors.h:118
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_set_value";

  -- Execute all set statements for this particular chip. The chip may contain
  --   wildcards!  This function will return 0 on success, and <0 on failure.  

   function sensors_do_chip_sets (name : access constant sensors_chip_name) return int  -- /usr/include/sensors/sensors.h:123
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_do_chip_sets";

  -- This function returns all detected chips that match a given chip name,
  --   one by one. If no chip name is provided, all detected chips are returned.
  --   To start at the beginning of the list, use 0 for nr; NULL is returned if
  --   we are at the end of the list. Do not try to change these chip names, as
  --   they point to internal structures!  

   function sensors_get_detected_chips (match : access constant sensors_chip_name; nr : access int) return access constant sensors_chip_name  -- /usr/include/sensors/sensors.h:130
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_detected_chips";

  -- These defines are used in the flags field of sensors_subfeature  
   subtype sensors_feature_type is unsigned;
   SENSORS_FEATURE_IN : constant unsigned := 0;
   SENSORS_FEATURE_FAN : constant unsigned := 1;
   SENSORS_FEATURE_TEMP : constant unsigned := 2;
   SENSORS_FEATURE_POWER : constant unsigned := 3;
   SENSORS_FEATURE_ENERGY : constant unsigned := 4;
   SENSORS_FEATURE_CURR : constant unsigned := 5;
   SENSORS_FEATURE_HUMIDITY : constant unsigned := 6;
   SENSORS_FEATURE_MAX_MAIN : constant unsigned := 7;
   SENSORS_FEATURE_VID : constant unsigned := 16;
   SENSORS_FEATURE_INTRUSION : constant unsigned := 17;
   SENSORS_FEATURE_MAX_OTHER : constant unsigned := 18;
   SENSORS_FEATURE_BEEP_ENABLE : constant unsigned := 24;
   SENSORS_FEATURE_MAX : constant unsigned := 25;
   SENSORS_FEATURE_UNKNOWN : constant unsigned := 2147483647;  -- /usr/include/sensors/sensors.h:138

  -- All the sensor types (in, fan, temp, vid) are a multiple of 0x100 apart,
  --   and sensor subfeatures which have no compute mapping have bit 7 set.  

   subtype sensors_subfeature_type is unsigned;
   SENSORS_SUBFEATURE_IN_INPUT : constant unsigned := 0;
   SENSORS_SUBFEATURE_IN_MIN : constant unsigned := 1;
   SENSORS_SUBFEATURE_IN_MAX : constant unsigned := 2;
   SENSORS_SUBFEATURE_IN_LCRIT : constant unsigned := 3;
   SENSORS_SUBFEATURE_IN_CRIT : constant unsigned := 4;
   SENSORS_SUBFEATURE_IN_AVERAGE : constant unsigned := 5;
   SENSORS_SUBFEATURE_IN_LOWEST : constant unsigned := 6;
   SENSORS_SUBFEATURE_IN_HIGHEST : constant unsigned := 7;
   SENSORS_SUBFEATURE_IN_ALARM : constant unsigned := 128;
   SENSORS_SUBFEATURE_IN_MIN_ALARM : constant unsigned := 129;
   SENSORS_SUBFEATURE_IN_MAX_ALARM : constant unsigned := 130;
   SENSORS_SUBFEATURE_IN_BEEP : constant unsigned := 131;
   SENSORS_SUBFEATURE_IN_LCRIT_ALARM : constant unsigned := 132;
   SENSORS_SUBFEATURE_IN_CRIT_ALARM : constant unsigned := 133;
   SENSORS_SUBFEATURE_FAN_INPUT : constant unsigned := 256;
   SENSORS_SUBFEATURE_FAN_MIN : constant unsigned := 257;
   SENSORS_SUBFEATURE_FAN_MAX : constant unsigned := 258;
   SENSORS_SUBFEATURE_FAN_ALARM : constant unsigned := 384;
   SENSORS_SUBFEATURE_FAN_FAULT : constant unsigned := 385;
   SENSORS_SUBFEATURE_FAN_DIV : constant unsigned := 386;
   SENSORS_SUBFEATURE_FAN_BEEP : constant unsigned := 387;
   SENSORS_SUBFEATURE_FAN_PULSES : constant unsigned := 388;
   SENSORS_SUBFEATURE_FAN_MIN_ALARM : constant unsigned := 389;
   SENSORS_SUBFEATURE_FAN_MAX_ALARM : constant unsigned := 390;
   SENSORS_SUBFEATURE_TEMP_INPUT : constant unsigned := 512;
   SENSORS_SUBFEATURE_TEMP_MAX : constant unsigned := 513;
   SENSORS_SUBFEATURE_TEMP_MAX_HYST : constant unsigned := 514;
   SENSORS_SUBFEATURE_TEMP_MIN : constant unsigned := 515;
   SENSORS_SUBFEATURE_TEMP_CRIT : constant unsigned := 516;
   SENSORS_SUBFEATURE_TEMP_CRIT_HYST : constant unsigned := 517;
   SENSORS_SUBFEATURE_TEMP_LCRIT : constant unsigned := 518;
   SENSORS_SUBFEATURE_TEMP_EMERGENCY : constant unsigned := 519;
   SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST : constant unsigned := 520;
   SENSORS_SUBFEATURE_TEMP_LOWEST : constant unsigned := 521;
   SENSORS_SUBFEATURE_TEMP_HIGHEST : constant unsigned := 522;
   SENSORS_SUBFEATURE_TEMP_MIN_HYST : constant unsigned := 523;
   SENSORS_SUBFEATURE_TEMP_LCRIT_HYST : constant unsigned := 524;
   SENSORS_SUBFEATURE_TEMP_ALARM : constant unsigned := 640;
   SENSORS_SUBFEATURE_TEMP_MAX_ALARM : constant unsigned := 641;
   SENSORS_SUBFEATURE_TEMP_MIN_ALARM : constant unsigned := 642;
   SENSORS_SUBFEATURE_TEMP_CRIT_ALARM : constant unsigned := 643;
   SENSORS_SUBFEATURE_TEMP_FAULT : constant unsigned := 644;
   SENSORS_SUBFEATURE_TEMP_TYPE : constant unsigned := 645;
   SENSORS_SUBFEATURE_TEMP_OFFSET : constant unsigned := 646;
   SENSORS_SUBFEATURE_TEMP_BEEP : constant unsigned := 647;
   SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM : constant unsigned := 648;
   SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM : constant unsigned := 649;
   SENSORS_SUBFEATURE_POWER_AVERAGE : constant unsigned := 768;
   SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST : constant unsigned := 769;
   SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST : constant unsigned := 770;
   SENSORS_SUBFEATURE_POWER_INPUT : constant unsigned := 771;
   SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST : constant unsigned := 772;
   SENSORS_SUBFEATURE_POWER_INPUT_LOWEST : constant unsigned := 773;
   SENSORS_SUBFEATURE_POWER_CAP : constant unsigned := 774;
   SENSORS_SUBFEATURE_POWER_CAP_HYST : constant unsigned := 775;
   SENSORS_SUBFEATURE_POWER_MAX : constant unsigned := 776;
   SENSORS_SUBFEATURE_POWER_CRIT : constant unsigned := 777;
   SENSORS_SUBFEATURE_POWER_MIN : constant unsigned := 778;
   SENSORS_SUBFEATURE_POWER_LCRIT : constant unsigned := 779;
   SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL : constant unsigned := 896;
   SENSORS_SUBFEATURE_POWER_ALARM : constant unsigned := 897;
   SENSORS_SUBFEATURE_POWER_CAP_ALARM : constant unsigned := 898;
   SENSORS_SUBFEATURE_POWER_MAX_ALARM : constant unsigned := 899;
   SENSORS_SUBFEATURE_POWER_CRIT_ALARM : constant unsigned := 900;
   SENSORS_SUBFEATURE_POWER_MIN_ALARM : constant unsigned := 901;
   SENSORS_SUBFEATURE_POWER_LCRIT_ALARM : constant unsigned := 902;
   SENSORS_SUBFEATURE_ENERGY_INPUT : constant unsigned := 1024;
   SENSORS_SUBFEATURE_CURR_INPUT : constant unsigned := 1280;
   SENSORS_SUBFEATURE_CURR_MIN : constant unsigned := 1281;
   SENSORS_SUBFEATURE_CURR_MAX : constant unsigned := 1282;
   SENSORS_SUBFEATURE_CURR_LCRIT : constant unsigned := 1283;
   SENSORS_SUBFEATURE_CURR_CRIT : constant unsigned := 1284;
   SENSORS_SUBFEATURE_CURR_AVERAGE : constant unsigned := 1285;
   SENSORS_SUBFEATURE_CURR_LOWEST : constant unsigned := 1286;
   SENSORS_SUBFEATURE_CURR_HIGHEST : constant unsigned := 1287;
   SENSORS_SUBFEATURE_CURR_ALARM : constant unsigned := 1408;
   SENSORS_SUBFEATURE_CURR_MIN_ALARM : constant unsigned := 1409;
   SENSORS_SUBFEATURE_CURR_MAX_ALARM : constant unsigned := 1410;
   SENSORS_SUBFEATURE_CURR_BEEP : constant unsigned := 1411;
   SENSORS_SUBFEATURE_CURR_LCRIT_ALARM : constant unsigned := 1412;
   SENSORS_SUBFEATURE_CURR_CRIT_ALARM : constant unsigned := 1413;
   SENSORS_SUBFEATURE_HUMIDITY_INPUT : constant unsigned := 1536;
   SENSORS_SUBFEATURE_VID : constant unsigned := 4096;
   SENSORS_SUBFEATURE_INTRUSION_ALARM : constant unsigned := 4352;
   SENSORS_SUBFEATURE_INTRUSION_BEEP : constant unsigned := 4353;
   SENSORS_SUBFEATURE_BEEP_ENABLE : constant unsigned := 6144;
   SENSORS_SUBFEATURE_UNKNOWN : constant unsigned := 2147483647;  -- /usr/include/sensors/sensors.h:157

  -- Data about a single chip feature (or category leader)  
   type sensors_feature is record
      name : Interfaces.C.Strings.chars_ptr;  -- /usr/include/sensors/sensors.h:259
      number : aliased int;  -- /usr/include/sensors/sensors.h:260
      c_type : aliased sensors_feature_type;  -- /usr/include/sensors/sensors.h:261
      first_subfeature : aliased int;  -- /usr/include/sensors/sensors.h:263
      padding1 : aliased int;  -- /usr/include/sensors/sensors.h:264
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/sensors/sensors.h:258

  -- Members below are for libsensors internal use only  
  -- Data about a single chip subfeature:
  --   name is the string name used to refer to this subfeature (in config files)
  --   number is the internal subfeature number, used in many functions to refer
  --     to this subfeature
  --   type is the subfeature type
  --   mapping is the number of a main feature this subfeature belongs to
  --     (for example subfeatures fan1_input, fan1_min, fan1_div and fan1_alarm
  --      are mapped to main feature fan1)
  --   flags is a bitfield, its value is a combination of SENSORS_MODE_R (readable),
  --     SENSORS_MODE_W (writable) and SENSORS_COMPUTE_MAPPING (affected by the
  --     computation rules of the main feature)  

   type sensors_subfeature is record
      name : Interfaces.C.Strings.chars_ptr;  -- /usr/include/sensors/sensors.h:279
      number : aliased int;  -- /usr/include/sensors/sensors.h:280
      c_type : aliased sensors_subfeature_type;  -- /usr/include/sensors/sensors.h:281
      mapping : aliased int;  -- /usr/include/sensors/sensors.h:282
      flags : aliased unsigned;  -- /usr/include/sensors/sensors.h:283
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/sensors/sensors.h:278

  -- This returns all main features of a specific chip. nr is an internally
  --   used variable. Set it to zero to start at the begin of the list. If no
  --   more features are found NULL is returned.
  --   Do not try to change the returned structure; you will corrupt internal
  --   data structures.  

   function sensors_get_features (name : access constant sensors_chip_name; nr : access int) return access constant sensors_feature  -- /usr/include/sensors/sensors.h:292
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_features";

  -- This returns all subfeatures of a given main feature. nr is an internally
  --   used variable. Set it to zero to start at the begin of the list. If no
  --   more features are found NULL is returned.
  --   Do not try to change the returned structure; you will corrupt internal
  --   data structures.  

   function sensors_get_all_subfeatures
     (name : access constant sensors_chip_name;
      feature : access constant sensors_feature;
      nr : access int) return access constant sensors_subfeature  -- /usr/include/sensors/sensors.h:300
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_all_subfeatures";

  -- This returns the subfeature of the given type for a given main feature,
  --   if it exists, NULL otherwise.
  --   Do not try to change the returned structure; you will corrupt internal
  --   data structures.  

   function sensors_get_subfeature
     (name : access constant sensors_chip_name;
      feature : access constant sensors_feature;
      c_type : sensors_subfeature_type) return access constant sensors_subfeature  -- /usr/include/sensors/sensors.h:308
   with Import => True, 
        Convention => C, 
        External_Name => "sensors_get_subfeature";

end Sensors.libSensors.sensors_sensors_h;
