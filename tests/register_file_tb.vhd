---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY register_file_tb IS
END register_file_tb;

ARCHITECTURE testbench OF register_file_tb IS 
    COMPONENT register_file
        PORT(   
                clk : in std_logic;
                addr_a : in REG_ADDR_T;     -- @A
                addr_b : in REG_ADDR_T;     -- @B
                writeEnable : in std_logic; -- W
                addr_w : in REG_ADDR_T;     -- @W
                data : in WORD;             -- DATA
                out_a : out WORD;           -- QA
                out_b : out WORD           -- QB
            ); 
    END COMPONENT;

    --Inputs
    signal addr_a : REG_ADDR_T;
    signal addr_b : REG_ADDR_T;
    signal writeEnable : std_logic;
    signal addr_w : REG_ADDR_T;
    signal data : WORD;
    signal clk : std_logic := '0';

    --Outputs
    signal out_a : WORD;
    signal out_b : WORD;
    constant clk_period : time := 500 ps;

BEGIN
    uut: register_file PORT MAP (
                                    addr_a => addr_a,
                                    addr_b => addr_b,
                                    writeEnable => writeEnable,
                                    addr_w => addr_w,
                                    data => data,
                                    clk => clk,
                                    out_a => out_a,
                                    out_b => out_b
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
        writeEnable <= '1' after 2 ns, '0' after 5 ns;
        addr_w <= "0010" after 2 ns;
        data <= "0000000000001000" after 2 ns;
        addr_a <= "0010" after 10 ns;
        wait;
    end process;
END;
