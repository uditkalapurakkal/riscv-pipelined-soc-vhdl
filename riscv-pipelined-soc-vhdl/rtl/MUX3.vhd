library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is
generic (width : integer := 32);
port(
     d0   : in std_logic_vector(width-1 downto 0);
     d1   : in std_logic_vector(width-1 downto 0);
     d2   : in std_logic_vector(width-1 downto 0);
     sel  : in std_logic_vector(1 downto 0);
     y    : out std_logic_vector(width-1 downto 0));
end entity;

architecture behaviour of mux3 is

begin
  with sel select
    y <= d0 when "00",
         d1 when "01",
         d2 when "10",
         d0 when others;
end behaviour;    
