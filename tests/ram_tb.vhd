---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY ram_tb IS
END ram_tb;

ARCHITECTURE testbench OF ram_tb IS 
    COMPONENT ram
        PORT(
                clk : in std_ulogic;
                writeEnable     : in  std_ulogic;
                addr_input      : in  WORD;
                addr_code_input : in  WORD;
                data_in         : in  WORD;
                data_out        : out WORD;
                ins_out         : out PIPELINE_PARAMS
            ); 
    END COMPONENT;

    --Inputs
    signal clk              : std_ulogic;
    signal writeEnable      : std_ulogic;
    signal addr_input       : WORD;
    signal addr_code_input  : WORD;
    signal data_in          : WORD;

   --Outputs
    signal data_out         : WORD;
    signal ins_out          : PIPELINE_PARAMS;

    constant clk_period : time := 500 ps;
BEGIN
    uut: ram PORT MAP (
                          clk => clk,
                          writeEnable => writeEnable,
                          addr_input => addr_input,
                          addr_code_input => addr_code_input,
                          data_in => data_in,
                          data_out => data_out,
                          ins_out => ins_out
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
        writeEnable <= '0' after 0 ns, '1' after 20 ns;
        addr_code_input <= CST_ZERO after 0 ns;
        addr_input <= CST_ZERO after 0 ns, "0000000001000000" after 20 ns; -- write 1 in memory(64)
        data_in <= CST_ONE after 20 ns;
        wait;
    end process;
END;
