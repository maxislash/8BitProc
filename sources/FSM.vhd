----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:27:59 04/22/2016 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

entity finite_state_machine is
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
end finite_state_machine;

architecture Behavioral of finite_state_machine is
type state_type is (INIT,FETCH_INS,DECODE,JCC,STORE,FETCH_OP,EXE_NOR_ADD,ERROR_S);  --type of state machine.
signal current_s,next_s: state_type;  --current and next state declaration.


constant opNOR: std_logic_vector := "00";
constant opADD : std_logic_vector := "01";
constant opSTA : std_logic_vector := "10";
constant opJCC : std_logic_vector := "11";

begin

---------------------------------------------------------------------------------------------------
--Change State

state_process: process (clk,reset)
begin

 if (reset='1') then
  current_s <= INIT;  --default state on reset.
elsif rising_edge(clk) then
  current_s <= next_s;   --state change.
end if;

end process;

---------------------------------------------------------------------------------------------------
--FSM logic process

logic_process: process (current_s, Data_in, carry)
begin

		OP_PC <= "00";
		Adr <= "000000";
		sel_Adr <= '0'; 
		sel_UAL <= "111";
		clear_Carry <= '1';
		load_Reg1 <= '0';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '0';
		R_W <= '0';
		init_Mem <= '1';
		next_s <= INIT;

  case current_s is
  
	when INIT =>        		--initialisation
	
		OP_PC <= "11"; -- OP_RESET
		Adr <= "000000"; -- Adr <= 0
		sel_Adr <= '0'; -- direct path to the memory (not by PC)
		sel_UAL <= "111";
		clear_Carry <= '1';
		load_Reg1 <= '0';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '0';
		R_W <= '0';
		init_Mem <= '1';
		
		next_s <= FETCH_INS;


	when FETCH_INS =>
	
		OP_PC <= "01"; --attention ici peut etre probleme de cycle d'horloge, à voir si l'incrémentation se fait direct ou au prochain cycle
		sel_Adr <= '0'; -- by the PC path
		sel_UAL <= "111";
		clear_Carry <= '0';
		load_Reg1 <= '0';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '1'; -- store the instruction read at corresponding address in RI
		R_W <= '0'; -- read memory
		init_Mem <= '0';
		
		next_s <= DECODE;

-- Instruction Decode
	when DECODE =>  
		
		OP_PC <= "00"; -- OP_NOTHING
		sel_Adr <= '1';
		sel_UAL <= "111";
		clear_Carry <= '0';
		load_Reg1 <= '0';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '0';
		R_W <= '0'; -- read memory
		init_Mem <= '0';

		
		case Data_in(7 downto 6) is --Data_in(7 downto 6) is
			when opNOR =>
				next_s <= FETCH_OP;
				
			when opADD =>
				next_s <= FETCH_OP;
				
			when opSTA =>
				next_s <= STORE;
			
			when opJCC =>
				next_s <= JCC;
				
			when others =>
				next_s <= ERROR_S;
				
		end case; 

-- Jump Completion
  when JCC =>
  
		OP_PC <= "00"; -- OP_NOTHING
		sel_Adr <= '1';
		sel_UAL <= "111";
		clear_Carry <= '0';
		load_Reg1 <= '0';
		load_Reg_Carry <= '1';
		load_Reg_Accu <= '0';
		R_W <= '0'; -- read memory
		init_Mem <= '0';

		
		if Carry = '0' then
			OP_PC <= "10"; -- OP_ASSIGN
			Adr <= Data_in(5 downto 0);
		else 
			clear_Carry <= '1';
		end if;
		
		next_s <= FETCH_INS;
	
-- Memory Access Store Word
  when STORE =>        
  
		OP_PC <= "00"; -- OP_NOTHING
		Adr <= Data_in(5 downto 0);
		sel_Adr <= '1';
		sel_UAL <= "111";
		clear_Carry <= '0';
		load_Reg1 <= '0';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '0'; 
		R_W <= '1';
		init_Mem <= '0';
		
		next_s <= FETCH_INS;

-- Fetch Operands
  when FETCH_OP =>         
	
		OP_PC <= "00"; -- OP_NOTHING
		sel_Adr <= '1';
		sel_UAL <= "111";
		clear_Carry <= '0';
		load_Reg1 <= '1';
		load_Reg_Accu <= '0';
		load_Reg_Carry <= '0';
		load_RegI <= '0'; 
		R_W <= '0';
		init_Mem <= '0';
		
		Adr <= Data_in(5 downto 0);
		
		next_s <= EXE_NOR_ADD;

-- Execute NOR or ADD operation
  when EXE_NOR_ADD =>         
    
		OP_PC <= "00"; -- OP_NOTHING
		sel_Adr <= '1';
		clear_Carry <= '0';
		load_Reg1 <= '0';
		load_Reg_Accu <= '1';
		load_Reg_Carry <= '1';
		load_RegI <= '0'; 
		R_W <= '0';
		init_Mem <= '0';
		
		if Data_in(7 downto 6) = opNOR then
			sel_UAL <= "000";
		else 
			sel_UAL <= "001";
		end if;
		
		next_s <= FETCH_INS;
		
	when ERROR_S =>
		Adr <= "XXXXXX";
		
	when others =>
		next_s <= ERROR_S;

  end case;
end process;

end Behavioral;

