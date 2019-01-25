----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2018 03:39:08 PM
-- Design Name: 
-- Module Name: matrix_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.mat_mul.all;
use work.mat_add.all;

entity matrix_top is
  Port ( 
        clk : in STD_LOGIC;
        btnU : in STD_LOGIC;
        rx : in STD_LOGIC;
        tx : out STD_LOGIC
  );
end matrix_top;

architecture Behavioral of matrix_top is

    signal rx_empty, tx_full : std_logic;
    signal rec_data,rec_data1: std_logic_vector(7 downto 0);
    signal mat_element : std_logic_vector(15 downto 0);
    signal ones, tens, hundreds, thousands : std_logic_vector(3 downto 0);
    signal add_mult : std_logic;
    signal btn_tick : std_logic;
    signal interpreter_finished : std_logic;
    signal add_matrix_1 : t_1;
    signal add_matrix_2 : t_2;
    signal mult_matrix_1 : t1;
    signal mult_matrix_2 : t2;
    signal product : t3;
    signal sum : t_3;

begin

    uart_unit : entity work.uart(str_arch)
        port map(
            clk=>clk, reset=>'0',
                       rd_uart=>btn_tick,
                       wr_uart=>btn_tick, 
                       rx=>rx, 
                       w_data=>rec_data1,
                       tx_full=>tx_full, 
                       rx_empty=>rx_empty,
                       r_data=>rec_data, tx=>tx
        );
        
        btn_db_unit: entity work.debounce(fsmd_arch)
              port map(
                clk=>clk,
                reset=>'0',
                sw=>btnU,
                db_level=>open, 
                db_tick=>btn_tick
                );

--    interpreter_unit : entity work.interpreter(Behavioral)
--        port map(
--            clk => clk,
--            parallel_in => rec_data,
--            add_mult => add_mult,
--            finished => interpreter_finished,
--            mult_matrix_1_out => mult_matrix_1,
--            mult_matrix_2_out => mult_matrix_2,
--            add_matrix_1_out => add_matrix_1,
--            add_matrix_2_out => add_matrix_2
--        );
        
        matmul_unit : entity work.matmul_main(Behavioral)
            port map(
                clk => clk,
                parallel_out => mat_element
            );
            
       bin2bcd_16_unit : entity work.bin2bcd(fum)
            port map(
                input => mat_element,
                ones => ones,
                tens => tens,
                hundreds => hundreds,
                thousands => thousands
            );
            
        encoder_unit : entity work.encoder(Behavioral)
            port map(
                add_mult => '1',
                clk => clk,
                bcd_ones_in => ones,
                bcd_tens_in => tens,
                bcd_hundreds_in => hundreds,
                bcd_thousands_in => thousands,
                ascii_out => rec_data1
            );
            
            

end Behavioral;
