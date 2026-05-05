library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity DATA_MEMORY is
generic(
     mem_depth : integer := 64; -- number of words
     addr_bits : integer := 6); -- log2(mem_depth)
port(
     clk : in std_logic;
     we  : in std_logic;
     a   : in std_logic_vector(31 downto 0);
     wd  : in std_logic_vector(31 downto 0);
     rd  : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of DATA_MEMORY is

type memory_type is array(0 to 63) of std_logic_vector(31 downto 0);
signal memory : memory_type := (others => (others => '0'));

begin 
  rd <= memory(to_integer(unsigned(a(addr_bits + 1 downto 2))));

  w : process(clk)
  begin
    if rising_edge(clk) then
      if we = '1' then
        memory(to_integer(unsigned(a(addr_bits + 1 downto 2)))) <= wd;
      end if;
    end if;
  end process;
end behaviour;
  
    
