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

entity registre is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           load_reg : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end registre;

architecture Behavioral of registre is

signal data : STD_LOGIC_VECTOR (7 downto 0);

begin

process(clk,reset)
begin
	if(reset = '1') then
		data <= (others => '0');
	elsif(clk = '1' and clk'event) then
		if( Ce= '1') then
			if(load_reg = '1') then
				data <= DATA_IN;
			end if;
		end if;
	end if;

end process;

DATA_OUT <= data;

end Behavioral;

