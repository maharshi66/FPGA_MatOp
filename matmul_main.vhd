----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2018 04:07:00 PM
-- Design Name: 
-- Module Name: matmul_main - Behavioral
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

entity matmul_main is
port (clk : in std_logic;
      parallel_out : out std_logic_vector(15 downto 0)
);
end matmul_main;

architecture Behavioral of matmul_main is

signal a : t1 := (("00000001","00000001","00000001"),("00000001","00000001","00000001"),("00000001","00000001","00000001"),("00000001","00000001","00000001"));
signal b : t2 := (("00000001", "00000001", "00000001", "00000001", "00000001"), ("00000001", "00000001", "00000001", "00000001", "00000001"),("00000001", "00000001", "00000001", "00000001", "00000001"));
signal l : t_1 := (("00000001", "00000000"),("00000110","00000011"));
signal m : t_2 := (("00000001", "00000010"),("00001010","00000101"));

signal i : integer := 0;
signal k : integer := 0;

signal element : unsigned(15 downto 0);

signal prod : t3;
signal sum : t_3;
begin
process(clk)
begin
if(clk'event and clk='1') then
    -- if operation = '1' then
    prod <= matmul(a,b); --product function is called here.
    sum <= matadd(l,m);
    
        if k < num_cols_2 then
            element <= prod(i)(k);
            k <= k + 1; 
        else
            k <= 0;
            i <= i + 1;
            
            if i < num_rows_1 then
                element <= prod(i)(k);
            else
                k <= 0;
                i <= 0;
                element <= prod(i)(k);
            end if;
        end if;
              
     parallel_out <= std_logic_vector(element);            
    
end if;
--if(clk'event and clk='1') then
    -- if operation = '1' then
    -- sum <= matmul(a,b); -- sum function is called here.
--end if;

end process;
end Behavioral;