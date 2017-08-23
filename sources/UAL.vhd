----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:37 04/07/2016 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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
use IEEE.NUMERIC_STD.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Sel_UAL : in  STD_LOGIC_VECTOR (2 downto 0);
           CARRY : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is

signal data_result : std_logic_vector (8 downto 0) := "000000000";
	
begin
-- rajouter un cas pour sel_ual = "111" pour que l'ual ne fasse rien
process(Sel_UAL, A, B)
begin

	if Sel_UAL = "000" then
		data_result(7 downto 0) <= A nor B;
		data_result(8) <= '0';
	elsif Sel_UAL = "001" then
		data_result <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
	else
		data_result <= "000000000";
	end if;

end process;

DATA_OUT <= data_result(7 downto 0);
CARRY <= data_result(8);


end Behavioral;

