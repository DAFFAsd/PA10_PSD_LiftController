library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package lift_controller_package is
    -- Tipe untuk status lift
    type lift_state is (IDLE, MOVING_UP, MOVING_DOWN, DOOR_OPEN, DOOR_CLOSED);
    
    -- Struktur untuk menyimpan informasi panggilan lantai
    type floor_call is record
        up_button : STD_LOGIC;
        down_button : STD_LOGIC;
    end record;

    -- Tipe array untuk tombol di setiap lantai
    type floor_call_array is array(0 to 6) of floor_call;
    
    -- Fungsi untuk menentukan prioritas lift
    function determine_lift_priority(
        current_floor : integer;
        current_direction : lift_state;
        floor_calls : floor_call_array
    ) return integer;
end package lift_controller_package;

package body lift_controller_package is
    function determine_lift_priority(
        current_floor : integer;
        current_direction : lift_state;
        floor_calls : floor_call_array
    ) return integer is
        variable next_floor : integer := current_floor;
        variable min_distance : integer := 7;
    begin
        -- Logika prioritas berdasarkan arah lift saat ini
        if current_direction = MOVING_UP then
            -- Cari lantai terdekat di atas lantai saat ini yang memiliki panggilan naik
            for i in current_floor + 1 to 6 loop
                if floor_calls(i).up_button = '1' then
                    return i;
		    exit;
                end if;
            end loop;
            
            -- Jika tidak ada, cari panggilan turun di atas
            for i in current_floor + 1 to 6 loop
                if floor_calls(i).down_button = '1' then
                    return i;
		    exit;
                end if;
            end loop;

	    -- Jika tidak ada lagi, cari panggilan turun di bawah agar ke bawah
            for i in current_floor - 1 downto 0 loop
                if floor_calls(i).down_button = '1' then
                    return i;
		    exit;
                end if;
            end loop;
        
        elsif current_direction = MOVING_DOWN then
            -- Cari lantai terdekat di bawah lantai saat ini yang memiliki panggilan turun
            for i in current_floor - 1 downto 0 loop
                if floor_calls(i).down_button = '1' then
                    return i;
			exit;
                end if;
            end loop;
            
            -- Jika tidak ada, cari panggilan naik di bawah
            for i in current_floor - 1 downto 0 loop
                if floor_calls(i).up_button = '1' then
                    return i;
		    exit;
                end if;
            end loop;

            -- Jika tidak ada, cari panggilan turun di atas
            for i in current_floor + 1 to 6 loop
                if floor_calls(i).down_button = '1' then
                    return i;
		    exit;
                end if;
            end loop;
        end if;
        return next_floor;
    end function;end package body lift_controller_package;

