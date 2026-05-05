library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity BRANCH_PRED is
port(
     clk, rst         : in std_logic;
     pc_f, pc_e       : in std_logic_vector(31 downto 0); 
     actual_taken_e   : in  std_logic;

     update_en_e      : in  std_logic;
     predict_taken_f  : out std_logic;
     debug_counter_f  : out std_logic_vector(1 downto 0);
  
    predicted_target_f : out std_logic_vector(31 downto 0);
    btb_valid_f        : out std_logic;
    actual_target_e    : in  std_logic_vector(31 downto 0)
);
end entity;
     
architecture behaviour of BRANCH_PRED is

type bht_type is array(0 to 15) of std_logic_vector(1 downto 0);
signal bht: bht_type := (others => "01");
signal index_f : integer range 0 to 15 ;
signal index_e : integer range 0 to 15 ;

type btb_type is array(0 to 15) of std_logic_vector(31 downto 0);
signal btb : btb_type := (others => (others => '0'));

signal btb_valid : std_logic_vector(15 downto 0) := (others => '0');

type tag_type is array(0 to 15) of std_logic_vector(31 downto 0);
signal btb_tag : tag_type := (others => (others => '0'));

signal btb_hit_f : std_logic;

begin

index_f <= to_integer(unsigned(pc_f(5 downto 2)));
index_e <= to_integer(unsigned(pc_e(5 downto 2)));

--predict_taken_f <= bht(index_f)(1);
debug_counter_f <= bht(index_f);

btb_hit_f <= '1' when btb_valid(index_f) = '1' and btb_tag(index_f) = pc_f else '0';
predict_taken_f    <= bht(index_f)(1) and btb_hit_f;
predicted_target_f <= btb(index_f);
btb_valid_f        <= btb_hit_f;

cmb : process(clk)

begin
 if rising_edge(clk) then
 if rst = '1' then
   bht       <= (others => "01");
   btb       <= (others => (others => '0'));
   btb_valid <= (others => '0');
   btb_tag   <= (others => (others => '0'));

 elsif update_en_e = '1' then
   if actual_taken_e = '1' then
     case bht(index_e) is
     when "00" =>
     bht(index_e) <= "01";
     when "01" =>
     bht(index_e) <= "10";
     when "10" =>
     bht(index_e) <= "11";
     when "11" =>
     bht(index_e) <= "11";
     when others =>
     bht(index_e) <= "01";
     end case;

    btb(index_e)       <= actual_target_e;
    btb_tag(index_e)   <= pc_e;
    btb_valid(index_e) <= '1';

    elsif actual_taken_e = '0' then
     case bht(index_e) is
     when "11" =>
     bht(index_e) <= "10";
     when "10" =>
     bht(index_e) <= "01";
     when "01" =>
     bht(index_e) <= "00";
     when "00" =>
     bht(index_e) <= "00";
     when others =>
     bht(index_e) <= "01";
     end case;

    

     else
     null;
   end if;
 end if;
end if;

end process;
end behaviour;