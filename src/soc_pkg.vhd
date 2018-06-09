---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package soc_pkg is
    subtype WORD is std_logic_vector(0 to 15);
    subtype DWORD is std_logic_vector(0 to 31);
    subtype DDWORD is std_logic_vector(0 to 63);

    constant pipe_op : integer := 0;
    constant pipe_a  : integer := 1;
    constant pipe_b  : integer := 2;
    constant pipe_c  : integer := 3;
    type PIPELINE_PARAMS is array(0 to 3) of WORD;

    subtype REG_ADDR_T is std_logic_vector(3 downto 0);

    constant DDWORD_ZERO : DDWORD := "0000000000000000000000000000000000000000000000000000000000000000";

    subtype CTRL_ALU_T is std_logic_vector(0 to 1);
    constant CTRL_ALU_ADD : CTRL_ALU_T := "00";
    constant CTRL_ALU_SUB : CTRL_ALU_T := "01";
    constant CTRL_ALU_MUL : CTRL_ALU_T := "10";
    constant CTRL_ALU_DIV : CTRL_ALU_T := "11";

    constant CST_ONE   : WORD := "0000000000000001";
    constant CST_ZERO  : WORD := "0000000000000000";

    constant ADD_OPC  : WORD := "0000000100000000";
    constant MUL_OPC  : WORD := "0000001000000000";
    constant SUB_OPC  : WORD := "0000001100000000";
    constant DIV_OPC  : WORD := "0000010000000000"; -- NYI
    constant COP_OPC  : WORD := "0000010100000000";
    constant AFC_OPC  : WORD := "0000011000000000";
    constant LOAD_OPC : WORD := "0000011100000000";
    constant STR_OPC  : WORD := "0000100000000000";
    constant EQU_OPC  : WORD := "0000100100000000";
    constant INF_OPC  : WORD := "0000101000000000";
    constant INFE_OPC : WORD := "0000101100000000";
    constant SUP_OPC  : WORD := "0000110000000000";
    constant SUPE_OPC : WORD := "0000110100000000";
    constant JMP_OPC  : WORD := "0000111000000000";
    constant POP_OPC  : WORD := "0001000000000000";
    constant PUSH_OPC : WORD := "0001000100000000";
    constant JMPC_OPC : WORD := "0000111100000000";
end soc_pkg;
