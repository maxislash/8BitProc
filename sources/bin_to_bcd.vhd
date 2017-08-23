----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:55:47 04/30/2016 
-- Design Name: 
-- Module Name:    bin_to_bcd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_to_bcd is
    Port ( num_bin : in  STD_LOGIC_VECTOR (7 downto 0);
           num_bcd : out  STD_LOGIC_VECTOR (11 downto 0));
end bin_to_bcd;

architecture Behavioral of bin_to_bcd is

begin
   bin_to_bcd : process (num_bin)
      -- Internal variable for storing bits
      variable shift : unsigned(19 downto 0);
      
	  -- Alias for parts of shift register
      alias num is shift(7 downto 0);
      alias one is shift(11 downto 8);
      alias ten is shift(15 downto 12);
      alias hun is shift(19 downto 16);
   begin
      -- Clear previous number and store new number in shift register
      num := unsigned(num_bin);
      one := X"0";
      ten := X"0";
      hun := X"0";
      
	  -- Loop eight times
      for i in 1 to num'Length loop
	     -- Check if any digit is greater than or equal to 5
         if one >= 5 then
            one := one + 3;
         end if;
         
         if ten >= 5 then
            ten := ten + 3;
         end if;
         
         if hun >= 5 then
            hun := hun + 3;
         end if;
         
		 -- Shift entire register left once
         shift := shift_left(shift, 1);
      end loop;
      
	  -- Push decimal numbers to output
			num_bcd <= (others => '0');
			num_bcd(11 downto 8) <= std_logic_vector(hun);
			num_bcd(7 downto 4) <= std_logic_vector(ten);
			num_bcd(3 downto 0) <= std_logic_vector(one);
			
   end process;

end Behavioral;

