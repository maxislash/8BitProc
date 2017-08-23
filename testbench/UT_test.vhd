-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY UT_test IS
  END UT_test;

  ARCHITECTURE behavior OF UT_test IS 

  -- Component Declaration
          COMPONENT Processing_unit
          PORT(
					 Data_in : in  STD_LOGIC_VECTOR (7 downto 0);
					  clk : in  STD_LOGIC;
					  Ce : in  STD_LOGIC;
					  reset : in  STD_LOGIC;
					  load_reg1 : in  STD_LOGIC;
					  load_accu : in  STD_LOGIC;
					  load_carry : in  STD_LOGIC;
					  init_carry : in  STD_LOGIC;
					  Sel_UAL : in  STD_LOGIC_VECTOR (2 downto 0);
					  Data_out : out  STD_LOGIC_VECTOR (7 downto 0);
					  Carry : out  STD_LOGIC
                  );
          END COMPONENT;

			   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal Ce : std_logic := '0';
   signal DATA_in : std_logic_vector(7 downto 0) := (others => '0');
   signal load_accu : std_logic := '0';
	signal load_reg1 : std_logic :='0';
	signal load_carry : std_logic :='0';
	signal init_carry : std_logic :='0';
	signal Sel_UAL : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal DATA_out : std_logic_vector(7 downto 0);
	signal Carry : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;         

  BEGIN

  -- Component Instantiation
          uut: Processing_unit PORT MAP(
                  Data_in => Data_in,
					  clk  => clk,
					  Ce => Ce,
					  reset => reset,
					  load_reg1 => load_reg1,
					  load_accu  => load_accu,
					  load_carry => load_carry,
					  init_carry => init_carry,
					  Sel_UAL => Sel_UAL,
					  Data_out => Data_out,
					  Carry => Carry
          );


-- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 
  --  Test Bench Statements
     stim_proc : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

			Data_in <= "10000000";
			Ce <= '1';
			reset <= '1';
			init_carry <= '1';
			
			wait for 100 ns;
			
			reset <= '0';
			load_reg1 <='1';
			load_accu <='1';
			Sel_UAL <= "001";
			init_carry <= '0';
			load_carry <= '1';
			
			wait for 100 ns;
			
			load_reg1 <='0';
			load_accu <='0';
			Sel_UAL <= "001";
			load_carry <= '0';
			
			wait for 100 ns;
			
			load_accu <='1';
			
			wait for 100 ns;
			
			load_accu <= '0';
		   Sel_UAL <= "000";
			
			wait for 100 ns;
			
			

        wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
