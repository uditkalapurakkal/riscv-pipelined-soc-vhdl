library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity REGISTER_FILE_TB is

end entity;

architecture behaviour of REGISTER_FILE_TB is

constant clockperiod :time  := 20 ns ; --50MHz

component REGISTER_FILE is
port(
     clk      : in std_logic;
     we3       : in std_logic;
     ra1, ra2 : in std_logic_vector(4 downto 0); --read address
     rd       : in std_logic_vector(4 downto 0); -- write address rd = rs1 +rs2
     wd3       : in std_logic_vector(31 downto 0); --data to write
     rd1, rd2 : out std_logic_vector(31 downto 0));

end component;

signal clk_s, we3_s        : std_logic := '0';
signal ra1_s, ra2_s, rd_s  : std_logic_vector(4 downto 0):= (others => '0');
signal wd3_s               : std_logic_vector(31 downto 0):= (others => '0');
signal rd1_s, rd2_s        : std_logic_vector(31 downto 0);

begin

  dut: REGISTER_FILE
    port map(
             clk => clk_s,
             we3 => we3_s,
             ra1 => ra1_s,
             ra2 => ra2_s,
             rd  => rd_s,
             wd3 => wd3_s,
             rd1 => rd1_s,
             rd2 => rd2_s);

  clk_s <= not clk_s after clockperiod/2;  
   
  stimulus : process
  begin
    wait for 10 ns ;
    -- rd1
    we3_s <= '1';
    rd_s  <= "00001" ;
    wd3_s  <=x"00000002" ;
    wait until rising_edge(clk_s);
    we3_s <= '0';
    ra1_s <= "00001" ;
    wait for 20 ns ;
    -- rd2
    we3_s <= '1';
    rd_s  <= "00010" ;
    wd3_s  <=x"00000004" ;
    wait until rising_edge(clk_s);
    we3_s <= '0';
    ra2_s <= "00010" ;
    wait for 20 ns ;
    -- check x0
    we3_s <= '1';
    rd_s  <= "00000" ;
    wd3_s  <=x"00000008" ;
    wait until rising_edge(clk_s);
    we3_s <= '0';
    ra1_s <= "00000" ;
    wait;

    end process;
end behaviour;
    --rd1_s <= reg_type(to_integer(unsigned(rs1)));
    
    --rd2_s <= reg_type(to_integer(unsigned(rs2)));
  
  
  
  


