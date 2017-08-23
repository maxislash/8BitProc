--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:50:23 04/20/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/registre_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registre
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
 
ENTITY registre_test IS
END registre_test;
 
ARCHITECTURE behavior OF registre_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registre
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         Ce : IN  std_logic;
         DATA_IN : IN  std_logic_vector(7 downto 0);
         load_reg : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal Ce : std_logic := '0';
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal load_reg : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registre PORT MAP (
          clk => clk,
          reset => reset,
          Ce => Ce,
          DATA_IN => DATA_IN,
          load_reg => load_reg,
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

      reset <='1';
		Ce <= '0';
		DATA_IN <= "00000100";
		load_reg <= '0';
		
		wait for clk_period*10;
		
		reset <='0';
		Ce <= '0';
		DATA_IN <= "00000100";
		load_reg <= '0';
		
		wait for clk_period*10;
		
		reset <='0';
		Ce <= '1';
		DATA_IN <= "00000100";
		load_reg <= '0';
		
		wait for clk_period*10;
		
		reset <='0';
		Ce <= '1';
		DATA_IN <= "00000100";
		load_reg <= '1';
		
		wait for clk_period*10;
		
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
