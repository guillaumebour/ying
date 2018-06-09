---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.SOC_PKG.ALL;

entity register_file is
    Port (
            clk : in std_logic;
            addr_a : in REG_ADDR_T;     -- @A
            addr_b : in REG_ADDR_T;     -- @B
            writeEnable : in std_logic; -- W
            addr_w : in REG_ADDR_T;     -- @W
            data : in WORD;             -- DATA
            out_a : out WORD;           -- QA
            out_b : out WORD            -- QB
        );
end register_file;

architecture Behavioral of register_file is
    type REG_FILE_T is array(0 to 15) of WORD;
    signal registers : REG_FILE_T := (14 => "1111111111111111", others => CST_ZERO);
begin
    -- Reading A and B (before bypass)
    out_a <= registers(to_integer(unsigned(addr_a)));
    out_b <= registers(to_integer(unsigned(addr_b)));
    
    -- Bypass ? 
    out_a <= data when addr_a = addr_w;
    out_b <= data when addr_b = addr_w;
    
    process
    begin
        wait until clk'EVENT and clk='1';
        -- Write and bypass
        if writeEnable = '1' then
            registers(to_integer(unsigned(addr_w))) <= data;
        end if;
    end process;    
end Behavioral;
