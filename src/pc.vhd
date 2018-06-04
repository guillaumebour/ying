---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use WORK.SOC_PKG.ALL;

entity pc is
    Port ( Din : in  WORD;
           CK : in  STD_LOGIC;
           SENS : in  STD_LOGIC;
           LOAD : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Dout : out  WORD);
end pc;

architecture Behavioral of pc is
    SIGNAL out_signal: WORD;
begin
    process
    begin
        wait until CK'EVENT and CK='1';
        if LOAD='1' then
            out_signal <= Din;
        elsif EN='0' then 
            if SENS='1' then
                out_signal <= out_signal + 1;
            else
                out_signal <= out_signal - 1;
            end if;
        end if;
    end process;
    Dout <= out_signal;
end Behavioral;