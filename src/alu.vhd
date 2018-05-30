---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use WORK.SOC_PKG.ALL;

entity alu is
    Port ( clk   : in  STD_LOGIC;
	        pipeline_in : in  PIPELINE_PARAMS;
           pipeline_out : out  PIPELINE_PARAMS);
end alu;

architecture Behavioral of alu is
    alias op_out: WORD is pipeline_out(0);
	 alias a_out: WORD is pipeline_out(1);
	 alias b_out: WORD is pipeline_out(2);
	 alias c_out: WORD is pipeline_out(3);
	 alias flags_out: WORD is pipeline_out(4);
	 
	 alias op_in: WORD is pipeline_in(0);
	 alias a_in: WORD is pipeline_in(1);
	 alias b_in: WORD is pipeline_in(2);
	 alias c_in: WORD is pipeline_in(3);
	 alias flags_in: WORD is pipeline_in(4);
	 signal result_mul: DWORD;
begin
	result_mul <= (b_in * c_in) when op_in = MUL_OPC;
	
	op_out <= op_in;
	a_out <=  (b_in + c_in) when op_in = ADD_OPC else
				 result_mul(0 to 15) when op_in = MUL_OPC else
				 (b_in - c_in) when op_in = SUB_OPC else
				  b_in         when op_in = COP_OPC 	else
				  b_in		   when op_in = AFC_OPC 	else
				  b_in		   when op_in = LOAD_OPC 	else
				  a_in		   when op_in = STR_OPC 	else

				  CST_ONE	   when (op_in = EQU_OPC)  and (b_in = c_in)  else
				  CST_ONE      when (op_in = INF_OPC)  and (a_in < b_in)  else
				  CST_ONE	   when (op_in = INFE_OPC) and (a_in <= b_in) else	
				  CST_ONE	   when op_in = SUP_OPC  else
				  CST_ONE	   when op_in = SUPE_OPC else
				  a_in     	   when op_in = JMP_OPC  else
				  a_in		   when op_in = JMPC_OPC else
				  (others => '0');
									
	b_out <=  b_in 			when op_in = STR_OPC;
end Behavioral;
