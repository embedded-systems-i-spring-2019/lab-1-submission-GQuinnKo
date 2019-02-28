----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2019 01:32:20 PM
-- Design Name: 
-- Module Name: divider_top - Behavioral
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

entity clock_div is
port (
  clk_in : in std_logic;
  div : out std_logic
);
end clock_div;

architecture cnt of clock_div is
  signal count : std_logic_vector (25 downto 0) := (others => '0');
begin
process(clk_in) begin
  if rising_edge(clk_in) then
    count <= std_logic_vector( unsigned(count) + 1);
    
    if ( count="11101110011010110010100000") then
      div <= '1';
      count <= (others => '0');
      
    else
      div <= '0';
    end if;
      
  end if;
end process;

end cnt;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divider_top is
  Port ( clk : in std_logic;
         Q : out std_logic);
end divider_top;

architecture Behavioral of divider_top is

component clock_div is
port (
  clk_in : in std_logic;
  div : out std_logic
);
end component;

signal D, CE : std_logic := '0';

begin

di: clock_div
port map ( clk_in => clk,
           div => CE);

reg: process(clk)
begin
    if (rising_edge(clk)) then
        if(CE = '1') then
            D <= not D;
        end if;
    end if;
    end process;
    Q <= D;

end Behavioral;
