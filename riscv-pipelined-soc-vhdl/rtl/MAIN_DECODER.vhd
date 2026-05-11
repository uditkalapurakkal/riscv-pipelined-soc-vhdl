library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity MAIN_DECODER is
port(
     op        : in std_logic_vector(6 downto 0);
     imm_src   : out std_logic_vector(2 downto 0);
     reg_write : out std_logic; 
     res_src   : out std_logic_vector(1 downto 0);
     alu_src   : out std_logic ; 
     branch    : out std_logic; 
     jump      : out std_logic;
     mem_write : out std_logic;
     alu_a_src : out std_logic_vector(1 downto 0);
     alu_op    : out std_logic_vector(1 downto 0));
     
end entity;

architecture behaviour of MAIN_DECODER is 

begin
  comb: process(op)
  begin
    alu_a_src <= "00"; -- default: ALU A = rs1
    case op is
      when "0110011" =>      --rtype
        reg_write  <= '1';
        imm_src    <= "000";
        alu_src    <= '0';
        mem_write  <= '0';
        res_src    <= "00";
        branch     <= '0';
        alu_op     <= "10";
        jump       <= '0';
      when "0000011" =>      --lw
        reg_write  <= '1';
        imm_src    <= "000";
        alu_src    <= '1';
        mem_write  <= '0';
        res_src    <= "01";
        branch     <= '0';
        alu_op     <= "00";
        jump       <= '0';
      when "0100011" =>      --sw
        reg_write  <= '0';
        imm_src    <= "001";
        alu_src    <= '1';
        mem_write  <= '1';
        res_src    <= "00";
        branch     <= '0';
        alu_op     <= "00";
        jump       <= '0';
      when "1100011" =>      --beq
        reg_write  <= '0';
        imm_src    <= "010";
        alu_src    <= '0';
        mem_write  <= '0';
        res_src    <= "00";
        branch     <= '1';
        alu_op     <= "01";
        jump       <= '0';
      when "0010011" =>      -- addi type alu
        reg_write  <= '1';
        imm_src    <= "000";
        alu_src    <= '1';   
        mem_write  <= '0';
        res_src    <= "00";
        branch     <= '0';
        alu_op     <= "10";  -- add operation ch
        jump       <= '0';
      when "1101111" =>      -- jal
        reg_write  <= '1';
        imm_src    <= "011";
        alu_src    <= '0';   -- use immediate not register
        mem_write  <= '0';
        res_src    <= "10";
        branch     <= '0';
        alu_op     <= "00";  -- add operation
        jump       <= '1';
      when "1100111" =>      -- jalr
        reg_write  <= '1';
        imm_src    <= "000";
        alu_src    <= '1';   -- use immediate not register
        alu_a_src  <= "00";
        mem_write  <= '0';
        res_src    <= "10";
        branch     <= '0';
        alu_op     <= "00";  -- add operation
        jump       <= '1';
      when "0110111" =>      -- lui
        reg_write  <= '1';
        imm_src    <= "100";
        alu_src    <= '1';   -- use immediate not register
        alu_a_src  <= "10";
        mem_write  <= '0';
        res_src    <= "00";
        branch     <= '0';
        alu_op     <= "00";  -- add operation
        jump       <= '0';
      when "0010111" =>      -- auipc
        reg_write  <= '1';
        imm_src    <= "100";
        alu_src    <= '1';   -- use immediate not register
        alu_a_src  <= "01";
        mem_write  <= '0';
        res_src    <= "00";
        branch     <= '0';
        alu_op     <= "00";  -- add operation
        jump       <= '0';
      when others =>
        reg_write  <= '0';
        imm_src    <= "000";
        alu_src    <= '0';
        branch     <= '0';
        mem_write  <= '0';
        res_src    <= "10";
        alu_op     <= "00";
        jump       <= '0';
      end case;
   end process;
   
end behaviour;
     
        
      
