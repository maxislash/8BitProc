----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:11 04/07/2016 
-- Design Name: 
-- Module Name:    Control_unit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_unit is
    Port ( clk : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Carry : in  STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           Adr : out  STD_LOGIC_VECTOR (5 downto 0);
           clear_Carry : out  STD_LOGIC;
           load_Reg1 : out  STD_LOGIC;
           load_Reg_Accu : out  STD_LOGIC;
           load_Reg_Carry : out  STD_LOGIC;
           sel_UAL : out  STD_LOGIC_VECTOR(2 downto 0);
           w_Mem : out  STD_LOGIC;
			  init_Mem : out STD_LOGIC);
end Control_unit;

architecture Behavioral of Control_unit is

component registre
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           load_reg : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component program_counter 
    Port ( clk : in  STD_LOGIC;
           ADR_IN : in  STD_LOGIC_VECTOR (5 downto 0);
			  OPCODE : in  STD_LOGIC_VECTOR (1 downto 0);
           ADR_OUT : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component finite_state_machine
	 Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           Carry : in  STD_LOGIC;
			  Data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           OP_PC : out  STD_LOGIC_VECTOR (1 downto 0);
           Adr : out  STD_LOGIC_VECTOR (5 downto 0);
			  sel_Adr : out  STD_LOGIC;
           sel_UAL : out  STD_LOGIC_VECTOR(2 downto 0);
           clear_Carry : out  STD_LOGIC;
           load_Reg1 : out  STD_LOGIC;
           load_Reg_Accu : out  STD_LOGIC;
           load_Reg_Carry : out  STD_LOGIC;
           load_RegI : out  STD_LOGIC;
			  R_W : out STD_LOGIC;
			  init_Mem : out STD_LOGIC);
end component;

component mux_2to1_6bit
    Port ( INPUT1 : in  STD_LOGIC_VECTOR (5 downto 0);
           INPUT0 : in  STD_LOGIC_VECTOR (5 downto 0);
           SEL : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (5 downto 0));
end component;


signal RI_out : STD_LOGIC_VECTOR (7 downto 0);
signal load_regI : STD_LOGIC;

signal PC_OPCODE : STD_LOGIC_VECTOR(1 downto 0);
signal ADR_PC : STD_LOGIC_VECTOR(5 downto 0);

signal ADR_FSM : STD_LOGIC_VECTOR(5 downto 0);
signal sel_Adr : STD_LOGIC;


begin

RI					 : registre port map( clk,
												reset,
												Ce,
												Data_in,
												load_regI,
												RI_out);
										
PC					 : program_counter port map( clk,
														 ADR_FSM,
														 PC_OPCODE,
														 ADR_PC);
														 

FSM				 : finite_state_machine port map( clk,
																reset,
																Ce,
																Carry,
																RI_out,
																PC_OPCODE,
																ADR_FSM,
																sel_Adr,
																sel_UAL,
																clear_Carry,
																load_Reg1,
																load_Reg_Accu,
																load_Reg_Carry,
																load_RegI,
																w_Mem,
																init_Mem);
																
MUX_ADR			 : mux_2to1_6bit port map( ADR_FSM,
													  ADR_PC,
													  sel_Adr,
													  Adr);
																



end Behavioral;

