library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end entity;

architecture behaviour of tb_top is

    constant clockperiod : time := 20 ns; -- 50 MHz


    signal clk_s : std_logic := '0';
    signal rst_s : std_logic := '1';

    signal gpio_out_s : std_logic_vector(7 downto 0);
    -- Debug signals from DUT
    signal valid_w_s : std_logic;
    signal stall_f_s : std_logic;
    signal stall_d_s : std_logic;
    signal flush_d_s : std_logic;
    signal flush_e_s : std_logic;
    signal branch_e_s : std_logic;
    signal jump_e_s   : std_logic;

    -- Performance counters
    signal cycle_count         : integer := 0;
    signal instr_retired_count : integer := 0;
    signal stall_count         : integer := 0;
    signal flush_count         : integer := 0;
    signal branch_count        : integer := 0;
    signal jump_count          : integer := 0;

    component top is
    port(
        clk : in std_logic;
        rst : in std_logic;
        gpio_out    : out std_logic_vector(7 downto 0);
        valid_w_dbg : out std_logic;
        stall_f_dbg : out std_logic;
        stall_d_dbg : out std_logic;
        flush_d_dbg : out std_logic;
        flush_e_dbg : out std_logic;
        branch_e_dbg : out std_logic;
        jump_e_dbg : out std_logic
    );
    end component;

begin

    --------------------------------------------------------------------
    -- Clock generation
    --------------------------------------------------------------------
    clk_s <= not clk_s after clockperiod / 2;

    --------------------------------------------------------------------
    -- DUT instantiation
    --------------------------------------------------------------------
    uut : top
    port map(
        clk => clk_s,
        rst => rst_s,
        gpio_out    => gpio_out_s,
        valid_w_dbg => valid_w_s,
        stall_f_dbg => stall_f_s,
        stall_d_dbg => stall_d_s,
        flush_d_dbg => flush_d_s,
        flush_e_dbg => flush_e_s,
        branch_e_dbg => branch_e_s,
        jump_e_dbg => jump_e_s
    );

    --------------------------------------------------------------------
    -- Performance counter process
    --------------------------------------------------------------------
    counter_proc : process(clk_s)
    begin
        if rising_edge(clk_s) then

            if rst_s = '1' then
                cycle_count         <= 0;
                instr_retired_count <= 0;
                stall_count         <= 0;
                flush_count         <= 0;
                branch_count        <= 0;
                jump_count          <= 0;

            else
                -- Every clock after reset
                cycle_count <= cycle_count + 1;

                -- Valid instruction reaching WB stage
                if valid_w_s = '1' then
                    instr_retired_count <= instr_retired_count + 1;
                end if;

                -- Stall cycle
                if stall_f_s = '1' or stall_d_s = '1' then
                    stall_count <= stall_count + 1;
                end if;

                -- Flush cycle
                if flush_d_s = '1' or flush_e_s = '1' then
                    flush_count <= flush_count + 1;
                end if;

                -- Branch reaches EX stage
                if branch_e_s = '1' then
                    branch_count <= branch_count + 1;
                end if;

                -- Jump reaches EX stage
                if jump_e_s = '1' then
                    jump_count <= jump_count + 1;
                end if;

            end if;

        end if;
    end process;

    --------------------------------------------------------------------
    -- Test stimulus
    --------------------------------------------------------------------
    stim_proc : process
    begin
        ----------------------------------------------------------------
        -- Reset
        ----------------------------------------------------------------
        rst_s <= '1';

        -- Do not release exactly on clock edge.
        -- 35 ns avoids reset release exactly at a rising edge.
        wait for 35 ns;

        rst_s <= '0';

        ----------------------------------------------------------------
        -- Run simulation long enough for full program
        ----------------------------------------------------------------
        wait for 1200 ns;

        ----------------------------------------------------------------
        -- Print results
        ----------------------------------------------------------------
        report "========================================" severity note;
        report "Simulation Complete!" severity note;
        report "Cycle count          = " & integer'image (cycle_count) severity note;
        report "Instructions retired = " & integer'image (instr_retired_count) severity note;
        report "Stall count          = " & integer'image (stall_count) severity note;
        report "Flush count          = " & integer'image (flush_count) severity note;
        report "Branch count         = " & integer'image (branch_count) severity note;
        report "Jump count           = " & integer'image (jump_count) severity note;
        report "========================================" severity note;

        assert false report "Simulation finished" severity failure;
        wait;
    end process;

end behaviour;
