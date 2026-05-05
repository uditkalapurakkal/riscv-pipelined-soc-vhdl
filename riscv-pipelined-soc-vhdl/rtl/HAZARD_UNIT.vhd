library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HAZARD_UNIT is
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
end entity;

architecture behaviour of HAZARD_UNIT is 

begin


cmb: process(ra1_e, ra2_e, rd_m, rd_w, rd_e,
             ra1_d, ra2_d, res_src_e, pc_src_e,
             reg_write_m, reg_write_w)

variable lw_stall : std_logic;
begin

--STALL 
  if (res_src_e = "01") and ((ra1_d = rd_e) or (ra2_d = rd_e)) then
    lw_stall := '1';
  else
    lw_stall := '0';
  end if;

    stall_f <= lw_stall;
    stall_d <= lw_stall;
   -- Flush outputs
    flush_d <= pc_src_e;
    flush_e <= pc_src_e or lw_stall;

--FORWARD
  if ((ra1_e = rd_m) and reg_write_m = '1') and (ra1_e /= "00000") then
    forward_ae <= "10";
  elsif ((ra1_e = rd_w) and reg_write_w = '1') and (ra1_e /= "00000") then
    forward_ae <= "01";
  else
    forward_ae <= "00";
  end if;

  if ((ra2_e = rd_m) and reg_write_m = '1') and (ra2_e /= "00000") then
    forward_be <= "10";
  elsif ((ra2_e = rd_w) and reg_write_w = '1') and (ra2_e /= "00000") then
    forward_be <= "01";
  else
    forward_be <= "00";
  end if;

end process; 
end behaviour;
