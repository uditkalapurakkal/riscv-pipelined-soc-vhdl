library ieee;
use ieee.std_logic_1164.all;
--RISC PIPELINED
entity PROGRAM_COUNTER is
port(
     clk     : in std_logic;
     rst     : in std_logic;
     pc_next : in std_logic_vector(31 downto 0);
     stall   : in std_logic; 
     pc      : out std_logic_vector(31 downto 0));
end entity;

architecture behaviour of PROGRAM_COUNTER is 

begin

  process(clk,rst)
  begin 
    if rst = '1' then
    pc <= (others => '0');
    elsif rising_edge(clk) then
    if stall = '0' then
    pc <= pc_next;
    end if;
    end if;
  end process;

end behaviour;
      
