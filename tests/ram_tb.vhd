---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.SOC_PKG.ALL;

ENTITY ram_tb IS
END ram_tb;

ARCHITECTURE testbench OF ram_tb IS 
    -- Instantiate the Unit Under Test (UUT)
    COMPONENT ram
        PORT(   clk : in std_ulogic;
        
                writeEnable     : in  std_ulogic;
                readEnable      : in  std_ulogic;
                addr_input      : in  std_ulogic_vector(15 downto 0);
                data_input      : in  std_ulogic_vector(15 downto 0);
                data_out        : out std_ulogic_vector(15 downto 0)       
            ); 
    END COMPONENT;

   --Inputs
    signal clk          : std_ulogic;
    signal writeEnable  : std_ulogic;
    signal readEnable   : std_ulogic;
    signal addr_input   : std_ulogic_vector(15 downto 0);
    signal data_input   : std_ulogic_vector(15 downto 0);

   --Outputs
    signal data_out     : std_ulogic_vector(15 downto 0);

    constant clk_period : time := 500 ps;

BEGIN
   -- Unit Under Test (UUT)
    uut: ram PORT MAP (
                          clk => clk,
                          writeEnable => writeEnable,
                          readEnable => readEnable,
                          addr_input => addr_input,
                          data_input => data_input,
                          data_out => data_out
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
        writeEnable <= '0' after 0 ns;
        readEnable <= '1' after 20 ns;
        addr_input <= (others => '0') after 20 ns;
        wait;
    end process;
END;
