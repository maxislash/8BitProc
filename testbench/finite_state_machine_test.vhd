--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:45:59 04/23/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/finite_state_machine_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: finite_state_machine
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
 
ENTITY finite_state_machine_test IS
END finite_state_machine_test;
 
ARCHITECTURE behavior OF finite_state_machine_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT finite_state_machine
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         Ce : IN  std_logic;
         Carry : IN  std_logic;
         Data_in : IN  std_logic_vector(7 downto 0);
         OP_PC : OUT  std_logic_vector(1 downto 0);
         Adr : OUT  std_logic_vector(5 downto 0);
         sel_Adr : OUT  std_logic;
         sel_UAL : OUT  std_logic_vector(2 downto 0);
         clear_Carry : OUT  std_logic;
         load_Reg1 : OUT  std_logic;
         load_Reg_Accu : OUT  std_logic;
         load_Reg_Carry : OUT  std_logic;
         load_RegI : OUT  std_logic;
         R_W : OUT  std_logic;
         Init_Mem : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal Ce : std_logic := '0';
   signal Carry : std_logic := '0';
   signal Data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal OP_PC : std_logic_vector(1 downto 0);
   signal Adr : std_logic_vector(5 downto 0);
   signal sel_Adr : std_logic;
   signal sel_UAL : std_logic_vector(2 downto 0);
   signal clear_Carry : std_logic;
   signal load_Reg1 : std_logic;
   signal load_Reg_Accu : std_logic;
   signal load_Reg_Carry : std_logic;
   signal load_RegI : std_logic;
   signal R_W : std_logic;
   signal Init_Mem : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: finite_state_machine PORT MAP (
          clk => clk,
          reset => reset,
          Ce => Ce,
          Carry => Carry,
          Data_in => Data_in,
          OP_PC => OP_PC,
          Adr => Adr,
          sel_Adr => sel_Adr,
          sel_UAL => sel_UAL,
          clear_Carry => clear_Carry,
          load_Reg1 => load_Reg1,
          load_Reg_Accu => load_Reg_Accu,
          load_Reg_Carry => load_Reg_Carry,
          load_RegI => load_RegI,
          R_W => R_W,
          Init_Mem => Init_Mem
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
		
		Ce <= '1';
		
		Carry <= '0';
		Data_in <= "00010001";
		
		wait for clk_period*4;
		
		Carry <= '0';
		Data_in <= "00010111";

		wait for clk_period*4;
		
		Carry <= '0';
		Data_in <= "01010010";
		
		wait for clk_period*4;
		
		Carry <= '0';
		Data_in <= "01010100";
		
		wait for clk_period*4;
		
		Carry <= '0';
		Data_in <= "11001001";
		
		wait for clk_period*4;
		

      -- insert stimulus here 

      wait;
   end process;

END;
