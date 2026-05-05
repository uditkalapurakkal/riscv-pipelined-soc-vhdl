library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity mux_tb is
generic (width : integer := 32);
end entity;

architecture behaviour of mux_tb is

component mux is 

port(
     d0   : in std_logic_vector(width-1 downto 0);
     d1   : in std_logic_vector(width-1 downto 0);
     sel  : in std_logic;
     y    : out std_logic_vector(width-1 downto 0));

end component;

signal d0_s,d1_s : std_logic_vector(width-1 downto 0) := (others => '0');
signal sel_s     : std_logic                          := '0';
signal y_s       : std_logic_vector(width-1 downto 0);

begin
  
  dut:mux
  port map(
           d0  => d0_s,
           d1  => d1_s,
           sel => sel_s,
           y   => y_s); 

  cmb : process
  begin
  sel_s <= '1';
  d1_s  <= x"00000001";
  wait for 20 ns ;
  sel_s <= '0';
  d0_s  <= x"00000011";
  wait for 20 ns ;
  sel_s <= 'X' ;
  wait for 20 ns ;
  wait;
  end process;

  
end behaviour;    
