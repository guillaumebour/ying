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
    -- PC
    component PC Port (Din : in WORD;
                       CK : in STD_LOGIC;
                       SENS : in STD_LOGIC;
                       LOAD : in STD_LOGIC;
                       EN : in STD_LOGIC;
                       Dout : out WORD);
    end component;   
    signal PC_Din : WORD;
    signal PC_SENS : STD_LOGIC;
    signal PC_LOAD : STD_LOGIC;
    signal PC_EN : STD_LOGIC;
    signal PC_Dout : WORD;

    -- ALU
    component alu Port (a : in WORD;
                        b : in WORD;
                        ctrl_alu : in WORD;
                        s : out WORD);
    end component;   
    signal alu_a : WORD;
    signal alu_b : WORD;
    signal alu_ctrl_alu : WORD;
    signal alu_s : WORD;

    -- Register file
    component rf Port (clk : in std_logic;
                       addr_a : in REG_ADDR_T;
                       addr_b : in REG_ADDR_T;
                       writeEnable : in std_logic;
                       addr_w : in REG_ADDR_T;
                       data : in WORD;
                       rst : in std_logic;
                       out_a : out WORD;
                       out_b : out WORD
                   );
    end component;
    signal rf_addr_a : REG_ADDR_T;
    signal rf_addr_b : REG_ADDR_T;
    signal rf_writeEnable : std_logic;
    signal rf_addr_w : REG_ADDR_T;
    signal rf_data : WORD;
    signal rf_rst : std_logic;
    signal rf_out_a : WORD;
    signal rf_out_b : WORD;

    -- RAM
    COMPONENT ram
        PORT(   clk : in std_ulogic;
                writeEnable     : in  std_ulogic;
                readEnable      : in  std_ulogic;
                addr_input      : in  std_ulogic_vector(15 downto 0);
                data_input      : in  std_ulogic_vector(15 downto 0);
                data_out        : out std_ulogic_vector(15 downto 0)       
            ); 
    END COMPONENT;
    signal ram_writeEnable  : std_ulogic;
    signal ram_readEnable   : std_ulogic;
    signal ram_addr_input   : std_ulogic_vector(15 downto 0);
    signal ram_data_input   : std_ulogic_vector(15 downto 0);
    signal ram_data_out     : std_ulogic_vector(15 downto 0);

    -- Pipelines
    component lidi Port(clk   : in  STD_LOGIC;
                        p_in  : in  PIPELINE_PARAMS;
                        p_out : out PIPELINE_PARAMS);
    end component;
    signal lidi_p_in : PIPELINE_PARAMS;
    signal lidi_p_out : PIPELINE_PARAMS;

    component diex Port(clk   : in  STD_LOGIC;
                        p_in  : in  PIPELINE_PARAMS;
                        p_out : out PIPELINE_PARAMS);
    end component;
    signal diex_p_in : PIPELINE_PARAMS;
    signal diex_p_out : PIPELINE_PARAMS;

    component exmem Port(clk   : in  STD_LOGIC;
                         p_in  : in  PIPELINE_PARAMS;
                         p_out : out PIPELINE_PARAMS);
    end component;
    signal exmem_p_in : PIPELINE_PARAMS;
    signal exmem_p_out : PIPELINE_PARAMS;

    component memre Port(clk   : in  STD_LOGIC;
                         p_in  : in  PIPELINE_PARAMS;
                         p_out : out PIPELINE_PARAMS);
    end component;
    signal memre_p_in : PIPELINE_PARAMS;
    signal memre_p_out : PIPELINE_PARAMS;
begin
    -- PC
    lPC : PC port map(PC_Din, CK, PC_SENS, PC_LOAD, PC_EN, PC_Dout);

    -- ALU
    lALU : alu port map(alu_a, alu_b, alu_ctrl_alu, alu_s);

    -- Register file
    lRF : rf port map(CK, rf_addr_a, rf_addr_b, rf_writeEnable, rf_addr_w, rf_data, rf_rst, rf_out_a, rf_out_b);

    -- RAM
    lRAM: ram port map(CK, ram_writeEnable, ram_readEnable, ram_addr_input, ram_data_input, ram_data_out);

    -- Pipelines
    llidi : lidi port map(CK, lidi_p_in, lidi_p_out);
    ldiex : diex port map(CK, diex_p_in, diex_p_out);
    lexmem : exmem port map(CK, exmem_p_in, exmem_p_out);
    lmemre : memre port map(CK, memre_p_in, memre_p_out);
end Behavioral;
