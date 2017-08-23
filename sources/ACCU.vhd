----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:38 04/07/2016 
-- Design Name: 
-- Module Name:    ACCU - Behavioral 
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

entity ACCU is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           load_accu : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end ACCU;

architecture Behavioral of ACCU is

begin

process(clk,reset)
begin
if(reset = '1') then
	DATA_out <= (OTHERS => '0');
elsif(clk = '1' and clk'event) then
	if( ce= '1') then
		if(load_accu = '1') then
			DATA_OUT <= DATA_IN
		else
			DATA_OUT <= DATA_OUT;
		end if;
	else
		DATA_OUT <= DATA_OUT;
	end if;
end if;

	
	
process(clk,reset,Ce,load_accu)
begin

	if reset = '0' then
		if Ce = '1' then
			if clk = '1' and clk'event then
				if load_accu = '1' then
					DATA_OUT <= DATA_IN;
				end if;
			end if;
		end if;
	else 
		DATA_OUT <= "00000000";
	end if;

end process;
end Behavioral;

