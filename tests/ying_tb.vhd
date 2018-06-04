---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.soc_pkg.all;

ENTITY ying_tb IS
END ying_tb;

ARCHITECTURE testbench OF ying_tb IS 
    COMPONENT ying
        PORT(CK   : in  STD_LOGIC);
    END COMPONENT;

    --Inputs
    signal CK : std_logic := '0';

    constant CK_period : time := 500 ps;
BEGIN
    -- Unit Under Test (UUT)
    uut: ying PORT MAP (
                           CK => CK
                       );

    CK_process : process
    begin
        CK <= '0';
        wait for CK_period/2;
        CK <= '1';
        wait for CK_period/2;
    end process;
END;
