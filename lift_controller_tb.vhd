library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.lift_controller_package.ALL;

entity lift_controller_tb is
end lift_controller_tb;

architecture Behavioral of lift_controller_tb is
    component lift_controller
        Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            floor_calls : in floor_call_array;
            force_door_open : in STD_LOGIC;
            force_door_close : in STD_LOGIC;
            
            current_floor : out INTEGER range 0 to 6;
            door_status : out STD_LOGIC;
            lift_state_out : out lift_state
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal floor_calls : floor_call_array := (others => (up_button => '0', down_button => '0'));
    signal force_door_open : STD_LOGIC := '0';
    signal force_door_close : STD_LOGIC := '0';
    
    signal current_floor : INTEGER range 0 to 6;
    signal door_status : STD_LOGIC;
    signal lift_state_out : lift_state;

    constant CLK_PERIOD : time := 10 ps;
begin
    uut: lift_controller PORT MAP (
        clk => clk,
        reset => reset,
        floor_calls => floor_calls,
        force_door_open => force_door_open,
        force_door_close => force_door_close,
        current_floor => current_floor,
        door_status => door_status,
        lift_state_out => lift_state_out
    );

    -- Clock process
    clk_process :process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset awal
        reset <= '1';
        wait for 30 ps;
        reset <= '0';

        -- Simulasi panggilan lift dari lantai 4 (tombol naik) dan lantai 2 & 3(tombol pengen turun)
	floor_calls(4).up_button <= '1';
	floor_calls(3).down_button <= '1';
	floor_calls(2).down_button <= '1';
        wait for 350 ps;
	floor_calls(4).up_button <= '0';
        floor_calls(3).down_button <= '0';
	floor_calls(2).down_button <= '0';
        wait;
    end process;
end Behavioral;
