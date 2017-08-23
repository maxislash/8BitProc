--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:29:46 04/20/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/bascule_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bascule
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
 
ENTITY bascule_test IS
END bascule_test;
 
ARCHITECTURE behavior OF bascule_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bascule
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         clear : IN  std_logic;
         load_bascule : IN  std_logic;
         DATA_IN : IN  std_logic;
         DATA_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal clear : std_logic := '0';
   signal load_bascule : std_logic := '0';
   signal DATA_IN : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bascule PORT MAP (
          reset => reset,
          clk => clk,
          clear => clear,
          load_bascule => load_bascule,
          DATA_IN => DATA_IN,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		
		reset <= '1';
      
		
		wait for clk_period*10;
		
		
		data_in <= '1';
		clear <= '0';
		Ce <= '1';
		load_bascule <= '0';

      wait for clk_period*10;
		
		reset <= '0';
		data_in <= '1';
		clear <= '0';
		load_bascule <= '1';
		
		wait for clk_period*10;
		
		reset <= '0';
		data_in <= '1';
		clear <= '1';
		load_bascule <= '1';
		
		wait for clk_period*10;
		
		reset <= '0';
		data_in <= '0';
		clear <= '0';
		load_bascule <= '1';




      -- insert stimulus here 

      wait;
   end process;

END;
