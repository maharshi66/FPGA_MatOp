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

package mat_add is
constant num_rows : integer := 2;
constant num_cols : integer := 2;

type t11 is array (0 to num_rows - 1) of unsigned(7 downto 0); 
type t_1 is array (0 to num_cols - 1) of t11;      
type t22 is array (0 to num_rows - 1) of unsigned(7 downto 0);   
type t_2 is array (0 to num_cols - 1) of t22; 
type t33 is array (0 to 1) of unsigned(15 downto 0);   
type t_3 is array (0 to 1) of t33;  

function matadd ( a : t_1; b: t_2) return t_3;

end mat_add;

package body mat_add is
function matadd (a : t_1; 
                 b : t_2 ) return t_3 is
    variable i,j : integer:=0;
    variable sum :t_3:=(others => (others => (others => '0'))); 

begin 
for i in 0 to 1 loop
    for j in 0 to 1 loop 
         sum(i)(j) := sum(i)(j) + (a(i)(j) + b(i)(j));

    end loop;
end loop;
return sum;

end matadd;

end mat_add;


