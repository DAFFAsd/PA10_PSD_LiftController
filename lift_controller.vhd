library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.lift_controller_package.ALL;

entity lift_controller is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        floor_calls : in floor_call_array;  -- Tombol di setiap lantai
        force_door_open : in STD_LOGIC;
        force_door_close : in STD_LOGIC;
        
        current_floor : out INTEGER range 0 to 6;
        door_status : out STD_LOGIC;
        lift_state_out : out lift_state
    );
end lift_controller;

architecture Behavioral of lift_controller is
    signal current_floor_reg : INTEGER range 0 to 6 := 0;
    signal last_moving_direction : lift_state := IDLE;
    signal lift_state : lift_state := IDLE;
    signal door_timer : INTEGER range 0 to 5 := 0;
    signal next_target_floor : INTEGER range 0 to 6;
    signal internal_floor_calls : floor_call_array; -- Sinyal internal untuk tombol lantai
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_floor_reg <= 0;
            lift_state <= IDLE;
	    last_moving_direction <= MOVING_UP;
            door_status <= '0';
            internal_floor_calls <= (others => (up_button => '0', down_button => '0')); -- Reset semua tombol
        elsif rising_edge(clk) then
            -- Sinkronisasi sinyal input dengan sinyal internal
            internal_floor_calls <= floor_calls;

            case lift_state is
                when IDLE =>
                    next_target_floor <= determine_lift_priority(
                        current_floor_reg,
                        last_moving_direction,
                        internal_floor_calls
                    );

		    if next_target_floor = current_floor_reg then
			lift_state <= IDLE;
                    elsif next_target_floor > current_floor_reg then
                        lift_state <= MOVING_UP;
                    elsif next_target_floor < current_floor_reg then
                        lift_state <= MOVING_DOWN;
                    end if;

                when MOVING_UP =>
		    last_moving_direction <= MOVING_UP;
		    current_floor_reg <= current_floor_reg + 1;
                    if current_floor_reg = next_target_floor then
			current_floor_reg <= current_floor_reg;
                        lift_state <= DOOR_OPEN;
                        door_status <= '1';
                        door_timer <= 0;
                    end if;

                when MOVING_DOWN =>
		    last_moving_direction <= MOVING_DOWN;
		    current_floor_reg <= current_floor_reg - 1;
                    if current_floor_reg = next_target_floor then
			current_floor_reg <= current_floor_reg;
                        lift_state <= DOOR_OPEN;
                        door_status <= '1';
                        door_timer <= 0;
                    end if;

                when DOOR_OPEN =>
                    if force_door_close = '1' or door_timer = 5 then
                        lift_state <= DOOR_CLOSED;
                        door_status <= '0';
                    elsif force_door_open = '1' then
                        door_timer <= 0;
                    else
                        door_timer <= door_timer + 1;
                    end if;

                when DOOR_CLOSED =>
                    lift_state <= IDLE;

                when others =>
                    lift_state <= IDLE;
            end case;
        end if;
    end process;

    current_floor <= current_floor_reg;
    lift_state_out <= lift_state;
end Behavioral;

