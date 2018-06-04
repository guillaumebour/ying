---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY pc_tb IS
END pc_tb;

ARCHITECTURE testbench OF pc_tb IS 
    COMPONENT pc
        PORT(
                Din : IN  WORD;
                CK : IN  std_logic;
                LOAD : IN  std_logic;
                EN : IN  std_logic;
                Dout : OUT  WORD
            );
    END COMPONENT;

   --Inputs
    signal Din : WORD := CST_ONE;
    signal CK : std_logic := '0';
    signal LOAD : std_logic := '0';
    signal EN : std_logic := '0';

   --Outputs
    signal Dout : WORD;

    constant CK_period : time := 500 ps;
BEGIN
    uut: pc PORT MAP (
                        Din => Din,
                        CK => CK,
                        LOAD => LOAD,
                        EN => EN,
                        Dout => Dout
                     );

    CK_process :process
    begin
        CK <= '0';
        wait for CK_period/2;
        CK <= '1';
        wait for CK_period/2;
    end process;

    stim_proc: process
    begin
        Din <= "0000000000001000" after 10 ns;
        LOAD <= '1' after 10 ns, '0' after 20 ns;
        wait;
    end process;
END;
