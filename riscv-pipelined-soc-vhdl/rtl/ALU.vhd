library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity ALU is
port(
     srca     : in std_logic_vector(31 downto 0);
     srcb     : in std_logic_vector(31 downto 0);
     alu_cont : in std_logic_vector(3 downto 0); 
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
      when "0000" =>  --and
        result := srca AND srcb; 
      when "0001" =>  --or
        result := srca OR srcb;
      when "0010" =>  --add
        result := std_logic_vector(signed(srca) + signed(srcb));
      when "0110" =>  --sub
        result := std_logic_vector(signed(srca) - signed(srcb));
      when "0011" =>  --xor
        result := srca xor srcb;
      when "0100" =>  --sll
        result := std_logic_vector(shift_left(unsigned(srca), to_integer(unsigned(srcb(4 downto 0)))));
      when "0101" => --srl
        result := std_logic_vector(shift_right(unsigned(srca), to_integer(unsigned(srcb(4 downto 0)))));
      when "1000" => --sltu
        if (unsigned(srca) < unsigned(srcb)) then
          result := (0 => '1', others => '0');
        else
          result := (others => '0');
        end if;
      when "0111" =>  --slt
        if (signed(srca) < signed(srcb)) then
          result := (0 => '1', others=> '0');
        else
          result := (others=> '0');      
        end if;
      when "1001" => --sra
        result := std_logic_vector(shift_right(signed(srca), to_integer(unsigned(srcb(4 downto 0)))));
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
