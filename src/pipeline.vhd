---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.soc_pkg.all;

entity pipeline is
    Port(clk   : in  STD_LOGIC;
         p_in  : in  PIPELINE_PARAMS;
         p_out : out PIPELINE_PARAMS);
end pipeline;

architecture Behavioral of pipeline is
begin
    process
    begin
        wait until clk'EVENT and clk='1';
        p_out <= p_in;
    end process;
end Behavioral;
