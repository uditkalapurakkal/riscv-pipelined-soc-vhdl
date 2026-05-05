library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity ALU is
port(
     srca     : in std_logic_vector(31 downto 0);
     srcb     : in std_logic_vector(31 downto 0);
     alu_cont : in std_logic_vector(2 downto 0); 
     zero     : out std_logic ; 
     alu_res  : out std_logic_vector(31 downto 0)); 
     
end entity;

architecture behaviour of ALU is

--signal result : std_logic_vector(31 downto 0);
begin

  comb : process(alu_cont, srca, srcb)
  variable result : std_logic_vector(31 downto 0);
  begin

    CASE alu_cont is
      when "000" =>
        result := srca AND srcb;
      when "001" =>
        result := srca OR srcb;
      when "010" =>
        result := std_logic_vector(signed(srca) + signed(srcb));
      when "110" =>
        result := std_logic_vector(signed(srca) - signed(srcb));
      when "111" =>
        if (signed(srca) < signed(srcb)) then
          result := (0 => '1', others=> '0');
        else
          result := (others=> '0');      
        end if;
      when others =>
          result := (others=> '0');
     end case;
     alu_res <= result;
     if result = x"00000000" then
       zero <= '1';
     else
       zero <= '0';
     end if;
   end process;
   
end behaviour;
