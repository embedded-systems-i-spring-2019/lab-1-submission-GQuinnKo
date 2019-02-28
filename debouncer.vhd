----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 11:58:01 AM
-- Design Name: 
-- Module Name: debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
 Port ( clk, btn : in std_logic;
        debounce: out std_logic);
end debouncer;

architecture Behavioral of debouncer is

signal count : std_logic_vector (21 downto 0) := (others => '0');
signal samp : std_logic_vector (1 downto 0) := (others => '0');

begin
process(clk) begin
  if rising_edge(clk) then
  
    samp(1) <= samp(0);
    samp(0) <= btn;
    
    if(samp(1) = '1') then
        if(count /= "1001100010010110100000") then
            count <= std_logic_vector( unsigned(count) + 1);
        end if;
        
        if(count = "1001100010010110100000") then
            debounce <= '1';
        end if;
    else
        count <= (others => '0');
        debounce <= '0';
    end if;

 end if;

end process;

end Behavioral;
