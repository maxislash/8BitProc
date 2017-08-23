--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:22:10 04/25/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/CPU_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
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
 
ENTITY CPU_test IS
END CPU_test;
 
ARCHITECTURE behavior OF CPU_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         Clk : IN  std_logic;
--         Ce : IN  std_logic;
         Reset : IN  std_logic;
--         Adr : OUT  std_logic_vector(5 downto 0);
--         data_men_in : OUT  std_logic_vector(7 downto 0);
--         data_men_out : OUT  std_logic_vector(7 downto 0)
			AN1  : out std_logic;
	 	   AN2  : out std_logic;
	 	   AN3  : out std_logic;
	 	   AN4  : out std_logic;
		   Sseg : out STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
--   signal Ce : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
--   signal Adr : std_logic_vector(5 downto 0);
--   signal data_men_in : std_logic_vector(7 downto 0);
--   signal data_men_out : std_logic_vector(7 downto 0);
	
	signal  AN1  :  std_logic;
	signal  AN2  :  std_logic;
	signal  AN3  :  std_logic;
	signal  AN4  :  std_logic;
	signal  Sseg : STD_LOGIC_VECTOR (7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          Clk => Clk,
--          Ce => Ce,
          Reset => Reset,
--          Adr => Adr,
--          data_men_in => data_men_in,
--          data_men_out => data_men_out
			  AN1 => AN1,  
	 		  AN2 => AN2,  
	 		  AN3 => AN3,  
	 		  AN4 => AN4,
			  Sseg => Sseg
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
--		Ce <= '0';
		reset <= '0';
		
      wait for 100 ns;	

--		Ce <= '1';
		reset <= '1';
		
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
