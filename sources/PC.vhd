----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:00 04/22/2016 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_counter is
    Port ( clk : in  STD_LOGIC;
           ADR_IN : in  STD_LOGIC_VECTOR (5 downto 0);
			  OPCODE : in  STD_LOGIC_VECTOR (1 downto 0);
           ADR_OUT : out  STD_LOGIC_VECTOR (5 downto 0));
end program_counter;

architecture Behavioral of program_counter is

constant PC_OP_NOTHING: std_logic_vector(1 downto 0):= "00";
constant PC_OP_INCREMENT: std_logic_vector(1 downto 0):= "01";
constant PC_OP_ASSIGN: std_logic_vector(1 downto 0):= "10";
constant PC_OP_RESET: std_logic_vector(1 downto 0):= "11";

signal current_pc: std_logic_vector(5 downto 0) := (others => '0');
signal next_pc: std_logic_vector(5 downto 0) := (others => '0');

begin

change_pc : process (clk)
begin
    if rising_edge(clk) then
			current_pc <= next_pc;
    end if;
end process;

logic_pc : process(OPCODE,current_pc,ADR_IN)
begin

      case OPCODE is
        when PC_OP_NOTHING =>  -- do nothing, keep PC the same
			 next_pc <= current_pc;
        when PC_OP_INCREMENT =>   -- increment
          next_pc <= std_logic_vector(unsigned(current_pc) + 1);
        when PC_OP_ASSIGN =>    -- assign
          next_pc <= ADR_IN;
        when PC_OP_RESET =>     -- Reset
          next_pc <= (others => '0');
        when others =>
			 next_pc <= current_pc;	
      end case;
		
end process;

ADR_OUT <= current_pc;

end Behavioral;

