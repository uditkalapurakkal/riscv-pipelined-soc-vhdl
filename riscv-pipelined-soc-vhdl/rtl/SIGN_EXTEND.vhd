library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity SIGN_EXTEND is
port(
     imm_src  : in std_logic_vector(2 downto 0);
     instr    : in std_logic_vector(31 downto 0);
     sign_imm : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of SIGN_EXTEND is

begin
  --sign_imm <= (15 downto 0 => imm(15))& imm;
  sign : process(imm_src, instr)
  begin
    case imm_src is
    when "000" => -- I TYPE
    sign_imm <= (19 downto 0 => instr(31))& instr(31 downto 20);
    when "001" => -- S TYPE
    sign_imm <= (19 downto 0 => instr(31))& instr(31 downto 25)& instr(11 downto 7);
    when "010" => -- B TYPE
    sign_imm <= (19 downto 0 => instr(31))& instr(7)&  instr(30 downto 25) & instr(11 downto 8)& '0';
    when "011" => -- J TYPE
    sign_imm <=  (11 downto 0 => instr(31))& instr(19 downto 12)& instr(20) & instr(30 downto 21)& '0';
    when "100" => -- U TYPE
    sign_imm <=  instr(31 downto 12)& x"000" ;
    when others =>
    sign_imm <= (others => '0');
    end case;
  end process;
end behaviour; 