---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.SOC_PKG.ALL;

entity ying is
    Port (
             CK : in  STD_LOGIC
         );
end ying;

architecture Behavioral of ying is
    -- ALU
    component alu Port (a : in WORD;
                        b : in WORD;
                        ctrl_alu : in CTRL_ALU_T;
                        s : out WORD);
    end component;   
    signal alu_a : WORD;
    signal alu_b : WORD;
    signal alu_ctrl : CTRL_ALU_T;
    signal alu_s : WORD;

    -- Register file
    component register_file Port (clk : in std_logic;
                                  addr_a : in REG_ADDR_T;
                                  addr_b : in REG_ADDR_T;
                                  writeEnable : in std_logic;
                                  addr_w : in REG_ADDR_T;
                                  data : in WORD;
                                  out_a : out WORD;
                                  out_b : out WORD;
                                  pc_out : out WORD;
                                  pc_en : in std_logic
                              );
    end component;
    signal rf_addr_a : REG_ADDR_T;
    signal rf_addr_b : REG_ADDR_T;
    signal rf_writeEnable : std_logic;
    signal rf_addr_w : REG_ADDR_T;
    signal rf_data : WORD;
    signal rf_out_a : WORD;
    signal rf_out_b : WORD;
    signal rf_pc_out : WORD;
    signal rf_pc_en : std_logic := '1';

    -- RAM
    COMPONENT ram
        PORT(   clk : in std_logic;
                writeEnable     : in  std_logic;
                addr_input      : in  WORD;
                addr_code_input : in  WORD;
                data_in         : in  WORD;
                data_out        : out WORD;
                ins_out         : out PIPELINE_PARAMS
            ); 
    END COMPONENT;
    signal ram_writeEnable      : std_logic;
    signal ram_addr_input       : WORD;
    signal ram_addr_code_input  : WORD;
    signal ram_data_in          : WORD;
    signal ram_data_out         : WORD;
    signal ram_ins_out          : PIPELINE_PARAMS;

    -- Pipelines
    component pipeline Port(clk   : in  STD_LOGIC;
                            p_in  : in  PIPELINE_PARAMS;
                            p_out : out PIPELINE_PARAMS);
    end component;
    signal lidi_p_in : PIPELINE_PARAMS;
    signal lidi_p_out : PIPELINE_PARAMS;
    signal diex_p_in : PIPELINE_PARAMS;
    signal diex_p_out : PIPELINE_PARAMS;
    signal exmem_p_in : PIPELINE_PARAMS;
    signal exmem_p_out : PIPELINE_PARAMS;
    signal memre_p_in : PIPELINE_PARAMS;
    signal memre_p_out : PIPELINE_PARAMS;
begin
    -- ALU
    lALU : alu port map(alu_a, alu_b, alu_ctrl, alu_s);
    alu_a <= diex_p_out(pipe_b);
    alu_b <= diex_p_out(pipe_c);
    alu_ctrl <= CTRL_ALU_ADD when (diex_p_out(pipe_op) = ADD_OPC) else
                CTRL_ALU_SUB when (diex_p_out(pipe_op) = SUB_OPC) else
                CTRL_ALU_MUL when (diex_p_out(pipe_op) = MUL_OPC);

    -- Register file
    lRF : register_file port map(CK, rf_addr_a, rf_addr_b, rf_writeEnable, rf_addr_w, rf_data, rf_out_a, rf_out_b, rf_pc_out, rf_pc_en);
    rf_addr_a <= lidi_p_out(pipe_b)(4 to 7);
    rf_addr_b <= lidi_p_out(pipe_c)(4 to 7);
    rf_writeEnable <= '1' when (memre_p_out(pipe_op) >= ADD_OPC and memre_p_out(pipe_op) <= PUSH_OPC and memre_p_out(pipe_op) /= STR_OPC) else
                      '0';
    rf_addr_w <= memre_p_out(pipe_a)(4 to 7);
    rf_data <= ram_data_out when memre_p_out(pipe_op) = LOAD_OPC else
               memre_p_out(pipe_b);

    -- RAM
    lRAM: ram port map(CK, ram_writeEnable, ram_addr_input, ram_addr_code_input, ram_data_in, ram_data_out, ram_ins_out);
    ram_writeEnable <= '1' when exmem_p_out(pipe_op) = STR_OPC else
                       '0';
    ram_addr_input <= exmem_p_out(pipe_b) when exmem_p_out(pipe_op) = LOAD_OPC else
                      exmem_p_out(pipe_a);
    ram_addr_code_input  <= rf_pc_out;
    ram_data_in  <= exmem_p_out(pipe_b);

    -- Pipelines
    llidi : pipeline port map(CK, lidi_p_in, lidi_p_out);
    lidi_p_in <= ram_ins_out;

    ldiex : pipeline port map(CK, diex_p_in, diex_p_out);
    diex_p_in(pipe_op) <= lidi_p_out(pipe_op);
    diex_p_in(pipe_a)  <= lidi_p_out(pipe_a);
    diex_p_in(pipe_b)  <= rf_out_a when (lidi_p_out(pipe_op) = COP_OPC or lidi_p_out(pipe_op) = STR_OPC) else
                          lidi_p_out(pipe_b);
    diex_p_in(pipe_c)  <= rf_out_b;

    lexmem : pipeline port map(CK, exmem_p_in, exmem_p_out);
    exmem_p_in(pipe_op) <= diex_p_out(pipe_op);
    exmem_p_in(pipe_a)  <= diex_p_out(pipe_a);
    exmem_p_in(pipe_b)  <= alu_s when (diex_p_out(pipe_op) = ADD_OPC or diex_p_out(pipe_op) = SUB_OPC or diex_p_out(pipe_op) = MUL_OPC) else
                           diex_p_out(pipe_b);
    exmem_p_in(pipe_c)  <= diex_p_out(pipe_c);

    lmemre : pipeline port map(CK, memre_p_in, memre_p_out);
    memre_p_in(pipe_op) <= exmem_p_out(pipe_op);
    memre_p_in(pipe_a)  <= exmem_p_out(pipe_a);
    memre_p_in(pipe_b)  <= ram_data_out when (exmem_p_out(pipe_op) = LOAD_OPC) else
                           exmem_p_out(pipe_b);
    memre_p_in(pipe_c)  <= exmem_p_out(pipe_c);
end Behavioral;
