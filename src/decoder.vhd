---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use WORK.SOC_PKG.ALL;

entity decoder is
    Port (
            ins_di  : in DDWORD;
            op      : out WORD;
            a       : out WORD;
            b       : out WORD;
            c       : out WORD
        );
end decoder;

architecture Behavioral of decoder is
    
begin
    op <= ins_di(0 to 15);
    a  <= ins_di(16 to 31);
    b  <= ins_di(32 to 47);
    c  <= ins_di(48 to 63);
end Behavioral;
