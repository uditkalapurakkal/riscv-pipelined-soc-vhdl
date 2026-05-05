library ieee;
use ieee.std_logic_1164.all;
--RISC PIPELINED
entity PROGRAM_COUNTER_TB is

end entity;

architecture behaviour of PROGRAM_COUNTER_TB is

constant clockperiod :time  := 20 ns ; --50MHz

component PROGRAM_COUNTER is 
port(
     clk     : in std_logic;
     rst     : in std_logic;
     pc_next : in std_logic_vector(31 downto 0);
     pc      : out std_logic_vector(31 downto 0));
end component;

signal clk_s, rst_s : std_logic:='0';
signal pc_next_s    : std_logic_vector(31 downto 0) := (others => '0');
signal pc_s         : std_logic_vector(31 downto 0) := (others => '0');

begin

  dut : PROGRAM_COUNTER
  port map (
            clk     => clk_s,
            rst     => rst_s,
            pc_next => pc_next_s,
            pc      => pc_s);

  clk_s <= not clk_s after clockperiod/2;  

  rst_p : process
   
  begin 
    rst_s <= '1';
    wait for 20 ns ;
    rst_s <= '0';
    wait;
  end process;

  stimuli_p : process

  begin 
    wait until rising_edge(clk_s);
    pc_next_s <= x"00000004";
    wait until rising_edge(clk_s);
    pc_next_s <= x"00000008";
    wait until rising_edge(clk_s);
    pc_next_s <= x"0000000c";
    wait until rising_edge(clk_s);
    pc_next_s <= x"00000010";
    wait;

  end process;
end behaviour;















