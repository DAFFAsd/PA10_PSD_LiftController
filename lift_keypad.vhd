library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.lift_controller_package.ALL;

entity lift_keypad is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        
        -- Input keypad 1-7
        keypad_input : in STD_LOGIC_VECTOR(6 downto 0);
        current_floor_reg : in INTEGER range 0 to 6;
        -- Output floor calls untuk lift controller
        floor_calls2 : out floor_call_array
    );
end lift_keypad;

architecture Structural of lift_keypad is
    signal internal_floor_calls : floor_call_array;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset semua floor calls
            internal_floor_calls <= (others => (up_button => '0', down_button => '0'));
        elsif rising_edge(clk) then
            -- Proses input keypad
            for i in 0 to 6 loop
                if keypad_input(i) = '1' then
                    -- Tentukan arah tombol berdasarkan posisi relatif lantai saat ini
                    if i > current_floor_reg then
                        internal_floor_calls(i).up_button <= '1';
                        internal_floor_calls(i).down_button <= '0';
                    elsif i < current_floor_reg then
                        internal_floor_calls(i).down_button <= '1';
                        internal_floor_calls(i).up_button <= '0';
                    else
                        -- Jika di lantai yang sama, atur ulang tombol jadi 0
                        internal_floor_calls(i).up_button <= '0';
                        internal_floor_calls(i).down_button <= '0';
                    end if;
                else
                    -- Reset tombol jika tidak ditekan
                    internal_floor_calls(i).up_button <= '0';
                    internal_floor_calls(i).down_button <= '0';
                end if;
            end loop;
        end if;
    end process;

    -- Keluarkan floor calls
    floor_calls2 <= internal_floor_calls;
end Structural;
