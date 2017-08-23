--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:40:14 05/12/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/bin2bcd_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bin_to_bcd
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bin2bcd_test IS
END bin2bcd_test;
 
ARCHITECTURE behavior OF bin2bcd_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bin_to_bcd
    PORT(
         num_bin : IN  std_logic_vector(7 downto 0);
         num_bcd : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal num_bin : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal num_bcd : std_logic_vector(11 downto 0);
   -- No clocks detected in port list. Replace Clk below with 
   -- appropriate port name 
 
--   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bin_to_bcd PORT MAP (
          num_bin => num_bin,
          num_bcd => num_bcd
        );

   -- Clock process definitions
--   Clk_process :process
--   begin
--		Clk <= '0';
--		wait for Clk_period/2;
--		Clk <= '1';
--		wait for Clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset = '1';
		
      wait for 100 ns;	

		reset = '0';
		
--      wait for Clk_period*10;

		wait for 100ns;

		num_bin <= "00001101";
      -- insert stimulus here 

      wait;
   end process;

END;
