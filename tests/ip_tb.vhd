---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;


ENTITY ip_tb IS
    END ip_tb;

ARCHITECTURE testbench OF ip_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT ip
        PORT(
                Din : IN  WORD;
                CK : IN  std_logic;
                SENS : IN  std_logic;
                LOAD : IN  std_logic;
                EN : IN  std_logic;
                Dout : OUT  WORD
            );
    END COMPONENT;

   --Inputs
    signal Din : WORD := CST_ONE;
    signal CK : std_logic := '0';
    signal SENS : std_logic := '1';
    signal LOAD : std_logic := '0';
    signal EN : std_logic := '0';

   --Outputs
    signal Dout : WORD;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

    constant CK_period : time := 500 ps;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
    uut: ip PORT MAP (
                               Din => Din,
                               CK => CK,
                               SENS => SENS,
                               LOAD => LOAD,
                               EN => EN,
                               Dout => Dout
                           );

   -- Clock process definitions
    CK_process :process
    begin
        CK <= '0';
        wait for CK_period/2;
        CK <= '1';
        wait for CK_period/2;
    end process;

   -- Stimulus process
    stim_proc: process
    begin
        Din <= "0000000000001000" after 10 ns;
        LOAD <= '1' after 10 ns, '0' after 20 ns;
        wait;
    end process;
END;
