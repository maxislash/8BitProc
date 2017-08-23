----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:44 04/30/2016 
-- Design Name: 
-- Module Name:    seven_seg_display - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_seg_display is
    Port ( Ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
--           a_bcd : in  STD_LOGIC_VECTOR (11 downto 0);
--           b_bcd : in  STD_LOGIC_VECTOR (11 downto 0);
			  res_bcd : in STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (7 downto 0);
           ssg : out  STD_LOGIC_VECTOR (7 downto 0));
end seven_seg_display;

architecture Behavioral of seven_seg_display is

signal compt : std_logic_vector (2 downto 0);
signal sig_cpt  : std_logic_vector (2 downto 0);
signal seven_seg : std_logic_vector (7 downto 0);
signal adr_int : std_logic_vector (7 downto 0);
signal dig : std_logic_vector (3 downto 0);
signal dp : std_logic;
signal cpt1 : integer range 0 to 130:=0;--33333:=0;
signal CE_display : std_logic;

signal diz_a : std_logic_vector(3 downto 0);
signal uni_a : std_logic_vector(3 downto 0);
signal diz_b : std_logic_vector(3 downto 0);
signal uni_b : std_logic_vector(3 downto 0);
signal diz_res : std_logic_vector(3 downto 0);
signal uni_res : std_logic_vector(3 downto 0);
signal egal : std_logic_vector(3 downto 0);
signal rien : std_logic_vector(3 downto 0);

signal cmpt_dec : integer range 0 to 10 := 0;

signal a_int : integer range 0 to 9 := 0;
signal b_int : integer range 0 to 9 := 0;
signal res_int : integer range 0 to 9 := 0;

begin


----------------------------Gestion anode 7seg ------------------------------------

--Frequence d'affichage
Display: process(clk)
begin
	if rising_edge(clk) then
		if  reset = '1' then
			cpt1<=0;
		else
			if cpt1= 130 then -- = 390625Khz/3Khz  130-- CHANGEMENT d'horloge 100MHz
				cpt1<=0;
				CE_display<='1';
			else
				cpt1<=cpt1 + 1;
				CE_display<='0';
			end if; 
		end if; 
	end if;
end process;

--AN SWITCHING CPT
p1: process (clk,reset) --
		 begin
		  if reset = '1' then compt <= "000";
		   elsif rising_edge(clk) then 
			  	if Ce ='1' and CE_display ='1' then 
					if  compt = "111" then compt <= "000";
								        else compt <= compt + 1;
					end if;
				end if;
		  end if;
 end process;
 
 sig_cpt <= compt;
 
 
-- EXTRACT DECADE AND UNIT
extract : process(clk, reset,res_bcd)
begin

	if reset = '1' then
		cmpt_dec <= 0;
		res_int <= 0;
		
	elsif rising_edge(clk) then
--		a_int <= to_integer(unsigned(a));
--		b_int <= to_integer(unsigned(b));
		res_int <= to_integer(unsigned(res_bcd));
		
		if res_int > 10 then
			res_int <= res_int - 10;
			cmpt_dec <= cmpt_dec + 1;
		else
			diz_res <= std_logic_vector(to_unsigned(cmpt_dec,4));
			uni_res <= std_logic_vector(to_unsigned(res_int,4));
		end if;
	end if;
	
end process;
			
			
			

anode : process(sig_cpt)
begin
		case sig_cpt is 
			when "000" 	=> 	adr_int <= "01111111";
			when "001" 	=> 	adr_int <= "10111111";
			when "010" 	=> 	adr_int <= "11011111";
			when "011" 	=> 	adr_int <= "11101111";
			when "100" 	=> 	adr_int <= "11110111";
			when "101" 	=> 	adr_int <= "11111011";
			when "110" 	=> 	adr_int <= "11111101";
			when "111" 	=> 	adr_int <= "11111110";
			when others => 	adr_int <= "11111111";
		end case;
			
end process;


--adr_int <= "01111111"		when 	sig_cpt = "000" else
--			  "10111111"		when 	sig_cpt = "001" else
--			  "11011111"		when	sig_cpt = "010" else
--			  "11101111"		when 	sig_cpt = "011" else
--			  "11110111" 		when 	sig_cpt = "100"	else 
--			  "11111011" 		when 	sig_cpt = "101"	else 
--			  "11111101"	   when 	sig_cpt = "110"	else 
--			  "11111110"	   when 	sig_cpt = "111"	else 
--			  "11111111";

-----------------------------------------------------------------------------------
----------------------------Gestion donnees 7seg ----------------------------------


		 
-- décommenter pour la Nexys4, et commenter le bloc d'au dessus (Spartan 3)		 


seven_seg <= (dp & "0000001") when dig = "0000" else     --pour Nexys4 -> dp A B C D E F G
				 (dp & "1001111") when dig = "0001" else
				 (dp & "0010010")	when dig = "0010" else
				 (dp & "0000110")	when dig = "0011" else
				 (dp & "1001100") when dig = "0100" else
				 (dp & "0100100") when dig = "0101" else
				 (dp & "0100000") when dig = "0110" else
				 (dp & "0001111") when dig = "0111" else
				 (dp & "0000000") when dig = "1000" else
				 (dp & "0000100") when dig = "1001" else
				 (dp & "0001000") when dig = "1010" else
				 (dp & "1100000") when dig = "1011" else
				 (dp & "0110001") when dig = "1100" else
				 (dp & "1000010") when dig = "1101" else
				 (dp & "0110000") when dig = "1110" else
				 (dp & "0111000") when dig = "1111" else
				 (dp & "1111111");
		 
--Mapping AN_DATA

--diz_a <= a_bcd(7 downto 4);
--uni_a <= a_bcd(3 downto 0);
--
--diz_b <= b_bcd(7 downto 4);
--uni_b <= b_bcd(3 downto 0);

diz_res <= res_bcd(7 downto 4);
uni_res <= res_bcd(3 downto 0);

egal <= "1111";
rien <= "1111";


dig <=-- diz_a    when adr_int = "01111111" else
		 --uni_a    when adr_int = "10111111" else
		 --diz_b    when adr_int = "11011111" else
		 --uni_b    when adr_int = "11101111" else	
		 --egal	    when adr_int = "11110111" else  
		 --rien     when adr_int = "11111011" else
		 diz_res  when adr_int = "11111101" else
		 uni_res  when adr_int = "11111110" else
		 "XXXX";
		 
--Dp: Point CDU.E
dp <= '0' when adr_int = "11111101" else
'1';

--MAP_output
ssg <= seven_seg;
an <= adr_int;


end Behavioral;

