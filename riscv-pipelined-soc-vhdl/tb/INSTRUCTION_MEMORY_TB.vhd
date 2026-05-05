library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity INSTRUCTION_MEMORY_TB is

end entity;

architecture behaviour of INSTRUCTION_MEMORY_TB is

component INSTRUCTION_MEMORY is
port(
     address  : in std_logic_vector(31 downto 0);
     instr    : out std_logic_vector(31 downto 0));
end component;

signal address_s : std_logic_vector(31 downto 0) := (others => '0');
signal instr_s   : std_logic_vector(31 downto 0) := (others => '0');

begin
  
  dut: INSTRUCTION_MEMORY
    port map (
              address => address_s,
              instr   => instr_s);
  
  stimuli: process
  begin
    wait for 10 ns ;
    address_s <= x"00000004";
    wait for 10 ns ;
    address_s <= x"00000008";
    wait for 10 ns ;
    address_s <= x"0000000c";
    wait for 10 ns ;
    address_s <= x"00000010";
    wait;
  end process;

end behaviour;
