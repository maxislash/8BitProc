--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:07:40 05/18/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/acces_carte_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: acces_carte
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
 
ENTITY acces_carte_test IS
END acces_carte_test;
 
ARCHITECTURE behavior OF acces_carte_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT acces_carte
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         AdrLSB : IN  std_logic_vector(3 downto 0);
         AdrMSB : IN  std_logic_vector(1 downto 0);
         DataLSB : IN  std_logic_vector(3 downto 0);
         DataMSB : IN  std_logic_vector(3 downto 0);
         DataInMem : IN  std_logic_vector(7 downto 0);
         ce1s : OUT  std_logic;
         ce25M : OUT  std_logic;
         AN1 : OUT  std_logic;
         AN2 : OUT  std_logic;
         AN3 : OUT  std_logic;
         AN4 : OUT  std_logic;
         Sseg : OUT  std_logic_vector(7 downto 0);
         LED : OUT  std_logic_vector(7 downto 0);
         LEDg : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal AdrLSB : std_logic_vector(3 downto 0) := (others => '0');
   signal AdrMSB : std_logic_vector(1 downto 0) := (others => '0');
   signal DataLSB : std_logic_vector(3 downto 0) := (others => '0');
   signal DataMSB : std_logic_vector(3 downto 0) := (others => '0');
   signal DataInMem : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal ce1s : std_logic;
   signal ce25M : std_logic;
   signal AN1 : std_logic;
   signal AN2 : std_logic;
   signal AN3 : std_logic;
   signal AN4 : std_logic;
   signal Sseg : std_logic_vector(7 downto 0);
   signal LED : std_logic_vector(7 downto 0);
   signal LEDg : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: acces_carte PORT MAP (
          clk => clk,
          reset => reset,
          AdrLSB => AdrLSB,
          AdrMSB => AdrMSB,
          DataLSB => DataLSB,
          DataMSB => DataMSB,
          DataInMem => DataInMem,
          ce1s => ce1s,
          ce25M => ce25M,
          AN1 => AN1,
          AN2 => AN2,
          AN3 => AN3,
          AN4 => AN4,
          Sseg => Sseg,
          LED => LED,
          LEDg => LEDg
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
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		
		AdrMSB <= "01";
		AdrLSB <= "0101";
		
		DataMSB <= "0000";
		DataLSB <= "1101";
		
		DataInMem <= "00100010";

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
