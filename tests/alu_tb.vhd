---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY alu_tb IS
    END alu_tb;

ARCHITECTURE testbench OF alu_tb IS 
    -- Instantiate the Unit Under Test (UUT)
    COMPONENT alu
        PORT(clk   : in  STD_LOGIC;
             pipeline_in : IN  PIPELINE_PARAMS;
             pipeline_out : OUT  PIPELINE_PARAMS
         );
    END COMPONENT;

   --Inputs
    signal pipeline_in : PIPELINE_PARAMS;
    signal clk : std_logic := '0';

   --Outputs
    signal pipeline_out : PIPELINE_PARAMS;

    constant clk_period : time := 500 ps;

BEGIN
   -- Unit Under Test (UUT)
    uut: alu PORT MAP (
                          clk => clk,
                          pipeline_in => pipeline_in,
                          pipeline_out => pipeline_out
                      );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        pipeline_in(0) <= "0000000000000000", MUL_OPC after 20 ns;
        pipeline_in(1) <= "0000000000000000";
        pipeline_in(2) <= "0000000000000010";
        pipeline_in(3) <= "0000000000000010";
        pipeline_in(4) <= "0000000000000000";
        wait;
    end process;
END;
