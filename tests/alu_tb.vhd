---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY alu_tb IS
END alu_tb;

ARCHITECTURE testbench OF alu_tb IS 
    COMPONENT alu
        PORT(a : in WORD;
             b : in WORD;
             ctrl_alu : in CTRL_ALU_T;
             s : out WORD); 
    END COMPONENT;

    --Inputs
    signal input_a : WORD;
    signal input_b : WORD;
    signal input_ctrl_alu : CTRL_ALU_T;
    signal clk : std_logic := '0';

    --Outputs
    signal output_s : WORD;

    constant clk_period : time := 500 ps;
BEGIN
    uut: alu PORT MAP (
                          a => input_a,
                          b => input_b,
                          ctrl_alu => input_ctrl_alu,
                          s => output_s
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
        input_a <= CST_ZERO, CST_ONE after 20 ns;
        input_b <= CST_ZERO, CST_ONE after 30 ns;
        input_ctrl_alu <= CTRL_ALU_ADD, CTRL_ALU_SUB after 40 ns;
        wait;
    end process;
END;
