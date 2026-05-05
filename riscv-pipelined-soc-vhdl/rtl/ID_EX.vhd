library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is
port(
     clk,rst     : in std_logic;
     flush       : in std_logic;
--CONTROL UNIT
     res_src_d   : in std_logic_vector(1 downto 0);
     mem_write_d : in std_logic;
     alu_cont_d  : in std_logic_vector(2 downto 0);
     alu_src_d   : in std_logic ; 
     reg_write_d : in std_logic;
     branch_d    : in std_logic; 
     jump_d      : in std_logic;
     valid_d     : in  std_logic;

     valid_e     : out std_logic;
     res_src_e   : out std_logic_vector(1 downto 0);
     mem_write_e : out std_logic;
     alu_cont_e  : out std_logic_vector(2 downto 0);
     alu_src_e   : out std_logic ; 
     reg_write_e : out std_logic;
     branch_e    : out std_logic; 
     jump_e      : out std_logic;
--Branch predictor pipeline signals
     predicted_taken_d  : in  std_logic;
     predicted_target_d : in  std_logic_vector(31 downto 0);
     predicted_taken_e  : out std_logic;
     predicted_target_e : out std_logic_vector(31 downto 0);
--DATA
     rd1_d       : in std_logic_vector(31 downto 0);
     rd2_d       : in std_logic_vector(31 downto 0);
     ra1_d       : in std_logic_vector(4 downto 0);
     ra2_d       : in std_logic_vector(4 downto 0);
     rd_d        : in std_logic_vector(4 downto 0);
     sign_imm_d  : in std_logic_vector(31 downto 0);
     pc_d        : in std_logic_vector(31 downto 0);
     pc_plus_4_d : in std_logic_vector(31 downto 0);

     rd1_e       : out std_logic_vector(31 downto 0);
     rd2_e       : out std_logic_vector(31 downto 0);
     ra1_e       : out std_logic_vector(4 downto 0);
     ra2_e       : out std_logic_vector(4 downto 0);
     rd_e        : out std_logic_vector(4 downto 0);
     sign_imm_e  : out std_logic_vector(31 downto 0);
     pc_plus_4_e : out std_logic_vector(31 downto 0);
     pc_e        : out std_logic_vector(31 downto 0));
end entity;

architecture behaviour of id_ex is

begin

reg:process(clk)
begin

  if rising_edge(clk) then

  if rst = '1' then
--CONTROL
    res_src_e   <= "00";
    mem_write_e <= '0';
    alu_cont_e  <= "000";
    alu_src_e   <= '0'; 
    reg_write_e <= '0';
    branch_e    <= '0'; 
    jump_e      <= '0';
    valid_e     <= '0';
--DATA
    rd1_e       <= (others => '0');
    rd2_e       <= (others => '0');
    ra1_e       <= (others => '0');
    ra2_e       <= (others => '0');
    rd_e        <= (others => '0');
    sign_imm_e  <= (others => '0');
    pc_plus_4_e <= (others => '0');
    pc_e        <= (others => '0');  

    predicted_taken_e  <= '0';
    predicted_target_e <= (others => '0');

  elsif flush = '1' then
--CONTROL
    res_src_e   <= "00";
    mem_write_e <= '0';
    alu_cont_e  <= "000";
    alu_src_e   <= '0'; 
    reg_write_e <= '0';
    branch_e    <= '0'; 
    jump_e      <= '0';
    valid_e     <= '0';
--DATA
    rd1_e       <= (others => '0');
    rd2_e       <= (others => '0');
    ra1_e       <= (others => '0');
    ra2_e       <= (others => '0');
    rd_e        <= (others => '0');
    sign_imm_e  <= (others => '0');
    pc_plus_4_e <= (others => '0');
    pc_e        <= (others => '0');
  
    predicted_taken_e  <= '0';
    predicted_target_e <= (others => '0');

  else
    res_src_e   <= res_src_d;
    mem_write_e <= mem_write_d;
    alu_cont_e  <= alu_cont_d;
    alu_src_e   <= alu_src_d; 
    reg_write_e <= reg_write_d;
    branch_e    <= branch_d;
    jump_e      <= jump_d;
    valid_e     <= valid_d;
    rd1_e       <= rd1_d;
    rd2_e       <= rd2_d;
    ra1_e       <= ra1_d;
    ra2_e       <= ra2_d;
    rd_e        <= rd_d;
    sign_imm_e  <= sign_imm_d;
    pc_plus_4_e <= pc_plus_4_d;
    pc_e        <= pc_d;

   predicted_taken_e  <= predicted_taken_d;
   predicted_target_e <= predicted_target_d;
  end if;
end if;
end process;
end behaviour;

