library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BUS_M is
port(
    clk        : in  std_logic;
    rst        : in  std_logic;

    -- CPU memory-stage interface
    mem_we     : in  std_logic;
    addr       : in  std_logic_vector(31 downto 0);
    write_data : in  std_logic_vector(31 downto 0);

    -- To data memory
    dmem_we    : out std_logic;

    -- GPIO
    gpio_out   : out std_logic_vector(7 downto 0)
);
end entity;

architecture behaviour of BUS_M is

signal gpio_reg : std_logic_vector(7 downto 0) := (others => '0');

signal gpio_sel : std_logic;
signal gpio_we  : std_logic;

begin

-- GPIO address decode
-- 0x00000040 = GPIO output register
gpio_sel <= '1' when addr = x"00000040" else '0';

-- Write enable routing
gpio_we <= mem_we and gpio_sel;
dmem_we <= mem_we and not gpio_sel;

-- GPIO output register
process(clk)
begin
  if rising_edge(clk) then
    if rst = '1' then
      gpio_reg <= (others => '0');

    elsif gpio_we = '1' then
      gpio_reg <= write_data(7 downto 0);

    end if;
  end if;
end process;

gpio_out <= gpio_reg;

end behaviour;
