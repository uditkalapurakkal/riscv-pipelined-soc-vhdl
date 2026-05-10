library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity ALU_DECODER is
port(
     funct3    : in std_logic_vector(2 downto 0);
     funct7_5  : in std_logic ;
     op5       : in std_logic ;
     alu_op    : in std_logic_vector(1 downto 0);
     alu_cont  : out std_logic_vector(3 downto 0));
     
end entity;

architecture behaviour of ALU_DECODER is 

begin
  cmb:process(funct3, funct7_5, op5, alu_op)
  begin
    case alu_op is
      when "00" =>
        alu_cont <= "0010"; --add--lw,sw000
      when "01" =>
        alu_cont <= "0110"; --sub--beq001
      when "10" =>             --look at func
        case funct3 is
          when "000" =>
            if(op5 = '1' and funct7_5 = '1') then
              alu_cont <= "0110"; --sub
            else
              alu_cont <= "0010"; --add
            end if;
          when "001" =>
            alu_cont <= "0100"; --sll
          when "010" =>
            alu_cont <= "0111"; --slt
          when "011" =>
            alu_cont <= "1000"; --sltu
          when "100" =>
            alu_cont <= "0011"; --xor
          when "101" =>
            if(funct7_5 = '0') then
              alu_cont <= "0101"; --srl
            else
              alu_cont <= "1001"; --sra
            end if;
          when "110" =>
            alu_cont <= "0001"; --or
          when "111" =>
            alu_cont <= "0000"; --and
          when others =>      --default for funct3
            alu_cont <= "0010"; --add
          end case;
            
      when others =>      --default for alu_op
        alu_cont <= "0010"; --add
      end case;
  end process;
end behaviour;



