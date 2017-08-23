--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:29:25 04/23/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/EN216/processeur/UC_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control_unit
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY UC_test IS
END UC_test;
 
ARCHITECTURE behavior OF UC_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_unit
    PORT(
         clk : IN  std_logic;
         Ce : IN  std_logic;
         reset : IN  std_logic;
         Carry : IN  std_logic;
         Data_in : IN  std_logic_vector(7 downto 0);
         Adr : OUT  std_logic_vector(5 downto 0);
         clear_Carry : OUT  std_logic;
         load_Reg1 : OUT  std_logic;
         load_Reg_Accu : OUT  std_logic;
         load_Reg_Carry : OUT  std_logic;
         sel_UAL : OUT  std_logic_vector(2 downto 0);
         w_Mem : OUT  std_logic;
         init_Mem : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';
   signal reset : std_logic := '0';
   signal Carry : std_logic := '0';
   signal Data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Adr : std_logic_vector(5 downto 0);
   signal clear_Carry : std_logic;
   signal load_Reg1 : std_logic;
   signal load_Reg_Accu : std_logic;
   signal load_Reg_Carry : std_logic;
   signal sel_UAL : std_logic_vector(2 downto 0);
   signal w_Mem : std_logic;
   signal init_Mem : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--RAM for testbench
	type ram_type is array (0 to (2**6)-1) of std_logic_vector(7 downto 0);
   signal ram : ram_type;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_unit PORT MAP (
          clk => clk,
          Ce => Ce,
          reset => reset,
          Carry => Carry,
          Data_in => Data_in,
          Adr => Adr,
          clear_Carry => clear_Carry,
          load_Reg1 => load_Reg1,
          load_Reg_Accu => load_Reg_Accu,
          load_Reg_Carry => load_Reg_Carry,
          sel_UAL => sel_UAL,
          w_Mem => w_Mem,
          init_Mem => init_Mem
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
				
		reset <= '1';
		
      wait for 100 ns;	
		
		reset <= '0';
		
		Ce <= '1';
		Carry <= '0';
		Data_in <= ram(to_integer(unsigned(Adr)));


		wait for clk_period ;
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
