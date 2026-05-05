library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity mux is
generic (width : integer := 32);
port(
     d0   : in std_logic_vector(width-1 downto 0);
     d1   : in std_logic_vector(width-1 downto 0);
     sel  : in std_logic;
     y    : out std_logic_vector(width-1 downto 0));
end entity;

architecture behaviour of mux is

begin
  with sel select
    y <= d0 when '0',
         d1 when '1',
         d0 when others;
end behaviour;    