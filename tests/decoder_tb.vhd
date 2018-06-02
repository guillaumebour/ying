---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY decoder_tb IS
    END decoder_tb;

ARCHITECTURE testbench OF decoder_tb IS 
    -- Instantiate the Unit Under Test (UUT)
    COMPONENT decoder
        PORT(   
                ins_di  : in DDWORD;
                op      : out WORD;
                a       : out WORD;
                b       : out WORD;
                c       : out WORD
            ); 
    END COMPONENT;

   --Inputs
    signal input_ins_di : DDWORD;
    signal clk : std_logic := '0';

   --Outputs
    signal output_op : WORD;
    signal output_a : WORD;
    signal output_b : WORD;
    signal output_c : WORD;
    
    constant clk_period : time := 500 ps;

BEGIN
   -- Unit Under Test (UUT)
    uut: decoder PORT MAP (
                          ins_di => input_ins_di,
                          op => output_op,
                          a => output_a,
                          b => output_b,
                          c => output_c
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
        -- 0 then ADD 4 2 after 20 ns
        input_ins_di <= DDWORD_ZERO, "0000000000000001000000000000010000000000000000100000000000000000" after 20 ns;
        wait;
    end process;
END;
