--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.11.01 Education (64-bit)
--Part Number: GW5A-LV25MG121NC1/I0
--Device: GW5A-25
--Device Version: A
--Created Time: Mon Jun 30 01:18:34 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component Gowin_OSC
    port (
        oscout: out std_logic;
        oscen: in std_logic
    );
end component;

your_instance_name: Gowin_OSC
    port map (
        oscout => oscout,
        oscen => oscen
    );

----------Copy end-------------------
