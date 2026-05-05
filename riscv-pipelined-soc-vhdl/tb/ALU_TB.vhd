library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC
entity ALU_TB is

end entity;

architecture behaviour of ALU_TB is

component ALU is
port(
     srca     : in std_logic_vector(31 downto 0);
     srcb     : in std_logic_vector(31 downto 0);
     alu_cont : in std_logic_vector(2 downto 0); 
     zero     : out std_logic ; 
     alu_res  : out std_logic_vector(31 downto 0)); 
end component;

signal srca_s, srcb_s : std_logic_vector(31 downto 0) := (others => '0');
signal alu_res_s      : std_logic_vector(31 downto 0);
signal zero_s         : std_logic ;
signal alu_cont_s     : std_logic_vector(2 downto 0);

begin
  dut: ALU
  port map (
            srca      => srca_s,
            srcb      => srcb_s,
            alu_cont   => alu_cont_s,
            zero      => zero_s,
            alu_res   => alu_res_s);

  

  stimuli: process
  begin
    wait for 10 ns ;
    --add
    srca_s     <= x"00000001"; --1
    srcb_s     <= x"00000002"; --2
    alu_cont_s <= "000" ;
    wait for 20 ns ;
    --sub
    srca_s     <= x"00000001"; --1
    srcb_s     <= x"00000002"; --2
    alu_cont_s <= "001" ;
    wait for 20 ns ;
    --and
    srca_s     <= x"00000001"; --1
    srcb_s     <= x"00000001"; --1
    alu_cont_s <= "010" ;
    wait for 20 ns ;
    --or
    srca_s     <= x"00000001"; --1
    srcb_s     <= x"00000003"; --3
    alu_cont_s <= "011" ;
    wait for 20 ns ;
    --slt
    srca_s     <= x"00000003"; --3
    srcb_s     <= x"00000001" ;--1
    alu_cont_s <= "100" ;
    wait for 20 ns ;
    --other
    srca_s     <= x"00000001";
    srcb_s     <= x"00000001" ;
    alu_cont_s <= "111" ;
    wait ;
  end process;
end behaviour;
 
    
    
  
