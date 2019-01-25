----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2018 03:19:39 PM
-- Design Name: 
-- Module Name: interpreter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.mat_mul.all;
use work.mat_add.all;

entity interpreter is
    port (
        clk : in STD_LOGIC;
        parallel_in : in STD_LOGIC_VECTOR(7 downto 0);
        add_mult: out STD_LOGIC;
        finished : out STD_LOGIC := '0';
        mult_matrix_1_out : out t1;
        mult_matrix_2_out : out t2;
        add_matrix_1_out : out t_1;
        add_matrix_2_out : out t_2
    );
end interpreter;

architecture Behavioral of interpreter is
 
    type state is (state_A_d1, state_A_d2, state_B_d1, state_B_d2, state_A_in, state_B_in, state_operation, state_finished, state_add_A_in, state_add_B_in, state_add_finished);
    
    type temp_array is array (0 to 15) of unsigned (7 downto 0);
    signal temporary_array : temp_array;
    signal matrix_A : t1;
    signal matrix_B : t2;
    signal add_matrix_A : t_1;
    signal add_matrix_B : t_2;
    signal digits_int : integer := 0;
    signal i : integer := 0;
    signal j: integer := 0; 
    signal A_in_finished : STD_LOGIC := '0';
    signal B_in_finished : STD_LOGIC := '0';
    signal position: unsigned (15 downto 0) := "0000000000000001";
    signal temp : unsigned (15 downto 0) := (others => '0');
    signal state_reg : state := state_operation;
    
    --TODO: define the four matrix dimensions in advance
    
--    signal A_d1: unsigned(7 downto 0);
--    signal A_d2: unsigned(7 downto 0);
--    signal B_d1: unsigned(7 downto 0);
--    signal B_d2: unsigned(7 downto 0);
begin
    
    process (clk)
    
    begin
        if (clk'event and clk = '1') then
        
--            if (state_reg = state_A_d1) then
--                if (unsigned(parallel_in) >= 49 and unsigned(parallel_in) <= 54) then
--                    A_d1 <= unsigned(parallel_in) - 48;
--                elsif (unsigned(parallel_in) = 10) then
--                    state_reg <= state_A_d2;
--                end if;
            
                
--            elsif (state_reg = state_A_d2) then    
--                if (unsigned(parallel_in) >= 49 and unsigned(parallel_in) <= 54) then
--                                A_d2 <= unsigned(parallel_in) - 48;
--                            elsif (unsigned(parallel_in) = 10) then
--                                state_reg <= state_B_d1;
--                            end if;
            
            
--            elsif (state_reg = state_B_d1) then
--                            if (unsigned(parallel_in) >= 49 and unsigned(parallel_in) <= 54) then
--                                B_d1 <= unsigned(parallel_in) - 48;
--                            elsif (unsigned(parallel_in) = 10) then
--                                state_reg <= state_B_d2;
--                            end if;
                            
--            elsif (state_reg = state_B_d2) then
--                            if (unsigned(parallel_in) >= 49 and unsigned(parallel_in) <= 54) then
--                                B_d2 <= unsigned(parallel_in) - 48;
--                            elsif (unsigned(parallel_in) = 10) then
--                                state_reg <= state_A_in;
--                            end if;

            if (state_reg = state_operation) then
       
            --Addition operation by default
                            --0 for addition, 1 for multiplication
                            if (unsigned(parallel_in) = 48) then
                                state_reg <= state_add_A_in;
                            elsif (unsigned(parallel_in) = 49) then
                                state_reg <= state_A_in;
                            end if;
                            
            elsif (state_reg = state_add_A_in) then
            
            if (A_in_finished = '0') then
                            if (unsigned(parallel_in) >= 48 and unsigned(parallel_in) <= 57) then
                                --temp <= temp + unsigned(parallel_in) * position;
                                --position <= position * 10;
                                temporary_array(digits_int) <= unsigned(parallel_in) - 48;
                                digits_int <= digits_int + 1;
                            elsif (unsigned(parallel_in) = 32) then
                                temp <= (others => '0');
                                --position <= "0000000000000001";
                                for k in 0 to 2 loop
                                    --temp = temp + temporary_array(k) * 10 ^ (digits_int - k - 1)
                                    temp <= temp + (temporary_array(k) * 10**(2 - k));
                                end loop;
                                add_matrix_A(i)(j) <= temp;
                                digits_int <= 0;
                                j <= j + 1;
                                
                                if (j < num_cols) then
                                    --Do nothing
                                else
                                    j <= 0;
                                    i <= i + 1;
                                    if (i < num_rows) then
                                    --Do nothing
                                    else
                                        i <= 0;
                                        A_in_finished <= '1';
                                    end if;
                                end if;
                              end if;
                              
                              else
                                if (unsigned(parallel_in) = 10) then
                                    state_reg <= state_add_B_in;
                                end if;
                            end if;
                            
            elsif (state_reg = state_add_B_in) then
            
            if (B_in_finished = '0') then
                                if (unsigned(parallel_in) >= 48 and unsigned(parallel_in) <= 57) then
                                    --temp <= temp + unsigned(parallel_in) * position;
                                    --position <= position * 10;
                                    temporary_array(digits_int) <= unsigned(parallel_in) - 48;
                                    digits_int <= digits_int + 1;
                                elsif (unsigned(parallel_in) = 32) then
                                    temp <= (others => '0');
                                    --position <= "0000000000000001";
                                    for k in 0 to 2 loop
                                        --temp = temp + temporary_array(k) * 10 ^ (digits_int - k - 1)
                                        temp <= temp + (temporary_array(k) * (10**(2 - k)));
                                    end loop;
                                        add_matrix_B(i)(j) <= temp;
                                        digits_int <= 0;
                                        j <= j + 1;
                                                
                                 if (j < num_cols) then
                                       --Do nothing
                                 else
                                       j <= 0;
                                       i <= i + 1;
                                       if (i < num_rows) then
                                            --Do nothing
                                       else
                                            i <= 0;
                                            add_mult <= '0';
                                            B_in_finished <= '1';
                                       end if;
                                 end if;
                                 
                               else
                                    if (unsigned(parallel_in) = 10) then
                                        state_reg <= state_add_finished;
                                    end if;
                               end if;
                            end if;
                            
            elsif (state_reg = state_add_finished) then
                            
            finished <= '1';
            add_mult <= '0';
            add_matrix_1_out <= add_matrix_A;
            add_matrix_2_out <= add_matrix_B;             
                                        
            elsif (state_reg = state_A_in) then
     
            if (A_in_finished = '0') then
                if (unsigned(parallel_in) >= 48 and unsigned(parallel_in) <= 57) then
                    --temp <= temp + unsigned(parallel_in) * position;
                    --position <= position * 10;
                    temporary_array(digits_int) <= unsigned(parallel_in) - 48;
                    digits_int <= digits_int + 1;
                elsif (unsigned(parallel_in) = 32) then
                    temp <= (others => '0');
                    --position <= "0000000000000001";
                    for k in 0 to 2 loop
                        --temp = temp + temporary_array(k) * 10 ^ (digits_int - k - 1)
                        temp <= temp + (temporary_array(k) * 10**(2 - k));
                    end loop;
                    matrix_A(i)(j) <= temp;
                    digits_int <= 0;
                    j <= j + 1;
                    
                    if (j < num_cols_1) then
                        --Do nothing
                    else
                        j <= 0;
                        i <= i + 1;
                        if (i < num_rows_1) then
                        --Do nothing
                        else
                            i <= 0;
                            A_in_finished <= '1';
                        end if;
                    end if;
                  end if;
                  
                  else
                    if (unsigned(parallel_in) = 10) then
                        state_reg <= state_B_in;
                    end if;
                end if;
                
                elsif (state_reg = state_B_in) then
                   if (B_in_finished = '0') then
                    if (unsigned(parallel_in) >= 48 and unsigned(parallel_in) <= 57) then
                        --temp <= temp + unsigned(parallel_in) * position;
                        --position <= position * 10;
                        temporary_array(digits_int) <= unsigned(parallel_in) - 48;
                        digits_int <= digits_int + 1;
                    elsif (unsigned(parallel_in) = 32) then
                        temp <= (others => '0');
                        --position <= "0000000000000001";
                        for k in 0 to 2 loop
                            --temp = temp + temporary_array(k) * 10 ^ (digits_int - k - 1)
                            temp <= temp + (temporary_array(k) * 10**(2 - k));
                        end loop;
                            matrix_B(i)(j) <= temp;
                            digits_int <= 0;
                            j <= j + 1;
                                    
                     if (j < num_cols_2) then
                           --Do nothing
                     else
                           j <= 0;
                           i <= i + 1;
                           if (i < num_rows_2) then
                                --Do nothing
                           else
                                i <= 0;
                                add_mult <= '0';
                                B_in_finished <= '1';
                           end if;
                     end if;
                     
                   else
                        if (unsigned(parallel_in) = 10) then
                            state_reg <= state_finished;
                        end if;
                   end if;
                end if;
                
            elsif (state_reg = state_finished) then
       
                    finished <= '1';
                    add_mult <= '1';
                    mult_matrix_1_out <= matrix_A;
                    mult_matrix_2_out <= matrix_B;
            
            end if;
                            
        end if;
    end process;

end Behavioral;
