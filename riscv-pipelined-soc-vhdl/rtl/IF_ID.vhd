library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is
port(
     clk, rst           : in std_logic;
     flush              : in std_logic;
     stall              : in std_logic;
     instr_f            : in std_logic_vector(31 downto 0);
     pc_f               : in std_logic_vector(31 downto 0);
     pc_plus_4_f        : in std_logic_vector(31 downto 0);
     valid_f            : in  std_logic;
     predicted_taken_f  : in  std_logic;
     predicted_target_f : in  std_logic_vector(31 downto 0);

     predicted_taken_d  : out std_logic;
     predicted_target_d : out std_logic_vector(31 downto 0);
     valid_d            : out std_logic;
     instr_d            : out std_logic_vector(31 downto 0);
     pc_d               : out std_logic_vector(31 downto 0);
     pc_plus_4_d        : out std_logic_vector(31 downto 0));
end entity;

architecture behaviour of if_id is

begin

reg:process(clk)
begin

  if rising_edge(clk) then

  if rst = '1' then
    instr_d            <= x"00000013"; --NOP
    pc_d               <= (others => '0');
    pc_plus_4_d        <= (others => '0');   
    valid_d            <= '0';
    predicted_taken_d  <= '0';
    predicted_target_d <= (others => '0');

  elsif flush = '1' then
    instr_d            <= x"00000013"; --NOP
    pc_d               <= (others => '0');
    pc_plus_4_d        <= (others => '0');   
    valid_d            <= '0';
    predicted_taken_d  <= '0';
    predicted_target_d <= (others => '0');

  elsif stall = '0' then
    instr_d            <= instr_f;
    pc_d               <= pc_f;
    pc_plus_4_d        <= pc_plus_4_f;
    valid_d            <= valid_f;
    predicted_taken_d  <= predicted_taken_f;
    predicted_target_d <= predicted_target_f;
  end if;
end if;

end process;
end behaviour;

