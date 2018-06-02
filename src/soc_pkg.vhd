---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package soc_pkg is
    subtype WORD is std_logic_vector(0 to 15);
    subtype DWORD is std_logic_vector(0 to 31);
    subtype DDWORD is std_logic_vector(0 to 63);
    -- index 0: op
    -- index 1: a
    -- index 2: b
    -- index 3: c
    -- index 4: flag
    type PIPELINE_PARAMS is array(0 to 4) of WORD;

    constant DDWORD_ZERO : DDWORD := "0000000000000000000000000000000000000000000000000000000000000000";

    constant CTRL_ALU_ADD : WORD := "0000000000000000";
    constant CTRL_ALU_SUB : WORD := "0000000000000001";
    constant CTRL_ALU_MUL : WORD := "0000000000000010";
    constant CTRL_ALU_DIV : WORD := "0000000000000011";

    constant CST_ONE   : WORD := "0000000000000001";
    constant CST_ZERO  : WORD := "0000000000000000";

    constant ADD_OPC  : WORD := "0000000000000001";
    constant MUL_OPC  : WORD := "0000000000000010";
    constant SUB_OPC  : WORD := "0000000000000011";
    constant DIV_OPC  : WORD := "0000000000000100"; -- NYI
    constant COP_OPC  : WORD := "0000000000000101";
    constant AFC_OPC  : WORD := "0000000000000110";
    constant LOAD_OPC : WORD := "0000000000000111";
    constant STR_OPC  : WORD := "0000000000001000";
    constant EQU_OPC  : WORD := "0000000000001001";
    constant INF_OPC  : WORD := "0000000000001010";
    constant INFE_OPC : WORD := "0000000000001011";
    constant SUP_OPC  : WORD := "0000000000001100";
    constant SUPE_OPC : WORD := "0000000000001101";
    constant JMP_OPC  : WORD := "0000000000001110";
    constant JMPC_OPC : WORD := "0000000000001111";
end soc_pkg;
