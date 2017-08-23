----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:03 04/07/2016 
-- Design Name: 
-- Module Name:    Carry - Behavioral 
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

entity bascule is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  Ce : in STD_LOGIC;
           clear : in  STD_LOGIC;
			  load_bascule : in STD_LOGIC;
           DATA_IN : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC);
end bascule;

architecture Behavioral of bascule is

begin

process(clk,reset)
begin

	if reset = '1' then
		DATA_OUT <= '0';
	elsif rising_edge(clk) then
		if Ce = '1' then
			if clear = '0' then 
				if load_bascule = '1' then
					DATA_OUT <= DATA_IN;
				end if;
			else 
				DATA_OUT <= '0';
			end if;
		end if;
	end if;
end process;
end Behavioral;

