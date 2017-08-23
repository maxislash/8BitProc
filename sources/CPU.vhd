----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
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

entity CPU is
    Port ( Clk 					 : in  STD_LOGIC;
--	        Ce					    : in  STD_LOGIC;
           Reset 					 : in  STD_LOGIC;  
--			  Adr						 : out  STD_LOGIC_VECTOR (5 downto 0);
--			  data_men_in			 : out  STD_LOGIC_VECTOR (7 downto 0);
--			  data_men_out			 : out  STD_LOGIC_VECTOR (7 downto 0);
			  AN1  : out std_logic;
	 		  AN2  : out std_logic;
	 		  AN3  : out std_logic;
	 		  AN4  : out std_logic;
			  Sseg						 : out STD_LOGIC_VECTOR (7 downto 0)
			 );
end CPU;

architecture Behavioral of CPU is

component Control_Unit
    Port ( Clk 					 : in  STD_LOGIC;
	        Ce					    : in  STD_LOGIC;
           Reset 					 : in  STD_LOGIC;
			  Carry 					 : in  STD_LOGIC;
           Data_In 				 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Adr						 : out  STD_LOGIC_VECTOR (5 downto 0);
           clear_Carry 			 : out  STD_LOGIC;
			  load_Reg1 			 : out  STD_LOGIC;
           load_Reg_Accu 		 : out  STD_LOGIC;
			  load_Reg_Carry 		 : out  STD_LOGIC;
           sel_UAL 				 : out  STD_LOGIC_VECTOR(2 downto 0);
           w_Mem 				    : out  STD_LOGIC;
			  init_Mem 			 : out  STD_LOGIC);
end component;

component Processing_unit
    Port ( Data_in 		: in  STD_LOGIC_VECTOR (7 downto 0);
           clk 			: in  STD_LOGIC;
			  Ce			   : in  STD_LOGIC;
           reset 			: in  STD_LOGIC;
           load_reg1 	: in  STD_LOGIC;
           load_accu 	: in  STD_LOGIC;
           load_carry 	: in  STD_LOGIC;
           init_carry 	: in  STD_LOGIC;
           Sel_UAL		: in  STD_LOGIC_VECTOR (2 downto 0);
           Data_out 		: out  STD_LOGIC_VECTOR (7 downto 0);
           Carry 			: out  STD_LOGIC);
end component;

component RAM_SP_64_8 
    Port ( ADD      		: in  STD_LOGIC_VECTOR (5 downto 0);
           DATA_IN  		: in  STD_LOGIC_VECTOR (7 downto 0);
           R_W      		: in  STD_LOGIC;
           ENABLE   		: in  STD_LOGIC;
			  clk          : in  STD_LOGIC;
			  Ce			   : in  STD_LOGIC;
--			  a				: out STD_LOGIC_VECTOR (7 downto 0);
--			  b 				: out STD_LOGIC_VECTOR (7 downto 0);
--			  res				: out STD_LOGIC_VECTOR (7 downto 0);
			  Adr : out STD_LOGIC_VECTOR(5 downto 0);
			  Data : out STD_LOGIC_VECTOR(7 downto 0);
           DATA_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0)
			 );
end component;

component acces_carte 
    port (
	 		 clk : in std_logic;
	 		 reset  : in std_logic;
          AdrLSB : in std_logic_vector(3 downto 0);
          AdrMSB : in std_logic_vector(1 downto 0);
          DataLSB: in std_logic_vector(3 downto 0);
          DataMSB: in std_logic_vector(3 downto 0);

          DataInMem: in std_logic_vector(7 downto 0);

	 		 ce1s  : out std_logic;
	 		 ce25M : out std_logic;
	 		 AN1  : out std_logic;
	 		 AN2  : out std_logic;
	 		 AN3  : out std_logic;
	 		 AN4  : out std_logic;
	 		 Sseg : out std_logic_vector(7 downto 0);
	 		 LED  : out std_logic_vector(7 downto 0);
			 LEDg : out std_logic
				);
end component;

signal ce1s 				: STD_LOGIC;
signal ce25M				: STD_LOGIC;
signal LEDg 				: STD_LOGIC;
signal LED	 				: STD_LOGIC_VECTOR (7 downto 0);


signal Data_Mem_Unit		: STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit_Mem		: STD_LOGIC_VECTOR (7 downto 0);
signal sig_Adr          : STD_LOGIC_VECTOR (5 downto 0);
signal Carry 		 		: STD_LOGIC;
signal clear_Carry		: STD_LOGIC;
signal init_Mem			: STD_LOGIC;
signal load_Reg1			: STD_LOGIC;
signal load_Reg_Accu 	: STD_LOGIC;
signal load_Reg_Carry 	: STD_LOGIC;
signal sel_UAL_UT			: STD_LOGIC_VECTOR (2 downto 0);
signal w_Mem  				: STD_LOGIC;

--signal a_bin : STD_LOGIC_VECTOR(7 downto 0);
--signal b_bin : STD_LOGIC_VECTOR(7 downto 0);
signal res_bin : STD_LOGIC_VECTOR(7 downto 0);

signal Adr_RAM  : STD_LOGIC_VECTOR (5 downto 0);
signal Data_RAM : STD_LOGIC_VECTOR (7 downto 0);

signal  Adr 			 :  STD_LOGIC_VECTOR (5 downto 0);
signal  data_men_in	 :  STD_LOGIC_VECTOR (7 downto 0);
signal  data_men_out	 :  STD_LOGIC_VECTOR (7 downto 0);

signal RAZ : STD_LOGIC;
signal Ce : STD_LOGIC;

begin

RAZ <= not(Reset);
Ce <= '1';

UC  				 : Control_Unit port map (Clk, 
                                         Ce,
                                         RAZ, 
                                         Carry, 
                                         Data_Mem_Unit, 
                                         sig_Adr, 
                                         clear_Carry, 
                                         load_Reg1, 
                                         load_Reg_Accu, 
                                         load_Reg_Carry, 
                                         sel_UAL_UT, 
                                         w_Mem,
                                         init_Mem);
													  
UT  				 : Processing_unit port map (Data_Mem_Unit, 
														  Clk ,
                                            Ce,														  
														  RAZ, 
														  load_Reg1, 
														  load_Reg_Accu, 
														  load_Reg_Carry,
														  clear_Carry, 
														  sel_UAL_UT, 
														  Data_Unit_Mem,	
														  Carry);
														  
UM  				 : RAM_SP_64_8 port map (sig_Adr, 
													 Data_Unit_Mem, 
													 w_Mem, 
													 init_Mem,
													 Clk,
													 Ce,
													 Adr_RAM,
													 Data_RAM,
													 Data_Mem_Unit);		
													 
acces_carte_a : acces_carte port map (Clk,
												  RAZ,
												  Adr_RAM(3 downto 0),
												  Adr_RAM(5 downto 4),
												  Data_RAM(3 downto 0),
												  Data_RAM(7 downto 4),
												  Data_Unit_Mem,
												  ce1s,
												  ce25M,
												  AN1,
												  AN2,
												  AN3,
												  AN4,
												  Sseg,
												  LED,
												  LEDg
													);
															  


Adr <= sig_Adr;
data_men_in  <= Data_Unit_Mem;
data_men_out <= Data_Mem_Unit;	

											 

end Behavioral;

