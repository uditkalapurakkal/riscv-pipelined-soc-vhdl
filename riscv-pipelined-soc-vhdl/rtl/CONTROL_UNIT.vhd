library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity CONTROL_UNIT is
port(
     op        : in std_logic_vector(6 downto 0);
     funct3    : in std_logic_vector(2 downto 0);
     funct7_5  : in std_logic ;
     res_src   : out std_logic_vector(1 downto 0);
     mem_write : out std_logic;
     alu_cont  : out std_logic_vector(3 downto 0);
     alu_src   : out std_logic ; 
     imm_src   : out std_logic_vector(2 downto 0);
     reg_write : out std_logic;
     branch    : out std_logic; 
     alu_a_src : out std_logic_vector(1 downto 0);
     jump      : out std_logic );


     
end entity;

architecture behaviour of CONTROL_UNIT is 

signal branch_s, jump_s : std_logic;
signal alu_op_s         :std_logic_vector(1 downto 0);

--signal zero_s           : std_logic := '0';
component MAIN_DECODER is
port(
     op        : in std_logic_vector(6 downto 0);
     imm_src   : out std_logic_vector(2 downto 0);
     reg_write : out std_logic;
     res_src   : out std_logic_vector(1 downto 0);
     alu_src   : out std_logic ; 
     alu_a_src : out std_logic_vector(1 downto 0);
     branch    : out std_logic; 
     jump      : out std_logic;
     mem_write : out std_logic;
     alu_op    : out std_logic_vector(1 downto 0));
     
end component;

component ALU_DECODER is
port(
     funct3    : in std_logic_vector(2 downto 0);
     funct7_5  : in std_logic ;
     op5       : in std_logic ;
     alu_op    : in std_logic_vector(1 downto 0);
     alu_cont  : out std_logic_vector(3 downto 0));
     
end component;

begin

branch    <= branch_s;
jump      <= jump_s;


  main_d: MAIN_DECODER
    port map(
             op        => op,
             imm_src   => imm_src,
             reg_write => reg_write, 
             res_src   => res_src,
             alu_src   => alu_src,
             alu_a_src => alu_a_src,
             branch    => branch_s, --u
             jump      => jump_s,   --u after _s
             mem_write => mem_write,
             alu_op    => alu_op_s );
  
  alu_d: ALU_DECODER  
    port map(
             funct3    => funct3,
             funct7_5  => funct7_5,
             op5       => op(5),
             alu_op    => alu_op_s,
             alu_cont  => alu_cont);

end behaviour;
  
     
             
