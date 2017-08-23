----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:42 04/07/2016 
-- Design Name: 
-- Module Name:    Processing_unit - Behavioral 
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

entity Processing_unit is
    Port ( Data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load_reg1 : in  STD_LOGIC;
           load_accu : in  STD_LOGIC;
           load_carry : in  STD_LOGIC;
           init_carry : in  STD_LOGIC;
           Sel_UAL : in  STD_LOGIC_VECTOR (2 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           Carry : out  STD_LOGIC);
end Processing_unit;

architecture Behavioral of Processing_unit is

component UAL
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Sel_UAL : in  STD_LOGIC_VECTOR (2 downto 0);
           CARRY : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component registre
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           load_reg : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component bascule
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           clear : in  STD_LOGIC;
			  load_bascule : in STD_LOGIC;
           DATA_IN : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC);
end component;

signal carry_in : STD_LOGIC;
signal UAL_out : STD_LOGIC_VECTOR(7 downto 0);
signal R1_out : STD_LOGIC_VECTOR(7 downto 0);
signal ACCU_out : STD_LOGIC_VECTOR(7 downto 0);

begin

ALU  				 : UAL port map( 	ACCU_out,
											R1_out,
												Sel_UAL,
												carry_in,
												UAL_out);

CAR					 : bascule port map( reset,
												clk,
												Ce,
												init_carry,
												load_carry,
												carry_in,
												Carry);

R1					 : registre port map( clk,
												reset,
												Ce,
												Data_in,
												load_reg1,
												R1_out);
		
AC					 : registre port map( clk,
												reset,
												Ce,
												UAL_out,
												load_accu,
												ACCU_out);

Data_out <= ACCU_out;

end Behavioral;

