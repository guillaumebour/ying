---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use WORK.SOC_PKG.ALL;

entity alu is
    Port (
            a : in WORD;
            b : in WORD;
            ctrl_alu : in CTRL_ALU_T;
            s : out WORD
        );
end alu;

architecture Behavioral of alu is
    signal result_mul: DWORD;
begin
    result_mul <= (a * b);

    s <= (a + b) when ctrl_alu = CTRL_ALU_ADD else
         (a - b) when ctrl_alu = CTRL_ALU_SUB else
         result_mul(16 to 31) when ctrl_alu = CTRL_ALU_MUL else
         (others => '0');
end Behavioral;
