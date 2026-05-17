library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DATA_MEMORY is
generic(
     mem_depth : integer := 64;
     addr_bits : integer := 6
);
port(
     clk    : in  std_logic;
     we     : in  std_logic;
     funct3 : in  std_logic_vector(2 downto 0);
     a      : in  std_logic_vector(31 downto 0);
     wd     : in  std_logic_vector(31 downto 0);
     rd     : out std_logic_vector(31 downto 0)
);
end entity;

architecture behaviour of DATA_MEMORY is

type memory_type is array(0 to 63) of std_logic_vector(31 downto 0);
signal memory : memory_type := (others => (others => '0'));

signal word_index : integer range 0 to 63;
signal byte_offset : std_logic_vector(1 downto 0);

begin 

  word_index  <= to_integer(unsigned(a(addr_bits + 1 downto 2)));
  byte_offset <= a(1 downto 0);

  -- Always read full word. Load extension happens later in WB stage.
  rd <= memory(word_index);

  w : process(clk)
    variable current_word : std_logic_vector(31 downto 0);
  begin
    if rising_edge(clk) then
      if we = '1' then

        current_word := memory(word_index);

        case funct3 is

          when "000" => -- SB
            case byte_offset is
              when "00" => current_word(7 downto 0)   := wd(7 downto 0);
              when "01" => current_word(15 downto 8)  := wd(7 downto 0);
              when "10" => current_word(23 downto 16) := wd(7 downto 0);
              when "11" => current_word(31 downto 24) := wd(7 downto 0);
              when others => null;
            end case;

          when "001" => -- SH
            case byte_offset(1) is
              when '0' => current_word(15 downto 0)  := wd(15 downto 0);
              when '1' => current_word(31 downto 16) := wd(15 downto 0);
              when others => null;
            end case;

          when "010" => -- SW
            current_word := wd;

          when others =>
            current_word := wd; -- safe default: word store

        end case;

        memory(word_index) <= current_word;

      end if;
    end if;
  end process;

end behaviour;