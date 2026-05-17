library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_mem is
port(
     clk,rst     : in std_logic;

--CONTROL UNIT
     res_src_e   : in std_logic_vector(1 downto 0);
     mem_write_e : in std_logic;
     reg_write_e : in std_logic;
     valid_e     : in  std_logic;
     funct3_e    : in std_logic_vector(2 downto 0);
     funct3_m    : out std_logic_vector(2 downto 0);
     valid_m     : out std_logic;
     res_src_m   : out std_logic_vector(1 downto 0);
     mem_write_m : out std_logic; 
     reg_write_m : out std_logic;
--misalignment
     mem_misaligned_e : in  std_logic;
     mem_misaligned_m : out std_logic; 
--DATA
     rd_e        : in std_logic_vector(4 downto 0);
     pc_plus_4_e : in std_logic_vector(31 downto 0);
     alu_res_e   : in std_logic_vector(31 downto 0);
     write_data_e: in std_logic_vector(31 downto 0);
     rd_m        : out std_logic_vector(4 downto 0);
     pc_plus_4_m : out std_logic_vector(31 downto 0);
     alu_res_m   : out std_logic_vector(31 downto 0);
     write_data_m: out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of ex_mem is

begin

reg:process(clk)
begin

if rising_edge(clk) then

if rst = '1' then

--CONTROL
  res_src_m    <= "00";
  mem_write_m  <= '0';
  reg_write_m  <= '0';
  valid_m      <= '0';
  funct3_m     <= (others => '0');
  mem_misaligned_m <= '0';
--DATA
  rd_m         <= (others => '0');
  pc_plus_4_m  <= (others => '0');
  alu_res_m    <= (others => '0');
  write_data_m <= (others => '0');

else

--CONTROL
  res_src_m    <= res_src_e;
  mem_write_m  <= mem_write_e;
  reg_write_m  <= reg_write_e;
  valid_m      <= valid_e;
  funct3_m     <= funct3_e;
  mem_misaligned_m <= mem_misaligned_e;
--DATA
  rd_m         <= rd_e;
  pc_plus_4_m  <= pc_plus_4_e;
  alu_res_m    <= alu_res_e;
  write_data_m <= write_data_e;

end if;
end if;
end process;
end behaviour;

