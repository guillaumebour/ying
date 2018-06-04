---------------------------------------------------
-- Copyright (C) 2018 kido (aka Floflo) & Guigui --
---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity ram is
    generic (
                MEM_IMG_FILENAME : string := "data/mem_img/mem.txt"
            );
    port (
             clk : in std_ulogic; -- clock signal
             writeEnable     : in  std_ulogic;
             readEnable      : in  std_ulogic;
             addr_input      : in  std_ulogic_vector(15 downto 0);
             data_input      : in  std_ulogic_vector(15 downto 0);
             data_out        : out std_ulogic_vector(15 downto 0)  
         );
end entity ram;

architecture Behavioral of ram is
    signal b_data : std_ulogic_vector(15 downto 0);

    type MEM_T is array(0 to integer((2 ** 16) - 1)) of
    std_ulogic_vector(15 downto 0);

    impure function create_mem_img return MEM_T is
        file v_file     : text;
        variable v_line : line;
        variable i : integer := 0;
        variable v_mem        : MEM_T;
        variable v_bit_vector : bit_vector(15 downto 0);
    begin
        file_open(v_file, MEM_IMG_FILENAME, read_mode);

        while not endfile(v_file) loop
            readline(v_file, v_line);

            read(v_line, v_bit_vector);
            v_mem(i) := to_stdulogicvector(v_bit_vector);
            i := i + 1;
        end loop;

        file_close(v_file);

        return v_mem;
    end function create_mem_img;

    signal memory : MEM_T := create_mem_img;
begin
    data_out <= b_data;

    mem_read_write : process (clk) is
    begin
        if (rising_edge(clk)) then
            if (readEnable = '1') then
                b_data <= memory(to_integer(unsigned(addr_input)));
            end if;

            if (writeEnable = '1') then
                memory(to_integer(unsigned(addr_input))) <= data_input;
            end if;
        end if;
    end process mem_read_write;
end architecture;
