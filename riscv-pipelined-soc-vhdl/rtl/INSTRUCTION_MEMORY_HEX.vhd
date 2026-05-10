library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

library ieee;
use ieee.std_logic_textio.all;

-- Simulation-only instruction memory
-- Loads 32-bit instruction words from program.hex
-- One instruction per line, for example:
-- 00100093
-- 00200113
-- 04102023

entity INSTRUCTION_MEMORY is
port(
     address : in  std_logic_vector(31 downto 0);
     instr   : out std_logic_vector(31 downto 0)
);
end entity;

architecture behaviour of INSTRUCTION_MEMORY is

constant ROM_DEPTH : integer := 1024;

type memory_type is array(0 to ROM_DEPTH-1) of std_logic_vector(31 downto 0);

impure function init_rom_from_hex(file_name : string) return memory_type is
    file hex_file       : text open read_mode is file_name;
    variable line_data  : line;
    variable word_data  : std_logic_vector(31 downto 0);
    variable rom_data   : memory_type := (others => x"00000013"); -- NOP
    variable index      : integer := 0;
begin
    while not endfile(hex_file) loop
        readline(hex_file, line_data);

        -- Read one 32-bit hexadecimal instruction
        hread(line_data, word_data);

        if index < ROM_DEPTH then
            rom_data(index) := word_data;
        end if;

        index := index + 1;
    end loop;

    return rom_data;
end function;

signal memory : memory_type := init_rom_from_hex("program.hex");

begin

    -- 1024 instructions need 10 index bits.
    -- address(11 downto 2) selects word index 0 to 1023.
    instr <= memory(to_integer(unsigned(address(11 downto 2))));

end architecture;
