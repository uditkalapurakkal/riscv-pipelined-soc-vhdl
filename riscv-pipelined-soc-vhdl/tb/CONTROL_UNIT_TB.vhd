library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity CONTROL_UNIT_TB is
 
end entity;

architecture behaviour of CONTROL_UNIT_TB is 

signal op_s : std_logic_vector(6 downto 0):= (others => '0');
signal reg_write_s, alu_src_s, branch_s, mem_write_s, memto_reg_s, funct7_5_s, pc_src_s, jump_s  : std_logic := '0' ;
signal  res_src_s : std_logic_vector(1 downto 0);
signal alu_cont_s, funct3_s, imm_src_s    : std_logic_vector(2 downto 0);
signal zero_s : std_logic := '0';

component CONTROL_UNIT is
port(
     op        : in std_logic_vector(6 downto 0);
     funct3    : in std_logic_vector(2 downto 0);
     funct7_5  : in std_logic ;
     zero      : in std_logic;
     pc_src    : out std_logic;
     res_src   : out std_logic_vector(1 downto 0);
     mem_write : out std_logic;
     alu_cont  : out std_logic_vector(2 downto 0);
     alu_src   : out std_logic ; 
     imm_src   : out std_logic_vector(2 downto 0);
     reg_write : out std_logic;
     branch    : out std_logic; 
     jump      : out std_logic );
     
end component;

begin
  dut: CONTROL_UNIT
  port map(
           op        => op_s,
           funct3    => funct3_s,
           funct7_5  => funct7_5_s,
           reg_write => reg_write_s,
           res_src   => res_src_s, 
           alu_src   => alu_src_s,
           branch    => branch_s,
           mem_write => mem_write_s,
           alu_cont  => alu_cont_s,
           imm_src   => imm_src_s,
           jump      => jump_s,
           pc_src    => pc_src_s,
           zero      => zero_s );

  cmb: process
  begin
    --r type add
    op_s     <= "0110011";
    funct3_s <= "000";
    funct7_5_s <= '0';
    wait for 20 ns ;
    --r type sub
    op_s     <= "0110011";
    funct3_s <= "000";
    funct7_5_s <= '1';
    wait for 20 ns ;
    --lw
    op_s    <= "0000011";
    funct3_s <= "000";
    funct7_5_s <= '0';
    wait for 20 ns ;
    --sw
    op_s    <= "0100011";
    funct3_s <= "000";
    funct7_5_s <= '0';
    wait for 20 ns ;
    --beq
    op_s    <= "1100011";
    funct3_s <= "000";
    funct7_5_s <= '0';
    zero_s <= '1';  -- equal ? branch taken
    wait for 20 ns ;
    zero_s <= '0';  -- not equal 
    wait for 20 ns ;
    --jal
    op_s    <= "1101111";
    funct3_s <= "000";
    funct7_5_s <= '0';
    wait for 20 ns ;
    wait ;
  end process;
end behaviour;
         


