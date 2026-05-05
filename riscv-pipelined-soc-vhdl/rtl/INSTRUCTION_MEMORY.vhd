library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity INSTRUCTION_MEMORY is
port(
     address  : in std_logic_vector(31 downto 0);
     instr    : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of INSTRUCTION_MEMORY is

type memory_type is array(0 to 63) of std_logic_vector(31 downto 0);
--signal memory : memory_type := (others => x"00000013");
--signal memory : memory_type := (
--    0      => x"00000013",   -- NOP
--    1      => x"00000011",   -- something unique at index 1
--    others => x"00000013");
signal memory : memory_type := (
  0 => x"00100093",  -- addi x1, x0, 1
  1 => x"00200113",  -- addi x2, x0, 2
  2 => x"00400193",  -- addi x3, x0, 4
  3 => x"00800213",  -- addi x4, x0, 8

  4 => x"04102023",  -- sw x1, 64(x0) ; gpio_out = 1
  5 => x"04202023",  -- sw x2, 64(x0) ; gpio_out = 2
  6 => x"04302023",  -- sw x3, 64(x0) ; gpio_out = 4
  7 => x"04402023",  -- sw x4, 64(x0) ; gpio_out = 8

  8 => x"FF1FF06F",  -- jal x0, -16 ; repeat from instruction 4

  others => x"00000013"
);
begin
  instr <= memory(to_integer(unsigned(address(31 downto 2))));
end architecture;


