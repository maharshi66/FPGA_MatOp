----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2018 03:57:45 PM
-- Design Name: 
-- Module Name: mat_mul - Behavioral
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

package mat_mul is

constant num_rows_1 : integer := 4;
constant num_cols_1 : integer := 3;
constant num_rows_2 : integer := 3;
constant num_cols_2 : integer := 5;

type t11 is array (0 to num_cols_1 - 1) of unsigned(7 downto 0);-- num of columns for A
type t1 is array (0 to num_rows_1 - 1) of t11; --4*3 matrix
type t22 is array (0 to num_cols_2 - 1) of unsigned(7 downto 0); --num of columns for B
type t2 is array (0 to num_rows_2 - 1) of t22; --3*5 matrix
type t33 is array (0 to 4) of unsigned(15 downto 0);
type t3 is array (0 to 3) of t33; --4*5 matrix as output

function matmul ( a : t1; b:t2 ) return t3;

end mat_mul;

package body mat_mul is
function matmul ( a : t1; 
                   b : t2 ) return t3 is
    variable i,j,k : integer:=0;
    variable prod : t3:=(others => (others => (others => '0')));

begin
for i in 0 to 3 loop --(number of rows in the first matrix - 1)
    for j in 0 to 4 loop --(number of columns in the second matrix - 1)
        for k in 0 to 2 loop --(number of rows in the second matrix - 1)
            prod(i)(j) := prod(i)(j) + (a(i)(k) * b(k)(j));
        end loop;
    end loop;
end loop;
return prod;

end matmul;

end mat_mul;


