----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:25 04/07/2016 
-- Design Name: 
-- Module Name:    RAM_SP_64_8 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_SP_64_8 is
    Port ( 
			  ADD : in  STD_LOGIC_VECTOR (5 downto 0);
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           R_W : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
			  Adr : out STD_LOGIC_VECTOR(5 downto 0);
			  Data : out STD_LOGIC_VECTOR(7 downto 0);
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end RAM_SP_64_8;

architecture Behavioral of RAM_SP_64_8 is

   type ram_type is array (0 to (2**6)-1) of std_logic_vector(7 downto 0);
   signal ram : ram_type;
	signal ram_test : ram_type;

begin

				
  RamProc: process(clk) is

  begin
    if (clk = '1' and clk'event) then
      if (Ce = '1') then
			
			if(ENABLE = '1') then --initialisation

				ram(0) <= "00010001";
				ram(1) <= "00010101";
				ram(2) <= "01010010";
				ram(3) <= "01010100";
				ram(4) <= "11001001";
				ram(5) <= "10010100";
				ram(6) <= "01010001";
				ram(7) <= "11001101";
				ram(8) <= "11000000";
				ram(9) <= "00010011";
				ram(10) <= "01010010";
				ram(11) <= "10010101";
				ram(12) <= "11000000";
				ram(13) <= "11001101";
				ram(14) <= "00000000";
				ram(15) <= "00000000";
				ram(16) <= "00000000";
				ram(17) <= "11111111";
				ram(18) <= "00000001";
				ram(19) <= "00000000";
				ram(20) <= "00111100";
				ram(21) <= "00100100";
				for i in 22 to 63 loop
					ram(i) <= "00000000";
				end loop;
				
			else
				if (R_W = '1') then --write if R_W = 1 / read if R_W = 0
					ram(to_integer(unsigned(ADD))) <= DATA_IN;			
				end if;
			end if;
		end if;
	end if;
  end process RamProc;

  DATA_OUT <= ram(to_integer(unsigned(ADD)));
  
-- On sort l'adresse 21 ainsi que son contenu pour l'affichage  
  Data <= ram(21);
  Adr <= std_logic_vector(to_unsigned(21,6));

end Behavioral;

