# 32-bit Pipelined RISC-V Processor

This project implements a 32-bit 5-stage pipelined RISC-V processor / minimal SoC-style design in VHDL. The design includes hazard handling, forwarding, valid-bit based pipeline control, reset synchronization, memory-mapped I/O through a simple BUS/address decoder, an 8-bit GPIO output peripheral, and a dynamic branch prediction unit using a 2-bit Branch History Table (BHT), Branch Target Buffer (BTB), BTB valid bits, BTB tags, and misprediction recovery.

The processor has been extended toward practical RV32I user-level instruction support. The verified instruction groups now include the ALU register/immediate group, branch group, `LUI`, `AUIPC`, `JAL`, `JALR`, byte/halfword/word load-store operations, and `FENCE` treated as a NOP for this simple in-order single-core design. Misaligned memory accesses are detected, and misaligned stores are blocked to prevent memory corruption. Full privileged CSR/trap redirection support is not implemented and is listed as future work.

The RTL was converted to Verilog using GHDL, checked with Yosys, and successfully taken through the OpenLane/SKY130 RTL-to-GDSII flow.

---

## Repository Organization

Recommended repository structure:

```text
rtl/       - Synthesizable VHDL RTL files
tb/        - Testbench files
docs/      - Architecture notes, memory map, screenshots
programs/  - Hex test programs and generated instruction-memory test programs
waves/     - Waveform PDFs/screenshots
reports/   - Simulation and OpenLane reports
openlane/  - OpenLane design configuration and generated implementation files
```

Important generated/checkpoint files:

```text
rtl/top_synth.v                         - Verilog generated from VHDL using GHDL
rtl/soc_top_synth.v                     - Synthesizable SoC wrapper Verilog for OpenLane
rtl/yosys_check.log                     - Yosys check log
reports/openlane/metrics.csv            - OpenLane metrics
reports/openlane/manufacturability.rpt  - OpenLane manufacturability report
reports/openlane/31-rcx_sta.checks.rpt  - STA checks / signoff report
programs/*.hex                          - Hex programs used for ModelSim regression testing
```

---

## Top-Level Project Status

Current verified features:

- 32-bit 5-stage pipelined RISC-V processor in VHDL
- IF, ID, EX, MEM, and WB pipeline stages
- Pipeline registers: `IF/ID`, `ID/EX`, `EX/MEM`, `MEM/WB`
- Hazard detection and load-use stall handling
- ALU operand forwarding
- Valid-bit gated pipeline control
- Reset synchronizer
- Dynamic branch predictor with BHT, BTB, valid bits, and tags
- Branch predictor ON/OFF comparison support
- Memory-mapped BUS/address decoder
- 8-bit output-only GPIO peripheral at address `0x00000040`
- Simulation-only instruction memory that can load `.hex` programs
- Hardcoded/synthesis instruction memory expanded to 1024 instruction words
- RV32I ALU, branch, jump, upper-immediate, load/store-width, and fence testing
- Misaligned memory access detection with misaligned store blocking
- GHDL VHDL-to-Verilog conversion
- Yosys design checking
- OpenLane/SKY130 RTL-to-GDSII implementation

---

## Pipeline Overview

The processor follows a standard 5-stage pipeline:

1. **IF** - Instruction Fetch
2. **ID** - Instruction Decode / Register Read
3. **EX** - Execute / Branch Resolution
4. **MEM** - Data Memory Access
5. **WB** - Write Back

Valid bits are passed through the pipeline to prevent bubbles, flushed instructions, or invalid instructions from updating architectural state.

Final write enables are gated using valid bits:

```vhdl
reg_write_real <= valid_w and reg_write_w;
mem_write_real <= valid_m and mem_write_m;
```

The branch predictor update is also gated:

```vhdl
predictor_update_e <= valid_e and branch_e;
```

This prevents invalid or flushed instructions from modifying architectural state or predictor state.

---

## RV32I Instruction Support

The current design supports the main RV32I user-level computational, control-flow, and memory instructions needed for simple bare-metal programs.

### ALU Register Instructions

| Instruction | Status |
|---|---|
| `ADD` | Supported and tested |
| `SUB` | Supported and tested |
| `SLL` | Supported and tested |
| `SLT` | Supported and tested |
| `SLTU` | Supported and tested |
| `XOR` | Supported and tested |
| `SRL` | Supported and tested |
| `SRA` | Supported and tested |
| `OR` | Supported and tested |
| `AND` | Supported and tested |

### ALU Immediate Instructions

| Instruction | Status |
|---|---|
| `ADDI` | Supported and tested |
| `SLTI` | Supported and tested |
| `SLTIU` | Supported and tested |
| `XORI` | Supported and tested |
| `ORI` | Supported and tested |
| `ANDI` | Supported and tested |
| `SLLI` | Supported and tested |
| `SRLI` | Supported and tested |
| `SRAI` | Supported and tested |

### Upper Immediate Instructions

| Instruction | Status |
|---|---|
| `LUI` | Supported and tested |
| `AUIPC` | Supported and tested |

### Control-Flow Instructions

| Instruction | Status |
|---|---|
| `BEQ` | Supported and tested |
| `BNE` | Supported and tested |
| `BLT` | Supported and tested |
| `BGE` | Supported and tested |
| `BLTU` | Supported and tested |
| `BGEU` | Supported and tested |
| `JAL` | Supported and tested |
| `JALR` | Supported and tested |

### Load Instructions

| Instruction | Status |
|---|---|
| `LB` | Supported and tested |
| `LH` | Supported and tested |
| `LW` | Supported and tested |
| `LBU` | Supported and tested |
| `LHU` | Supported and tested |

### Store Instructions

| Instruction | Status |
|---|---|
| `SB` | Supported and tested |
| `SH` | Supported and tested |
| `SW` | Supported and tested |

### System/Fence Instructions

| Instruction | Status |
|---|---|
| `FENCE` | Treated as NOP for this simple single-core in-order implementation |
| `ECALL` | Full trap/CSR behavior not implemented |
| `EBREAK` | Full trap/CSR behavior not implemented |

Current README wording should be interpreted as **RV32I user-level computational/control/memory support**, with full privileged CSR/trap support planned as future work.

---

## ALU Implementation Update

The ALU control field was expanded to 4 bits to support the full RV32I ALU group.

Internal ALU control encoding:

| `alu_cont` | Operation |
|---|---|
| `0000` | AND |
| `0001` | OR |
| `0010` | ADD |
| `0011` | XOR |
| `0100` | SLL |
| `0101` | SRL |
| `0110` | SUB |
| `0111` | SLT |
| `1000` | SLTU |
| `1001` | SRA |

Shift operations use only the lower 5 bits of the shift amount:

```vhdl
srcb(4 downto 0)
```

The ALU decoder handles both R-type and I-type ALU operations using `funct3`, `funct7_5`, and opcode bit `op(5)` where needed. R-type and I-type ALU operations share `alu_op = "10"`; the difference between register and immediate operands is selected through the datapath `alu_src` control signal.

---

## Branch Instruction Update

The original branch path was BEQ-focused. The branch unit was extended to support all RV32I branch types:

```text
BEQ, BNE, BLT, BGE, BLTU, BGEU
```

Because branch resolution happens in EX, `funct3` is now carried through the pipeline:

```text
funct3_d -> funct3_e
```

Branch decision is generated in EX using forwarded operands:

```vhdl
process(funct3_e, srca_e, write_data_e)
begin
  case funct3_e is
    when "000" => -- BEQ
    when "001" => -- BNE
    when "100" => -- BLT
    when "101" => -- BGE
    when "110" => -- BLTU
    when "111" => -- BGEU
    when others =>
  end case;
end process;
```

The branch predictor and PC redirect logic now use `branch_taken_e` instead of BEQ-only `zero_e` behavior.

---

## LUI, AUIPC, and JALR Update

To support `LUI`, `AUIPC`, and `JALR`, an ALU-A source mux was added.

Control signal:

```vhdl
alu_a_src : std_logic_vector(1 downto 0)
```

Encoding:

| `alu_a_src` | ALU A Input |
|---|---|
| `00` | Forwarded `rs1` value |
| `01` | `PC` |
| `10` | Zero |

This allows:

```text
LUI   = 0  + imm_u
AUIPC = PC + imm_u
JALR  = rs1 + imm_i
```

For `JALR`, the target address is generated as:

```vhdl
jalr_target_e <= alu_res_e(31 downto 1) & '0';
```

This clears bit 0 as required by the RISC-V JALR behavior.

---

## Load/Store Width Support

The memory system was extended beyond word-only `LW/SW` support.

Implemented load instructions:

```text
LB, LH, LW, LBU, LHU
```

Implemented store instructions:

```text
SB, SH, SW
```

### Store Width Handling

Stores are handled in the MEM stage inside the data memory write path using `funct3_m`:

| `funct3_m` | Store Type | Behavior |
|---|---|---|
| `000` | `SB` | Updates selected byte only |
| `001` | `SH` | Updates selected halfword only |
| `010` | `SW` | Updates full 32-bit word |

The memory is internally word-organized, so the byte offset comes from:

```vhdl
alu_res_m(1 downto 0)
```

For a byte store, only one byte lane is modified. For a halfword store, only the lower or upper 16-bit halfword is modified. For a word store, the full word is replaced.

### Load Extension Handling

Data memory returns a full 32-bit word. Load selection and sign/zero extension are performed before writeback using:

```text
read_data_w
alu_res_w(1 downto 0)
funct3_w
```

Load mapping:

| `funct3_w` | Load Type | Behavior |
|---|---|---|
| `000` | `LB` | Select byte and sign-extend |
| `001` | `LH` | Select halfword and sign-extend |
| `010` | `LW` | Use full word |
| `100` | `LBU` | Select byte and zero-extend |
| `101` | `LHU` | Select halfword and zero-extend |

The writeback result mux uses the extended load value instead of raw memory data.

---

## Misaligned Memory Access Detection

A lightweight misaligned access detection path was added.

Alignment rules:

| Access Width | Required Alignment |
|---|---|
| Byte | Always aligned |
| Halfword | Address bit `0` must be `0` |
| Word | Address bits `1 downto 0` must be `00` |

The design detects misaligned memory operations using the calculated address in EX:

```text
mem_access_e     = load or store in EX
mem_misaligned_e = misalignment detected in EX
mem_misaligned_m = pipelined misalignment flag in MEM
```

For misaligned stores, the final memory write enable is blocked:

```vhdl
mem_write_safe_m <= valid_m and mem_write_m and not mem_misaligned_m;
```

Because the design uses a BUS/address decoder, `mem_write_safe_m` is connected to the BUS write-enable input. The BUS then generates the final `dmem_we` for data memory or GPIO write-enable for GPIO.

This prevents invalid misaligned stores from corrupting memory or GPIO. Full trap redirection using CSRs such as `mepc`, `mcause`, and `mtvec` is not implemented yet.

---

## Simulation-Only Hex Instruction Memory

A simulation-only instruction memory was added to load programs from external `.hex` files.

This allows ModelSim testing without editing hardcoded VHDL instruction memory every time.

Typical flow:

```text
program.hex
  -> INSTRUCTION_MEMORY_HEX.vhd
  -> ModelSim simulation
  -> GPIO_OUT = AA for PASS
```

The hex file uses one 32-bit instruction per line:

```text
04000F93
0AA00F13
01EFA023
```

For synthesis/OpenLane, the hardcoded instruction memory is still used, because file I/O based ROM initialization is simulation-only.

Instruction memory was expanded to 1024 instruction words:

```text
1024 instructions = 4096 bytes = 4 KB
```

The correct word index uses:

```vhdl
address(11 downto 2)
```

---

## Verification Programs

The project now uses separate hex programs for regression testing. Recommended files under `programs/`:

```text
programs/alu_test.hex
programs/branch_test.hex
programs/lui_auipc_jalr_test.hex
programs/load_store_fence_test.hex
```

All tests use the same PASS/FAIL convention:

| GPIO Output | Meaning |
|---|---|
| `0xAA` / decimal `170` | Test passed |
| `0xEE` / decimal `238` | Test failed |

Verified test categories:

- Full RV32I ALU register/immediate group
- All RV32I branch types
- `LUI`, `AUIPC`, and `JALR`
- `LB`, `LH`, `LW`, `LBU`, `LHU`
- `SB`, `SH`, `SW`
- `FENCE` as NOP
- Misaligned halfword store detection/blocking
- Memory-mapped GPIO writes through BUS

A fixed-time simulation may show high jump/flush counts because the PASS routine intentionally loops forever after writing `0xAA`. For performance measurement, the testbench should stop when `gpio_out` first becomes `0xAA` or `0xEE`.

---

## Bare-Metal C Readiness

The processor now supports the main instruction groups needed for simple bare-metal RV32I C programs compiled with a RISC-V GCC toolchain.

Recommended compile style:

```bash
riscv32-unknown-elf-gcc \
  -march=rv32i -mabi=ilp32 \
  -nostdlib -nostartfiles \
  -T linker.ld \
  startup.S main.c \
  -o program.elf
```

Expected flow:

```text
main.c
  -> RISC-V GCC
  -> program.elf
  -> objdump/disassembly check
  -> program.hex
  -> INSTRUCTION_MEMORY_HEX.vhd
  -> ModelSim
  -> GPIO_OUT = AA
```

Supported target style:

- Simple bare-metal C
- No operating system
- No standard library/syscalls
- No `printf`, file I/O, or dynamic memory allocation unless custom runtime support is added

Example C target behavior:

```c
#define GPIO_OUT (*(volatile unsigned int *)0x40)

int main(void) {
    GPIO_OUT = 0xAA;
    while (1) {}
}
```

A dedicated startup file is required because there is no OS to call `main()` automatically.

---

## Major Implementation Steps

### 1. Basic Pipelined Processor

The first version implemented the basic datapath:

- Program counter
- Instruction memory
- Register file
- ALU
- Data memory
- Sign extension
- Control unit
- Pipeline registers

At this stage, branches and jumps were resolved in the EX stage. When a branch or jump was taken, younger instructions were flushed.

### 2. Hazard Unit and Forwarding

A hazard unit was added to handle pipeline hazards.

The hazard unit generates:

- `stall_f`
- `stall_d`
- `flush_d`
- `flush_e`
- `forward_ae`
- `forward_be`

Forwarding paths were added from later pipeline stages back to the EX stage ALU inputs.

### 3. Load-Use Stall Handling

Load-use hazard detection was added. When an instruction depends on a value being loaded from memory, the processor stalls fetch/decode and inserts a bubble into execute.

### 4. Valid Bit Support

Valid bits were added to distinguish real instructions from bubbles and flushed instructions.

### 5. Reset Synchronizer

The external reset can assert immediately, but reset deassertion is synchronized to the clock.

```vhdl
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
```

---

## Branch Predictor Implementation

The branch predictor was implemented incrementally.

### Step 1: Direction-Only 2-bit BHT

The first branch predictor version used a 2-bit Branch History Table.

```vhdl
type bht_type is array(0 to 15) of std_logic_vector(1 downto 0);
signal bht : bht_type := (others => "01");
```

A 16-entry BHT was used. The index is taken from the fetch PC:

```vhdl
index_f <= to_integer(unsigned(pc_f(5 downto 2)));
```

Each BHT entry stores a 2-bit saturating counter:

| Counter | Meaning | Prediction |
|---|---|---|
| `00` | Strongly not taken | Not taken |
| `01` | Weakly not taken | Not taken |
| `10` | Weakly taken | Taken |
| `11` | Strongly taken | Taken |

The MSB is used as the prediction:

```vhdl
predict_taken_f <= bht(index_f)(1);
```

### Step 2: BHT Update in Execute Stage

Prediction happens in IF, but the real branch result is known in EX.

Therefore two PCs are used:

- `pc_f` for prediction
- `pc_e` for update

```vhdl
index_f <= to_integer(unsigned(pc_f(5 downto 2)));
index_e <= to_integer(unsigned(pc_e(5 downto 2)));
```

The actual branch result is generated in EX:

```vhdl
actual_taken_e <= valid_e and branch_e and branch_taken_e;
predictor_update_e <= valid_e and branch_e;
```

### Step 3: Adding the BTB

The BHT only predicts direction. It does not provide the target address.

To fetch from the predicted target, a Branch Target Buffer was added.

```vhdl
type btb_type is array(0 to 15) of std_logic_vector(31 downto 0);
signal btb : btb_type := (others => (others => '0'));
```

The BTB stores the target PC of previously taken branches.

### Step 4: Adding BTB Valid Bits

After reset, the BTB contains zeros. A predicted target should not be used unless the entry has been written before.

```vhdl
signal btb_valid : std_logic_vector(15 downto 0) := (others => '0');
```

### Step 5: Pipelining Prediction Information

The branch is predicted in IF but resolved in EX. Prediction information is carried with the instruction:

```text
IF -> ID -> EX
```

Signals:

```vhdl
predicted_taken_d  : std_logic;
predicted_taken_e  : std_logic;
predicted_target_d : std_logic_vector(31 downto 0);
predicted_target_e : std_logic_vector(31 downto 0);
```

### Step 6: Misprediction Detection

Direction mismatch:

```vhdl
taken_mismatch_e <= predicted_taken_e xor actual_taken_e;
```

Target mismatch:

```vhdl
target_mismatch_e <= '1' when
    valid_e = '1' and branch_e = '1' and
    predicted_taken_e = '1' and actual_taken_e = '1' and
    predicted_target_e /= pc_target_e
else '0';
```

Final mispredict signal:

```vhdl
mispredict_e <= branch_prediction_enable and valid_e and branch_e and
                (taken_mismatch_e or target_mismatch_e);
```

Correct recovery PC:

```vhdl
correct_pc_e <= pc_target_e when actual_taken_e = '1' else pc_plus_4_e;
```

### Step 7: Predictor-Controlled PC Selection

Final PC selection priority:

1. Misprediction recovery
2. JALR target redirect
3. JAL target redirect
4. Predicted taken branch target
5. Normal `PC + 4`

JALR uses:

```vhdl
jalr_target_e <= alu_res_e(31 downto 1) & '0';
```

### Step 8: Solving BTB Aliasing with Tags

BTB tags were added so that a BTB entry is used only when the stored tag matches the current fetch PC.

```vhdl
type tag_type is array(0 to 15) of std_logic_vector(31 downto 0);
signal btb_tag : tag_type := (others => (others => '0'));
signal btb_hit_f : std_logic;
```

During prediction:

```vhdl
btb_hit_f <= '1' when btb_valid(index_f) = '1' and btb_tag(index_f) = pc_f else '0';

predict_taken_f    <= bht(index_f)(1) and btb_hit_f;
predicted_target_f <= btb(index_f);
btb_valid_f        <= btb_hit_f;
```

---

## Branch Predictor ON/OFF Comparison

A control signal was added:

```vhdl
signal branch_prediction_enable : std_logic := '1';
```

This allows testing the same program with prediction enabled or disabled.

### ModelSim Report: Predictor OFF

```text
========================================
Simulation Complete!
Cycle count          = 60
Instructions retired = 38
Stall count          = 2
Flush count          = 9
Branch count         = 11
Jump count           = 1
========================================
```

### ModelSim Report: Predictor ON

```text
========================================
Simulation Complete!
Cycle count          = 60
Instructions retired = 44
Stall count          = 2
Flush count          = 6
Branch count         = 11
Jump count           = 1
========================================
```

### Comparison Table

| Metric | Predictor OFF | Predictor ON | Improvement |
|---|---:|---:|---:|
| Cycle count | 60 | 60 | Same fixed simulation window |
| Instructions retired | 38 | 44 | +6 instructions |
| Stall count | 2 | 2 | Same |
| Flush count | 9 | 6 | 3 fewer flushes |
| Branch count | 11 | 11 | Same program behavior |
| Jump count | 1 | 1 | Same program behavior |
| Approx. IPC | 0.633 | 0.733 | +15.8% |

Flush count decreased from 9 to 6, or approximately 33.3% fewer flushes. Approximate IPC improved by about 15.8% in the fixed simulation window.

---

## BUS and Memory-Mapped GPIO

A simple memory-mapped BUS/address decoder makes the design closer to a minimal SoC-style chip instead of only a standalone CPU core.

The BUS sits between the CPU memory stage and memory-mapped targets:

```text
CPU MEM stage
  addr       = alu_res_m
  write_data = write_data_m
  mem_we     = mem_write_safe_m
       |
       v
BUS / address decoder
       |
       |-- data memory
       |
       |-- GPIO output register
```

The register file, ALU, branch predictor, and pipeline registers remain internal CPU datapath blocks. The BUS is used only for memory-stage accesses.

### Memory Map

| Address Range / Address | Target |
|---|---|
| `0x00000000` onward | Data memory |
| `0x00000040` | 8-bit GPIO output register |

The GPIO output register is accessed using normal RISC-V store instructions.

Example:

```asm
addi x1, x0, 8
sw   x1, 64(x0)     -- writes 00001000 to gpio_out
```

This drives only GPIO pin 3 high because pin number is represented by bit position:

```text
pin 0 = 00000001 = 1
pin 1 = 00000010 = 2
pin 2 = 00000100 = 4
pin 3 = 00001000 = 8
```

### Address Decoder

The BUS decodes the CPU memory-stage address.

When the CPU stores to `0x00000040`, the write is routed to GPIO:

```vhdl
gpio_sel <= '1' when addr = x"00000040" else '0';

gpio_we <= mem_we and gpio_sel;
dmem_we <= mem_we and not gpio_sel;
```

This is important because a GPIO write should not also write into normal data memory.

### GPIO Output Register

The current GPIO peripheral is output-only:

```vhdl
gpio_out : out std_logic_vector(7 downto 0)
```

A store to `0x00000040` updates the lower 8 bits of the GPIO register.

---

## VHDL to Verilog / Yosys Check

The source RTL is written in VHDL. Since OpenLane primarily expects Verilog input, GHDL was used to generate Verilog from the VHDL RTL.

Command used:

```bash
ghdl --synth --std=08 --out=verilog top > top_synth.v
```

For the OpenLane SoC wrapper version:

```bash
ghdl --synth --std=08 --out=verilog soc_top > soc_top_synth.v
```

The generated Verilog was checked using Yosys:

```bash
yosys -p "read_verilog top_synth.v; hierarchy -top top; proc; check" | tee yosys_check.log
```

Yosys reported:

```text
Found and reported 0 problems.
```

---

## OpenLane / SKY130 RTL-to-GDSII Result

The design was implemented using OpenLane with the SKY130 open-source PDK.

Flow completed:

```text
VHDL RTL
-> GHDL Verilog generation
-> Yosys/OpenLane synthesis
-> Floorplanning
-> Placement
-> Clock Tree Synthesis
-> Routing
-> Signoff checks
-> GDSII generation
```

OpenLane completed successfully:

```text
[SUCCESS]: Flow complete.
```

### First Stable Implementation Metrics

| Metric | Value |
|---|---:|
| Flow status | Completed |
| Total runtime | 35 min 2 sec |
| Routed runtime | 28 min 30 sec |
| Die area | 0.5625 mm² |
| OpenDP utilization | 35.88% |

### Timing / Signoff Summary

| Check | Result |
|---|---|
| Setup timing | No setup violations |
| Hold timing | No hold violations |
| Max slew | No violations |
| Max capacitance | No violations |
| GDSII generation | Completed |

### CTS/Fanout Optimization Notes

The first stable implementation had high fanout warnings. A later CTS clustering experiment improved fanout significantly.

Observed fanout improvement:

```text
soc_top_clean fanout: 205
CTS clustering size 8 / diameter 30: fanout 65
CTS clustering size 6 / diameter 25: fanout 37
CTS clustering size 4 / diameter 20: fanout 80
```

Best checkpoint so far:

```json
{
  "CTS_SINK_CLUSTERING_SIZE": 6,
  "CTS_SINK_CLUSTERING_MAX_DIAMETER": 25
}
```

The updated RV32I/load-store RTL should be regenerated through GHDL/Yosys and rerun through OpenLane for the final current GDSII checkpoint.

---

## Current Limitations

This is still a learning/project CPU and has some limitations:

1. **No full privileged CSR/trap architecture**
   - `ECALL`, `EBREAK`, `MRET`, `mepc`, `mcause`, `mtvec`, `mstatus`, and privilege modes are not implemented.
   - Misaligned stores are detected and blocked, but full trap redirection is future work.

2. **FENCE is treated as NOP**
   - This is acceptable for the current simple single-core in-order memory system.

3. **Small BHT/BTB size**
   - Only 16 entries are used.
   - Larger programs may cause conflict pressure.

4. **Simple branch predictor**
   - Local 2-bit predictor with BTB tags.
   - No global history or GShare in the current committed implementation.

5. **JAL/JALR are redirected in EX**
   - The branch predictor focuses on conditional branches.
   - Future versions could add jump target prediction.

6. **Small on-chip instruction/data memory**
   - Suitable for test programs and simple bare-metal C.
   - Not suitable for an operating system.

7. **GPIO is output-only**
   - Current GPIO supports only an 8-bit output register at `0x00000040`.
   - `gpio_in` and `gpio_dir` are not implemented yet.

8. **No cache or external memory bus**
   - No instruction cache, data cache, AXI, or Wishbone interface yet.

---

## Recommended Next Steps

Short-term next steps:

1. Commit the current RV32I/load-store/FENCE RTL checkpoint.
2. Keep separate regression hex files in `programs/`.
3. Rename testbench messages from `ALU TEST PASSED` to `CPU TEST PASSED`.
4. Run final ModelSim regression:
   - ALU test
   - Branch test
   - LUI/AUIPC/JALR test
   - Load/store/FENCE test
5. Add a bare-metal C compilation flow:
   - `main.c`
   - `startup.S`
   - `linker.ld`
   - Makefile
   - ELF to hex conversion
6. Rerun GHDL/Yosys synthesis checks.
7. Generate updated OpenLane/SKY130 GDSII.
8. Add final waveform screenshots and OpenLane metrics to the repository.

Possible future architectural improvements:

- Bare-metal C program demo through RISC-V GCC
- GPIO input and direction registers
- Simple timer peripheral
- UART-TX peripheral
- AXI-Lite or Wishbone-style bus interface
- Interrupt and minimal CSR support
- Full trap/exception redirection
- GShare branch predictor
- Larger BHT/BTB
- Better performance counters
- Instruction/data cache exploration

---

## Summary

This project demonstrates a working 32-bit 5-stage pipelined RISC-V processor / minimal SoC-style design in VHDL with hazard handling, forwarding, valid-bit control, branch prediction, memory-mapped GPIO, simulation-based verification, and OpenLane/SKY130 RTL-to-GDSII implementation.

The current architecture now includes practical RV32I user-level instruction support across ALU, branch, jump, upper-immediate, and memory-width operations:

```text
ALU register/immediate instructions: supported and tested
Branches: BEQ, BNE, BLT, BGE, BLTU, BGEU supported and tested
Jumps: JAL and JALR supported and tested
Upper immediate: LUI and AUIPC supported and tested
Loads: LB, LH, LW, LBU, LHU supported and tested
Stores: SB, SH, SW supported and tested
FENCE: treated as NOP
Misaligned stores: detected and blocked
```

The SoC-style memory-mapped I/O system adds a BUS/address decoder and an 8-bit GPIO output register at `0x00000040`.

The ASIC flow demonstrates GHDL VHDL-to-Verilog generation, Yosys checking, OpenLane/SKY130 synthesis, floorplanning, placement, CTS, routing, timing analysis, and GDSII generation.

The next most valuable project milestone is to demonstrate execution of a simple bare-metal C program compiled with a RISC-V GCC toolchain and then rerun the final updated RTL through OpenLane for a current RV32I-capable GDSII checkpoint.
