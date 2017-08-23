----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:39 04/23/2016 
-- Design Name: 
-- Module Name:    mux_2to1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2to1_6bit is
    Port ( INPUT1 : in  STD_LOGIC_VECTOR (5 downto 0);
           INPUT0 : in  STD_LOGIC_VECTOR (5 downto 0);
           SEL : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (5 downto 0));
end mux_2to1_6bit;

architecture Behavioral of mux_2to1_6bit is

begin

mux : process(SEL,INPUT1,INPUT0)
begin

	if SEL = '1' then
		OUTPUT <= INPUT1;
	else
		OUTPUT <= INPUT0;
	end if;
	
end process;


end Behavioral;

