library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity SIGN_EXTEND_TB is

end entity;

architecture behaviour of SIGN_EXTEND_TB is

component SIGN_EXTEND is
port(
     imm      : in std_logic_vector(15 downto 0);
     sign_imm : out std_logic_vector(31 downto 0));

end component;

signal imm_s      : std_logic_vector(15 downto 0);
signal sign_imm_s : std_logic_vector(31 downto 0);


begin

  dut: SIGN_EXTEND
  port map( 
           imm      => imm_s,
           sign_imm => sign_imm_s);

  cmb:process
  begin
  imm_s <= x"0001";
  wait for 20 ns ;
  imm_s <= x"1001";
  wait for 20 ns ;

  wait;
  end process;

end behaviour; 
