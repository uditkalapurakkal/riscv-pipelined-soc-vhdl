library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_wb is
port(
     clk, rst    : in std_logic;
--CONTROL UNIT
     res_src_m   : in std_logic_vector(1 downto 0);
     reg_write_m : in std_logic;
     valid_m     : in  std_logic;
     funct3_m    : in std_logic_vector(2 downto 0);
     funct3_w    : out std_logic_vector(2 downto 0);
     valid_w     : out std_logic;
     res_src_w   : out std_logic_vector(1 downto 0); 
     reg_write_w : out std_logic;
--DATA
     rd_m        : in std_logic_vector(4 downto 0);
     pc_plus_4_m : in std_logic_vector(31 downto 0);
     alu_res_m   : in std_logic_vector(31 downto 0);
     read_data_m : in std_logic_vector(31 downto 0);
     
     read_data_w : out std_logic_vector(31 downto 0); 
     rd_w        : out std_logic_vector(4 downto 0);
     pc_plus_4_w : out std_logic_vector(31 downto 0);
     alu_res_w   : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of mem_wb is

begin

reg:process(clk)
begin

if rising_edge(clk) then

if rst = '1' then

--CONTROL
  res_src_w    <= "00";
  reg_write_w  <= '0' ;
  funct3_w     <= (others => '0');
--DATA
  read_data_w  <= (others => '0');
  rd_w         <= (others => '0');
  pc_plus_4_w  <= (others => '0');
  alu_res_w    <= (others => '0');
  valid_w <= '0';

else

--CONTROL
  res_src_w    <= res_src_m;
  reg_write_w  <= reg_write_m;
  valid_w      <= valid_m;
  funct3_w     <= funct3_m;
--DATA
  read_data_w  <= read_data_m;
  rd_w         <= rd_m;
  pc_plus_4_w  <= pc_plus_4_m;
  alu_res_w    <= alu_res_m;
  

end if;    
end if;
end process;
end behaviour;
