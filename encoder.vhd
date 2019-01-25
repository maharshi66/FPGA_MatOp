----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2018 03:36:21 PM
-- Design Name: 
-- Module Name: encoder - Behavioral
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

entity encoder is
  Port (
    add_mult : in std_logic;
    clk : in std_logic;
    bcd_ones_in : in std_logic_vector(3 downto 0);
    bcd_tens_in : in std_logic_vector(3 downto 0);
    bcd_hundreds_in : in std_logic_vector(3 downto 0);
    bcd_thousands_in : in std_logic_vector(3 downto 0);
    ascii_out : out std_logic_vector(7 downto 0)
   );
end encoder;

architecture Behavioral of encoder is
    type std_vec_4_array is array (15 downto 0) of std_logic_vector(3 downto 0);
    signal tick_count : unsigned (10 downto 0) := "00000000000";
    signal tick : std_logic := '0';
    signal ones_array, tens_array, hundreds_array, thousands_array : std_vec_4_array;
    signal num_elements : integer;
    signal count : integer := 0;
    signal output_count : integer := 0;
    signal significance : unsigned (1 downto 0) := "00";
begin

    
    process(clk)
    begin
    
        if (clk'event and clk = '1') then
        
            tick_count <= tick_count + 1;
            if (tick_count = "11111111111") then
                tick <= not tick;
            end if;
        end if;
        
            if (tick'event and tick = '1') then
                if (add_mult = '1') then
                        num_elements <= num_rows_1 * num_cols_2;
                    else
                        num_elements <= num_rows * num_cols;
                    end if;
                
                if (count < num_elements) then
                
                    ones_array(count) <= bcd_ones_in;
                    tens_array(count) <= bcd_tens_in;
                    hundreds_array(count) <= bcd_hundreds_in;
                    thousands_array(count) <= bcd_thousands_in;    
                    count <= count + 1;
                else
                
                    if (output_count < num_elements) then
                    
                        case (significance) is
                        
                            when "00" =>
                                case (thousands_array(output_count)) is
                                    when "0000" =>
                                        ascii_out <= "00110000";
                                    when "0001" =>
                                        ascii_out <= "00110001";
                                    when "0010" =>
                                        ascii_out <= "00110010";
                                    when "0011" =>
                                        ascii_out <= "00110011";
                                    when "0100" =>
                                        ascii_out <= "00110100";
                                    when "0101" =>
                                        ascii_out <= "00110101";
                                    when "0110" =>
                                        ascii_out <= "00110110";
                                    when "0111" =>
                                        ascii_out <= "00110111";
                                    when "1000" =>
                                        ascii_out <= "00111000";
                                    when others =>
                                        ascii_out <= "00111001";
                                end case;
                                significance <= significance + 1;
                            when "01" =>
                                case (hundreds_array(output_count)) is
                                                                when "0000" =>
                                                                    ascii_out <= "00110000";
                                                                when "0001" =>
                                                                    ascii_out <= "00110001";
                                                                when "0010" =>
                                                                    ascii_out <= "00110010";
                                                                when "0011" =>
                                                                    ascii_out <= "00110011";
                                                                when "0100" =>
                                                                    ascii_out <= "00110100";
                                                                when "0101" =>
                                                                    ascii_out <= "00110101";
                                                                when "0110" =>
                                                                    ascii_out <= "00110110";
                                                                when "0111" =>
                                                                    ascii_out <= "00110111";
                                                                when "1000" =>
                                                                    ascii_out <= "00111000";
                                                                when others =>
                                                                    ascii_out <= "00111001";
                                                            end case;
                                                            significance <= significance + 1;
                            when "10" =>
                            case (tens_array(output_count)) is
                                                                when "0000" =>
                                                                    ascii_out <= "00110000";
                                                                when "0001" =>
                                                                    ascii_out <= "00110001";
                                                                when "0010" =>
                                                                    ascii_out <= "00110010";
                                                                when "0011" =>
                                                                    ascii_out <= "00110011";
                                                                when "0100" =>
                                                                    ascii_out <= "00110100";
                                                                when "0101" =>
                                                                    ascii_out <= "00110101";
                                                                when "0110" =>
                                                                    ascii_out <= "00110110";
                                                                when "0111" =>
                                                                    ascii_out <= "00110111";
                                                                when "1000" =>
                                                                    ascii_out <= "00111000";
                                                                when others =>
                                                                    ascii_out <= "00111001";
                                                            end case;
                                                            significance <= significance + 1;
                            when "11" =>
                            case (ones_array(output_count)) is
                                                                when "0000" =>
                                                                    ascii_out <= "00110000";
                                                                when "0001" =>
                                                                    ascii_out <= "00110001";
                                                                when "0010" =>
                                                                    ascii_out <= "00110010";
                                                                when "0011" =>
                                                                    ascii_out <= "00110011";
                                                                when "0100" =>
                                                                    ascii_out <= "00110100";
                                                                when "0101" =>
                                                                    ascii_out <= "00110101";
                                                                when "0110" =>
                                                                    ascii_out <= "00110110";
                                                                when "0111" =>
                                                                    ascii_out <= "00110111";
                                                                when "1000" =>
                                                                    ascii_out <= "00111000";
                                                                when others =>
                                                                    ascii_out <= "00111001";
                                                            end case;
                                                            significance <= significance + 1;
                                                            output_count <= output_count + 1;
                        end case;
                    
                    else
                        output_count <= 0;
                        ascii_out <= "00100001"; --Output "!" upon reaching end of matrix
                    end if;
                end if;
                
                end if;
    
    end process;

end Behavioral;
