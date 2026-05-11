library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity top is
port(
     clk          : in std_logic;
     rst          : in std_logic;
     gpio_out     : out std_logic_vector(7 downto 0);
---debug
     valid_w_dbg  : out std_logic;
     stall_f_dbg  : out std_logic;
     stall_d_dbg  : out std_logic;
     flush_d_dbg  : out std_logic;
     flush_e_dbg  : out std_logic;
     branch_e_dbg : out std_logic;
     jump_e_dbg   : out std_logic);
end entity;

architecture behaviour of top is

--BUS
signal dmem_we : std_logic;
--BRANCH PREDICTOR
signal branch_prediction_enable : std_logic := '1';

signal predict_taken_f    : std_logic;
signal actual_taken_e     : std_logic;
signal predictor_update_e : std_logic;
signal bp_counter_f       : std_logic_vector(1 downto 0);

signal predicted_target_f : std_logic_vector(31 downto 0);
signal btb_valid_f        : std_logic;


--Branch predictor pipeline signals
signal predicted_taken_d  : std_logic;
signal predicted_taken_e  : std_logic;

signal predicted_target_d : std_logic_vector(31 downto 0);
signal predicted_target_e : std_logic_vector(31 downto 0);

signal target_mismatch_e : std_logic;
signal taken_mismatch_e  : std_logic;
signal mispredict_e      : std_logic;
signal correct_pc_e      : std_logic_vector(31 downto 0);
--VALID 
signal valid_f        : std_logic;
signal valid_d        : std_logic;
signal valid_e        : std_logic;
signal valid_m        : std_logic;
signal valid_w        : std_logic;
signal reg_write_real : std_logic;
signal mem_write_real : std_logic;
--reset sync
signal rst_sync1      : std_logic := '1';
signal rst_sync2      : std_logic := '1';
signal rst_local      : std_logic;
--program counter
signal pc         : std_logic_vector(31 downto 0);
signal pc_next    : std_logic_vector(31 downto 0);
signal pc_plus_4  : std_logic_vector(31 downto 0);

--instruction memory
signal instr      : std_logic_vector(31 downto 0);
--register file
--signal rd1, rd2   : std_logic_vector(31 downto 0);
--signal ra1,ra2,rd : std_logic_vector(4 downto 0);
--signal write_reg: std_logic_vector(4 downto 0);
signal result_w   : std_logic_vector(31 downto 0);
--alu
signal srca_e      : std_logic_vector(31 downto 0);
signal srcb_e      : std_logic_vector(31 downto 0);
--signal srcb       : std_logic_vector(31 downto 0);
signal zero_e     : std_logic ; 
--signal alu_res    : std_logic_vector(31 downto 0);
--data memory
--signal read_data  : std_logic_vector(31 downto 0);
--sign extend
--signal sign_imm   : std_logic_vector(31 downto 0);
--control unit
--signal reg_write, jump, alu_src, branch, mem_write, funct7_5  : std_logic ;
signal funct7_5   : std_logic ;
--signal res_src    : std_logic_vector(1 downto 0);
--signal alu_cont   : std_logic_vector(2 downto 0);
signal imm_src    : std_logic_vector(2 downto 0);
signal op         : std_logic_vector(6 downto 0);
signal funct3     : std_logic_vector(2 downto 0);

--PIPELINE
signal pc_target_e :  std_logic_vector(31 downto 0);
signal pc_src_e    :  std_logic;
--if_id
--signal flush       :  std_logic;
--signal stall       :  std_logic;
--signal instr_f     :  std_logic_vector(31 downto 0);
--signal pc_f        :  std_logic_vector(31 downto 0);
--signal pc_plus_4_f :  std_logic_vector(31 downto 0);
signal instr_d     :  std_logic_vector(31 downto 0);
signal pc_d        :  std_logic_vector(31 downto 0);
signal pc_plus_4_d :  std_logic_vector(31 downto 0);
--id_ex control
signal res_src_d, res_src_e     : std_logic_vector(1 downto 0);
signal mem_write_d, mem_write_e : std_logic;
signal alu_cont_d, alu_cont_e   : std_logic_vector(3 downto 0);
signal alu_src_d, alu_src_e     : std_logic ; 
signal reg_write_d, reg_write_e : std_logic;
signal branch_d, branch_e       : std_logic; 
signal jump_d, jump_e           : std_logic;
signal funct3_d, funct3_e       : std_logic_vector(2 downto 0);
signal branch_taken_e           : std_logic;
--id_ex data
signal rd1_d, rd2_d, rd1_e, rd2_e             : std_logic_vector(31 downto 0);
signal ra1_d, ra2_d, rd_d, ra1_e, ra2_e, rd_e : std_logic_vector(4 downto 0);
signal sign_imm_d                             : std_logic_vector(31 downto 0);
signal sign_imm_e ,pc_e, pc_plus_4_e          : std_logic_vector(31 downto 0);
--ex_mem control
signal res_src_m   : std_logic_vector(1 downto 0);
signal mem_write_m : std_logic;
signal reg_write_m : std_logic;
--ex_mem data
signal rd_m                              : std_logic_vector(4 downto 0);
signal pc_plus_4_m, alu_res_e, alu_res_m : std_logic_vector(31 downto 0);
signal write_data_e, write_data_m        : std_logic_vector(31 downto 0);
--mem_wb control
signal res_src_w              : std_logic_vector(1 downto 0);
signal reg_write_w            : std_logic;
--mem_wb data
signal read_data_w,read_data_m: std_logic_vector(31 downto 0); 
signal rd_w                   : std_logic_vector(4 downto 0);
signal pc_plus_4_w, alu_res_w : std_logic_vector(31 downto 0);
--hazard
signal stall_f, stall_d       : std_logic;
signal flush_d, flush_e       : std_logic;
signal forward_ae             : std_logic_vector(1 downto 0);
signal forward_be             : std_logic_vector(1 downto 0);
--
signal alu_a_src_d, alu_a_src_e : std_logic_vector(1 downto 0);
signal alu_input_a_e            : std_logic_vector(31 downto 0);
signal jalr_target_e            : std_logic_vector(31 downto 0);
signal jalr_d                   : std_logic;
signal jalr_e                   : std_logic;

component program_counter is
port(
     clk     : in std_logic;
     rst     : in std_logic;
     pc_next : in std_logic_vector(31 downto 0);
     stall   : in std_logic; 
     pc      : out std_logic_vector(31 downto 0));
end component;

component instruction_memory is
port(
     address  : in std_logic_vector(31 downto 0);
     instr    : out std_logic_vector(31 downto 0));

end component;

component register_file is
port(
     clk      : in std_logic;
     we3      : in std_logic;
     ra1, ra2 : in std_logic_vector(4 downto 0); --read address rd = rs1 +rs2
     rd       : in std_logic_vector(4 downto 0); -- write address
     wd3       : in std_logic_vector(31 downto 0); --data to write
     rd1, rd2 : out std_logic_vector(31 downto 0));

end component;

component sign_extend is
port(
     imm_src  : in std_logic_vector(2 downto 0);
     instr    : in std_logic_vector(31 downto 0);
     sign_imm : out std_logic_vector(31 downto 0));

end component;

component alu is
port(
     srca     : in std_logic_vector(31 downto 0);
     srcb     : in std_logic_vector(31 downto 0);
     alu_cont : in std_logic_vector(3 downto 0); 
     zero     : out std_logic ; 
     alu_res  : out std_logic_vector(31 downto 0)); 
     
end component;

component data_memory is
port(
     clk : in std_logic;
     we  : in std_logic;
     a   : in std_logic_vector(31 downto 0);
     wd  : in std_logic_vector(31 downto 0);
     rd  : out std_logic_vector(31 downto 0));

end component;

component mux is
generic (width : integer := 32);
port(
     d0   : in std_logic_vector(width-1 downto 0);
     d1   : in std_logic_vector(width-1 downto 0);
     sel  : in std_logic;
     y    : out std_logic_vector(width-1 downto 0));
end component;

component mux3 is
generic (width : integer := 32);
port(
     d0   : in std_logic_vector(width-1 downto 0);
     d1   : in std_logic_vector(width-1 downto 0);
     d2   : in std_logic_vector(width-1 downto 0);
     sel  : in std_logic_vector(1 downto 0);
     y    : out std_logic_vector(width-1 downto 0));
end component;

component control_unit is
port(
     op        : in std_logic_vector(6 downto 0);
     funct3    : in std_logic_vector(2 downto 0);
     funct7_5  : in std_logic ;
     res_src   : out std_logic_vector(1 downto 0);
     mem_write : out std_logic;
     alu_cont  : out std_logic_vector(3 downto 0);
     alu_src   : out std_logic ; 
     alu_a_src : out std_logic_vector(1 downto 0);
     imm_src   : out std_logic_vector(2 downto 0);
     reg_write : out std_logic;
     branch    : out std_logic; 
     jump      : out std_logic );
     
end component;

component HAZARD_UNIT is
port(
     ra1_d      : in std_logic_vector(4 downto 0);
     ra2_d      : in std_logic_vector(4 downto 0);
     ra1_e      : in std_logic_vector(4 downto 0);
     ra2_e      : in std_logic_vector(4 downto 0);
     rd_e       : in std_logic_vector(4 downto 0);
     rd_m       : in std_logic_vector(4 downto 0);
     rd_w       : in std_logic_vector(4 downto 0);
     pc_src_e   : in std_logic;
     res_src_e  : in std_logic_vector(1 downto 0);
     reg_write_m: in std_logic;
     reg_write_w: in std_logic;
     stall_f    : out std_logic;
     stall_d    : out std_logic;
     flush_d    : out std_logic;
     flush_e    : out std_logic;
     forward_ae : out std_logic_vector(1 downto 0);
     forward_be : out std_logic_vector(1 downto 0));

end component;

component if_id is
port(
     clk,rst     : in std_logic;
     flush       : in std_logic;
     stall       : in std_logic;
     instr_f     : in std_logic_vector(31 downto 0);
     pc_f        : in std_logic_vector(31 downto 0);
     pc_plus_4_f : in std_logic_vector(31 downto 0); 
     valid_f     : in  std_logic;
     valid_d     : out std_logic;
     instr_d     : out std_logic_vector(31 downto 0);
     pc_d        : out std_logic_vector(31 downto 0);
     pc_plus_4_d : out std_logic_vector(31 downto 0);
     predicted_taken_f  : in  std_logic;
     predicted_target_f : in  std_logic_vector(31 downto 0);

     predicted_taken_d  : out std_logic;
     predicted_target_d : out std_logic_vector(31 downto 0));
end component;

component id_ex is
port(
     clk, rst    : in std_logic;
     flush       : in std_logic;
--CONTROL UNIT
     res_src_d   : in std_logic_vector(1 downto 0);
     mem_write_d : in std_logic;
     alu_cont_d  : in std_logic_vector(3 downto 0);
     alu_src_d   : in std_logic ; 
     reg_write_d : in std_logic;
     branch_d    : in std_logic; 
     jump_d      : in std_logic;
     valid_d     : in  std_logic;
     funct3_d    : in  std_logic_vector(2 downto 0);
     alu_a_src_d : in  std_logic_vector(1 downto 0);
     alu_a_src_e : out std_logic_vector(1 downto 0);
     funct3_e    : out std_logic_vector(2 downto 0);
     valid_e     : out std_logic;
     res_src_e   : out std_logic_vector(1 downto 0);
     mem_write_e : out std_logic;
     alu_cont_e  : out std_logic_vector(3 downto 0);
     alu_src_e   : out std_logic ; 
     reg_write_e : out std_logic;
     branch_e    : out std_logic; 
     jump_e      : out std_logic;
--jalr
     jalr_d      : in  std_logic;
     jalr_e      : out std_logic;
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
     pc_e        : out std_logic_vector(31 downto 0);
--Branch predictor pipeline signals
     predicted_taken_d  : in  std_logic;
     predicted_target_d : in  std_logic_vector(31 downto 0);
     predicted_taken_e  : out std_logic;
     predicted_target_e : out std_logic_vector(31 downto 0));
end component;

component ex_mem is
port(
     clk, rst    : in std_logic;

--CONTROL UNIT
     res_src_e   : in std_logic_vector(1 downto 0);
     mem_write_e : in std_logic;
     reg_write_e : in std_logic;
     valid_e     : in  std_logic;
     valid_m     : out std_logic;
     res_src_m   : out std_logic_vector(1 downto 0);
     mem_write_m : out std_logic; 
     reg_write_m : out std_logic;
--DATA
     rd_e        : in std_logic_vector(4 downto 0);
     pc_plus_4_e : in std_logic_vector(31 downto 0);
     alu_res_e   : in std_logic_vector(31 downto 0);
     write_data_e: in std_logic_vector(31 downto 0);
     rd_m        : out std_logic_vector(4 downto 0);
     pc_plus_4_m : out std_logic_vector(31 downto 0);
     alu_res_m   : out std_logic_vector(31 downto 0);
     write_data_m: out std_logic_vector(31 downto 0));
end component;

component mem_wb is
port(
     clk, rst    : in std_logic;
--CONTROL UNIT
     res_src_m   : in std_logic_vector(1 downto 0);
     reg_write_m : in std_logic;
     valid_m     : in  std_logic;
     valid_w     : out std_logic;
     res_src_w   : out std_logic_vector(1 downto 0); 
     reg_write_w : out std_logic;
--DATA
     rd_m        : in std_logic_vector(4 downto 0);
     pc_plus_4_m : in std_logic_vector(31 downto 0);
     alu_res_m   : in std_logic_vector(31 downto 0);
     read_data_m : in std_logic_vector(31 downto 0);
     
     read_data_w : out std_logic_vector(31 downto 0); 
     rd_w        : out std_logic_vector(4 downto 0);
     pc_plus_4_w : out std_logic_vector(31 downto 0);
     alu_res_w   : out std_logic_vector(31 downto 0));

end component;

component BRANCH_PRED is
port(
     clk, rst           : in std_logic;
     pc_f, pc_e         : in std_logic_vector(31 downto 0); 
     actual_taken_e     : in  std_logic;

     update_en_e        : in  std_logic;
     predict_taken_f    : out std_logic;
     debug_counter_f    : out std_logic_vector(1 downto 0);

     predicted_target_f : out std_logic_vector(31 downto 0);
     btb_valid_f        : out std_logic;
     actual_target_e    : in  std_logic_vector(31 downto 0)
);
end component;

component BUS_M is
port(
    clk        : in  std_logic;
    rst        : in  std_logic;
    mem_we     : in  std_logic;
    addr       : in  std_logic_vector(31 downto 0);
    write_data : in  std_logic_vector(31 downto 0);
    dmem_we    : out std_logic;
    gpio_out   : out std_logic_vector(7 downto 0)
);
end component;

begin

  funct3_d <= instr_d(14 downto 12);
  valid_f   <= '1';
  pc_plus_4 <= std_logic_vector(unsigned(pc)+4);
  pc_target_e <= std_logic_vector(unsigned(pc_e) + unsigned(sign_imm_e));
--  pc_src_e  <= (branch_e and zero_e) or jump_e; without valid sig
--  pc_src_e <= valid_e and ((branch_e and zero_e) or jump_e); without predictor
  reg_write_real <= valid_w and reg_write_w;
  mem_write_real <= valid_m and mem_write_m;
--  pc_src_e <= mispredict_e or (valid_e and jump_e);
  pc_src_e <= (branch_prediction_enable and mispredict_e) or
            ((not branch_prediction_enable) and valid_e and branch_e and branch_taken_e) or
            (valid_e and jump_e);
--branch
taken_mismatch_e <= predicted_taken_e xor actual_taken_e;

target_mismatch_e <= '1' when
    valid_e = '1' and branch_e = '1' and
    predicted_taken_e = '1' and actual_taken_e = '1' and
    predicted_target_e /= pc_target_e
else '0';

correct_pc_e <= pc_target_e when actual_taken_e = '1' else pc_plus_4_e;

mispredict_e <= branch_prediction_enable and valid_e and branch_e and
                (taken_mismatch_e or target_mismatch_e);

process(branch_prediction_enable, mispredict_e, correct_pc_e,
        valid_e, jump_e, branch_e, branch_taken_e,
        pc_target_e, predict_taken_f, predicted_target_f, pc_plus_4)
begin
  if branch_prediction_enable = '1' then
-- Predictor ON
    if mispredict_e = '1' then
      pc_next <= correct_pc_e;

    elsif valid_e = '1' and jump_e = '1' and jalr_e = '1' then
      pc_next <= jalr_target_e;

    elsif valid_e = '1' and jump_e = '1' then
      pc_next <= pc_target_e;

    elsif predict_taken_f = '1' then
      pc_next <= predicted_target_f;

    else
      pc_next <= pc_plus_4;
    end if;

  else
    -- Predictor OFF: old baseline behavior
    if valid_e = '1' and (((branch_e = '1') and (branch_taken_e = '1')) or jump_e = '1') then
      pc_next <= pc_target_e;

    else
      pc_next <= pc_plus_4;
    end if;

  end if;
end process;

--reset sync  
process(clk, rst)
begin
  if rst = '1' then
    rst_sync1 <= '1';
    rst_sync2 <= '1';
  elsif rising_edge(clk) then
    rst_sync1 <= '0';
    rst_sync2 <= rst_sync1;
  end if;
end process;

    rst_local <= rst_sync2;

--branch compare
branch_compare_proc : process(funct3_e, srca_e, write_data_e)
begin
    case funct3_e is
        when "000" => -- BEQ
            if srca_e = write_data_e then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when "001" => -- BNE
            if srca_e /= write_data_e then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when "100" => -- BLT
            if signed(srca_e) < signed(write_data_e) then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when "101" => -- BGE
            if signed(srca_e) >= signed(write_data_e) then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when "110" => -- BLTU
            if unsigned(srca_e) < unsigned(write_data_e) then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when "111" => -- BGEU
            if unsigned(srca_e) >= unsigned(write_data_e) then
                branch_taken_e <= '1';
            else
                branch_taken_e <= '0';
            end if;

        when others =>
            branch_taken_e <= '0';
    end case;
end process;
--BRANCH PREDICTOR
actual_taken_e <= valid_e and branch_e and branch_taken_e;
predictor_update_e <= valid_e and branch_e;
   
--debug 
  valid_w_dbg <= valid_w;
  stall_f_dbg <= stall_f;
  stall_d_dbg <= stall_d;
  flush_d_dbg <= flush_d;
  flush_e_dbg <= flush_e;
  branch_e_dbg <= branch_e;
  jump_e_dbg <= jump_e;

   op       <= instr_d(6 downto 0);
   funct3   <= instr_d(14 downto 12);
   funct7_5 <= instr_d(30);
   ra1_d    <= instr_d(19 downto 15);
   ra2_d    <= instr_d(24 downto 20);
   rd_d     <= instr_d(11 downto 7);
   jalr_d   <= '1' when op = "1100111" else '0';
   jalr_target_e <= alu_res_e(31 downto 1) & '0';

  pc_reg : program_counter
  port map(
           clk     => clk,
           rst     => rst_local,
           pc_next => pc_next,
           stall   => stall_f, 
           pc      => pc);

  imem : instruction_memory
  port map (
            address => pc,
            instr   => instr);

  rf : register_file
  port map(
           clk => clk,
           we3 => reg_write_real,
           ra1 => ra1_d,
           ra2 => ra2_d,
           rd  => rd_w,
           wd3 => result_w,
           rd1 => rd1_d,
           rd2 => rd2_d);  

  se : sign_extend
  port map( 
           imm_src  => imm_src,
           instr    => instr_d,
           sign_imm => sign_imm_d);

  alu_unit : alu
  port map (
            srca      => alu_input_a_e,
            srcb      => srcb_e,
            alu_cont  => alu_cont_e,
            zero      => zero_e,
            alu_res   => alu_res_e);

  dmem : data_memory
  port map(
           clk => clk,
           we  => dmem_we,
           a   => alu_res_m,
           wd  => write_data_m,
           rd  => read_data_m);


--  mux_pcsrc : mux
 -- generic map (width => 32)
 -- port map(
 --          d0  => pc_plus_4,
  --         d1  => pc_target_e,
  --         sel => pc_src_e,
  --         y   => pc_next);
 
  mux_res_src : mux3
  generic map (width => 32)
  port map(
           d0  => alu_res_w,      
           d1  => read_data_w,    
           d2  => pc_plus_4_w,    
           sel => res_src_w,      
           y   => result_w); 

--SrcA forwarding mux 
  mux_fwd_a : mux3
  port map(
           d0  => rd1_e,         
           d1  => result_w,     
           d2  => alu_res_m,     
           sel => forward_ae,
           y   => srca_e);

--SrcB forwarding mux
  mux_fwd_b : mux3
  port map(
           d0  => rd2_e,     
           d1  => result_w,       
           d2  => alu_res_m,      
           sel => forward_be,
           y   => write_data_e);  

--ALUSrc mux 
  mux_alusrc : mux
  port map(
           d0  => write_data_e,   
           d1  => sign_imm_e,     
           sel => alu_src_e,
           y   => srcb_e);
     
  ctrl : control_unit
  port map(
           op        => op,
           funct3    => funct3,
           funct7_5  => funct7_5,
--           zero      => zero,         
           imm_src   => imm_src,
           jump      => jump_d,
--           pc_src    => pc_src, 
           reg_write => reg_write_d,
           res_src   => res_src_d, 
           alu_src   => alu_src_d,
           alu_a_src => alu_a_src_d,
           branch    => branch_d,
           mem_write => mem_write_d,
           alu_cont  => alu_cont_d);

  hz : HAZARD_UNIT
  port map(     
           ra1_d      => ra1_d,
           ra2_d      => ra2_d,
           ra1_e      => ra1_e,
           ra2_e      => ra2_e,
           rd_e       => rd_e,
           rd_m       => rd_m,
           rd_w       => rd_w,
           pc_src_e   => pc_src_e,
           res_src_e  => res_src_e,
           reg_write_m=> reg_write_m,
           reg_write_w=> reg_write_w,
           stall_f    => stall_f,
           stall_d    => stall_d,
           flush_d    => flush_d,
           flush_e    => flush_e,
           forward_ae => forward_ae,
           forward_be => forward_be);
           

  ifid : if_id
  port map(
           clk         => clk,
           rst         => rst_local,
           flush       => flush_d,
           stall       => stall_d,
           instr_f     => instr,
           valid_f     => valid_f,
           valid_d     => valid_d,
           pc_f        => pc,
           pc_plus_4_f => pc_plus_4,
           instr_d     => instr_d,
           pc_d        => pc_d,
           pc_plus_4_d => pc_plus_4_d,
           predicted_taken_f  => predict_taken_f,
           predicted_target_f => predicted_target_f,

           predicted_taken_d  => predicted_taken_d,
           predicted_target_d => predicted_target_d);
 
  idex : id_ex
  port map(
          clk         => clk,
           rst        => rst_local,
          flush       => flush_e,
-- CONTROL inputs
          res_src_d   => res_src_d,
          mem_write_d => mem_write_d,
          alu_cont_d  => alu_cont_d,
          alu_src_d   => alu_src_d,
          alu_a_src_d => alu_a_src_d,
          reg_write_d => reg_write_d,
          branch_d    => branch_d,
          jump_d      => jump_d,
          valid_d     => valid_d,
          funct3_e    => funct3_e, 
          funct3_d    => funct3_d,
          jalr_d      => jalr_d,
-- CONTROL outputs
          res_src_e   => res_src_e,
          mem_write_e => mem_write_e,
          alu_cont_e  => alu_cont_e,
          alu_src_e   => alu_src_e,
          alu_a_src_e => alu_a_src_e, 
          reg_write_e => reg_write_e,
          branch_e    => branch_e,
          jump_e      => jump_e,
          valid_e     => valid_e,
          jalr_e      => jalr_e,
-- DATA inputs
          rd1_d       => rd1_d,
          rd2_d       => rd2_d,
          ra1_d       => ra1_d,
          ra2_d       => ra2_d,
          rd_d        => rd_d,
          sign_imm_d  => sign_imm_d,
          pc_d        => pc_d,
          pc_plus_4_d => pc_plus_4_d,
-- DATA outputs
          rd1_e       => rd1_e,
          rd2_e       => rd2_e,
          ra1_e       => ra1_e,
          ra2_e       => ra2_e,
          rd_e        => rd_e,
          sign_imm_e  => sign_imm_e,
          pc_plus_4_e => pc_plus_4_e,
          pc_e        => pc_e,
          predicted_taken_d  => predicted_taken_d,
          predicted_target_d => predicted_target_d,
          predicted_taken_e  => predicted_taken_e,
          predicted_target_e => predicted_target_e);

  exmem : ex_mem
  port map(
           clk          => clk,
           rst          => rst_local,
-- inputs
           res_src_e    => res_src_e,
           mem_write_e  => mem_write_e,
           reg_write_e  => reg_write_e,
           rd_e         => rd_e,
           pc_plus_4_e  => pc_plus_4_e,
           alu_res_e    => alu_res_e,
           write_data_e => write_data_e,
           valid_e      => valid_e,       
-- outputs
           res_src_m    => res_src_m,
           mem_write_m  => mem_write_m,
           reg_write_m  => reg_write_m,
           rd_m         => rd_m,
           pc_plus_4_m  => pc_plus_4_m,
           alu_res_m    => alu_res_m,
           write_data_m => write_data_m,
           valid_m      => valid_m);

  memwb : mem_wb
  port map(
           clk         => clk,
           rst         => rst_local,
           res_src_m   => res_src_m,
           reg_write_m => reg_write_m,
           rd_m        => rd_m,
           pc_plus_4_m => pc_plus_4_m,
           alu_res_m   => alu_res_m,
           read_data_m => read_data_m, 
           valid_m     => valid_m,
           res_src_w   => res_src_w,
           reg_write_w => reg_write_w,
           rd_w        => rd_w,
           pc_plus_4_w => pc_plus_4_w,
           alu_res_w   => alu_res_w,
           read_data_w => read_data_w, 
           valid_w     => valid_w);

  bp : BRANCH_PRED
  port map(
           clk                => clk,
           rst                => rst_local,
           pc_f               => pc,
           pc_e               => pc_e,
           actual_taken_e     => actual_taken_e,
           update_en_e        => predictor_update_e,
           predict_taken_f    => predict_taken_f,
           predicted_target_f => predicted_target_f,
           btb_valid_f        => btb_valid_f,
           actual_target_e    => pc_target_e,
           debug_counter_f    => bp_counter_f);

  bus_unit : BUS_M
  port map(
           clk        => clk,
           rst        => rst_local,
           mem_we     => mem_write_real,
           addr       => alu_res_m,
           write_data => write_data_m,
           dmem_we    => dmem_we,
           gpio_out   => gpio_out
);

  mux_alu_a_src: mux3
  generic map(width => 32)
  port map(
           d0  => srca_e,
           d1  => pc_e,
           d2  => x"00000000",
           sel => alu_a_src_e,
           y   => alu_input_a_e
);

end behaviour;
















