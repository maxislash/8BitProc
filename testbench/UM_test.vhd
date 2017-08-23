--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:05:59 04/14/2016
-- Design Name:   
-- Module Name:   /net/malt/e/wbaradat/Documents/EN216/processeur/UM_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM_SP_64_8
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
 
ENTITY UM_test IS
END UM_test;
 
ARCHITECTURE behavior OF UM_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM_SP_64_8
    PORT(
         ADD : IN  std_logic_vector(5 downto 0);
         DATA_IN : IN  std_logic_vector(7 downto 0);
         R_W : IN  std_logic;
         ENABLE : IN  std_logic;
         clk : IN  std_logic;
         Ce : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADD : std_logic_vector(5 downto 0) := (others => '0');
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal R_W : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM_SP_64_8 PORT MAP (
          ADD => ADD,
          DATA_IN => DATA_IN,
          R_W => R_W,
          ENABLE => ENABLE,
          clk => clk,
          Ce => Ce,
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

      wait for clk_period*10;

		Ce <='1';
		ENABLE <='1';
		R_W <= '0';
		DATA_IN <= "00000000";
		ADD <= "000000";
		
		wait for clk_period*10;
		
		Ce <='1';
		ENABLE <='0';
		R_W <= '0';
		DATA_IN <= "00000000";
		ADD <= "000000";
		
		wait for clk_period*10;
		
		ADD <= "000010";
		
		wait for clk_period*10;
		
		ADD <= "000100";
		
		wait for clk_period*10;
	
		R_W <= '1';	
		ADD <= "100000";
		DATA_IN <= "10000000";

		
		wait for clk_period*10;
		
		R_W <= '0';
		DATA_IN <= "00000000";
		ADD <= "010000";
		
		wait for clk_period*10;
		
		ADD <= "100000";
		
      -- insert stimulus here 

      wait;
   end process;

END;
