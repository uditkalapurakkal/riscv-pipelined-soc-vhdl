library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--RISC PIPELINED
entity INSTRUCTION_MEMORY is
port(
     address  : in std_logic_vector(31 downto 0);
     instr    : out std_logic_vector(31 downto 0));

end entity;

architecture behaviour of INSTRUCTION_MEMORY is

type memory_type is array(0 to 1023) of std_logic_vector(31 downto 0);
--signal memory : memory_type := (others => x"00000013");
--signal memory : memory_type := (
--    0      => x"00000013",   -- NOP
--    1      => x"00000011",   -- something unique at index 1
--    others => x"00000013");
signal memory : memory_type := (
  0  => x"04000F93", -- addi x31, x0, 64        ; GPIO address 0x40

  1  => x"00500093", -- addi x1, x0, 5
  2  => x"00700113", -- addi x2, x0, 7
  3  => x"002081B3", -- add  x3, x1, x2         ; 5 + 7 = 12
  4  => x"00C00213", -- addi x4, x0, 12
  5  => x"00418463", -- beq  x3, x4, T_SUB
  6  => x"1400006F", -- jal  x0, FAIL

  7  => x"401182B3", -- sub  x5, x3, x1         ; 12 - 5 = 7
  8  => x"00228463", -- beq  x5, x2, T_AND
  9  => x"1340006F", -- jal  x0, FAIL

  10 => x"00A00313", -- addi x6, x0, 10
  11 => x"00C00393", -- addi x7, x0, 12
  12 => x"00737433", -- and  x8, x6, x7         ; 10 & 12 = 8
  13 => x"00800493", -- addi x9, x0, 8
  14 => x"00940463", -- beq  x8, x9, T_OR
  15 => x"11C0006F", -- jal  x0, FAIL

  16 => x"00736533", -- or   x10, x6, x7        ; 10 | 12 = 14
  17 => x"00E00593", -- addi x11, x0, 14
  18 => x"00B50463", -- beq  x10, x11, T_XOR
  19 => x"10C0006F", -- jal  x0, FAIL

  20 => x"00734633", -- xor  x12, x6, x7        ; 10 ^ 12 = 6
  21 => x"00600693", -- addi x13, x0, 6
  22 => x"00D60463", -- beq  x12, x13, T_SLT
  23 => x"0FC0006F", -- jal  x0, FAIL

  24 => x"FFF00713", -- addi x14, x0, -1
  25 => x"00100793", -- addi x15, x0, 1
  26 => x"00F72833", -- slt  x16, x14, x15      ; signed -1 < 1 = 1
  27 => x"00100893", -- addi x17, x0, 1
  28 => x"01180463", -- beq  x16, x17, T_SLTU
  29 => x"0E40006F", -- jal  x0, FAIL

  30 => x"00F73933", -- sltu x18, x14, x15      ; unsigned 0xffffffff < 1 = 0
  31 => x"00000993", -- addi x19, x0, 0
  32 => x"01390463", -- beq  x18, x19, T_SLL
  33 => x"0D40006F", -- jal  x0, FAIL

  34 => x"00100A13", -- addi x20, x0, 1
  35 => x"00300A93", -- addi x21, x0, 3
  36 => x"015A1B33", -- sll  x22, x20, x21      ; 1 << 3 = 8
  37 => x"00800B93", -- addi x23, x0, 8
  38 => x"017B0463", -- beq  x22, x23, T_SRL
  39 => x"0BC0006F", -- jal  x0, FAIL

  40 => x"01000C13", -- addi x24, x0, 16
  41 => x"015C5CB3", -- srl  x25, x24, x21      ; 16 >> 3 = 2
  42 => x"00200D13", -- addi x26, x0, 2
  43 => x"01AC8463", -- beq  x25, x26, T_SRA
  44 => x"0A80006F", -- jal  x0, FAIL

  45 => x"FF000D93", -- addi x27, x0, -16
  46 => x"00200E13", -- addi x28, x0, 2
  47 => x"41CDDEB3", -- sra  x29, x27, x28      ; -16 >>> 2 = -4
  48 => x"FFC00F13", -- addi x30, x0, -4
  49 => x"01EE8463", -- beq  x29, x30, T_ANDI
  50 => x"0900006F", -- jal  x0, FAIL

  51 => x"00A3F293", -- andi x5, x7, 10         ; 12 & 10 = 8
  52 => x"00800313", -- addi x6, x0, 8
  53 => x"00628463", -- beq  x5, x6, T_ORI
  54 => x"0800006F", -- jal  x0, FAIL

  55 => x"00236293", -- ori  x5, x6, 2          ; 8 | 2 = 10
  56 => x"00A00313", -- addi x6, x0, 10
  57 => x"00628463", -- beq  x5, x6, T_XORI
  58 => x"0700006F", -- jal  x0, FAIL

  59 => x"00F34293", -- xori x5, x6, 15         ; 10 ^ 15 = 5
  60 => x"00500313", -- addi x6, x0, 5
  61 => x"00628463", -- beq  x5, x6, T_SLTI
  62 => x"0600006F", -- jal  x0, FAIL

  63 => x"FFF00393", -- addi x7, x0, -1
  64 => x"0013A293", -- slti x5, x7, 1          ; signed -1 < 1 = 1
  65 => x"00100313", -- addi x6, x0, 1
  66 => x"00628463", -- beq  x5, x6, T_SLTIU
  67 => x"04C0006F", -- jal  x0, FAIL

  68 => x"0013B293", -- sltiu x5, x7, 1         ; unsigned 0xffffffff < 1 = 0
  69 => x"00000313", -- addi x6, x0, 0
  70 => x"00628463", -- beq  x5, x6, T_SLLI
  71 => x"03C0006F", -- jal  x0, FAIL

  72 => x"00100393", -- addi x7, x0, 1
  73 => x"00439293", -- slli x5, x7, 4          ; 1 << 4 = 16
  74 => x"01000313", -- addi x6, x0, 16
  75 => x"00628463", -- beq  x5, x6, T_SRLI
  76 => x"0280006F", -- jal  x0, FAIL

  77 => x"00335293", -- srli x5, x6, 3          ; 16 >> 3 = 2
  78 => x"00200393", -- addi x7, x0, 2
  79 => x"00728463", -- beq  x5, x7, T_SRAI
  80 => x"0180006F", -- jal  x0, FAIL

  81 => x"FF000313", -- addi x6, x0, -16
  82 => x"40235293", -- srai x5, x6, 2          ; -16 >>> 2 = -4
  83 => x"FFC00393", -- addi x7, x0, -4
  84 => x"00728A63", -- beq  x5, x7, PASS
  85 => x"0040006F", -- jal  x0, FAIL

  86 => x"0EE00F13", -- FAIL: addi x30, x0, 0xEE
  87 => x"01EFA023", -- sw x30, 0(x31)          ; gpio_out = EE
  88 => x"FF9FF06F", -- jal x0, FAIL

  89 => x"0AA00F13", -- PASS: addi x30, x0, 0xAA
  90 => x"01EFA023", -- sw x30, 0(x31)          ; gpio_out = AA
  91 => x"FF9FF06F", -- jal x0, PASS

  others => x"00000013"
);
begin
  instr <= memory(to_integer(unsigned(address(11 downto 2))));
end architecture;


