library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity DATA_MEMORY_TB is

end entity;

architecture behaviour of DATA_MEMORY_TB is

constant clockperiod :time  := 20 ns ; --50MHz

component DATA_MEMORY is
port(
     clk : in std_logic;
     we  : in std_logic;
     a   : in std_logic_vector(5 downto 0);
     wd  : in std_logic_vector(31 downto 0);
     rd  : out std_logic_vector(31 downto 0));
end component;

signal clk_s  : std_logic := '0';
signal we_s   : std_logic := '0';
signal a_s    : std_logic_vector(5 downto 0)  := (others => '0');
signal wd_s   : std_logic_vector(31 downto 0) := (others => '0');
signal rd_s   : std_logic_vector(31 downto 0) := (others => '0');


begin
  
  dut: DATA_MEMORY
  port map(
           clk => clk_s,
           we  => we_s,
           a   => a_s,
           wd  => wd_s,
           rd  => rd_s);
  
  clk_s <= not clk_s after clockperiod/2;

  stimuli:process
  begin
  --sw
  we_s <= '1';
  a_s  <= "000000";
  wd_s <= x"0000002A";
  wait for 20 ns ;
  --lw
  we_s <= '0';
  a_s  <= "000000";
  wait for 20 ns ;
  --sw 5 at loc 1
  we_s <= '1';
  a_s  <= "000001";
  wd_s <= x"00000005";
  wait for 20 ns ;
  --lw 
  we_s <= '0';
  a_s  <= "000001";
  wait for 20 ns ;
  --lw at loc 2
  a_s  <= "000011";
  wait ;
  end process;
end behaviour;
    
           
