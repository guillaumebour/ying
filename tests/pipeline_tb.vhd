---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.soc_pkg.all;

ENTITY pipeline_tb IS
END pipeline_tb;

ARCHITECTURE testbench OF pipeline_tb IS 
    COMPONENT pipeline
        PORT(clk   : in  STD_LOGIC;
             p_in  : in  PIPELINE_PARAMS;
             p_out : out PIPELINE_PARAMS);
    END COMPONENT;

    --Inputs
    signal p_in  : PIPELINE_PARAMS;
    signal clk : std_logic := '0';

    --Outputs
    signal p_out : PIPELINE_PARAMS;

    constant clk_period : time := 500 ps;

BEGIN
    uut: pipeline PORT MAP (
                               clk => clk,
                               p_in => p_in,
                               p_out => p_out
                           );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc : process
    begin
        p_in(0) <= CST_ZERO, CST_ONE after 20 ns;
        p_in(1) <= CST_ZERO, CST_ONE after 25 ns;
        p_in(2) <= CST_ZERO, CST_ONE after 30 ns;
        p_in(3) <= CST_ZERO, CST_ONE after 35 ns;
        wait;
    end process;
END;
