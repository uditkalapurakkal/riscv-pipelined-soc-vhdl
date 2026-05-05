library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity REGISTER_FILE is
port(
     clk      : in std_logic;
     we3      : in std_logic;
     ra1, ra2 : in std_logic_vector(4 downto 0); --read address rd = rs1 +rs2
     rd       : in std_logic_vector(4 downto 0); -- write address
     wd3       : in std_logic_vector(31 downto 0); --data to write
     rd1, rd2 : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of REGISTER_FILE is

type register_type is array(0 to 31) of std_logic_vector(31 downto 0);
signal reg_type : register_type := (others => x"00000000");

begin
  rd1 <= reg_type(to_integer(unsigned(ra1)));
  rd2 <= reg_type(to_integer(unsigned(ra2)));

  w: process(clk)
  begin
    if falling_edge(clk) then
      if we3 = '1' then
        if rd /= "00000" then
          reg_type(to_integer(unsigned(rd))) <= wd3;
        end if;
      end if;
     end if;
end process;
end behaviour;
      
        
      
  