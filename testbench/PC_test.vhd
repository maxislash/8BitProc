--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:46:07 04/22/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/PC_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY PC_test IS
END PC_test;
 
ARCHITECTURE behavior OF PC_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT program_counter
    PORT(
         clk : IN  std_logic;
         ADR_IN : IN  std_logic_vector(5 downto 0);
         OPCODE : IN  std_logic_vector(1 downto 0);
         ADR_OUT : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ADR_IN : std_logic_vector(5 downto 0) := (others => '0');
   signal OPCODE : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal ADR_OUT : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: program_counter PORT MAP (
          clk => clk,
          ADR_IN => ADR_IN,
          OPCODE => OPCODE,
          ADR_OUT => ADR_OUT
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
		
		ADR_IN <= "000100";
		OPCODE <= "00";
		
		wait for 100 ns;	
		
		ADR_IN <= "000100";
		OPCODE <= "01";
		
		wait for 100 ns;	
		
		ADR_IN <= "001000";
		OPCODE <= "10";
		
		wait for 100 ns;	
		
		ADR_IN <= "000100";
		OPCODE <= "11";
		
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
