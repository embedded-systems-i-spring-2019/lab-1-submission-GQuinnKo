----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 01:24:44 PM
-- Design Name: 
-- Module Name: debounce_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_tb is

end debounce_tb;

architecture tb of debounce_tb is

component debouncer is
 Port ( clk, btn : in std_logic;
        debounce: out std_logic);
end component;

  signal tb_clk : std_logic := '0';
  signal tb_btn : std_logic := '0';
  signal tb_deb : std_logic := '0';

begin

  deb: debouncer port map (clk => tb_clk, btn => tb_btn, debounce => tb_deb);

  process begin
      tb_clk <= '0';
      wait for 4 ns;
      tb_clk <= '1';
      wait for 4 ns;
  end process;

  process begin
      tb_btn <= '1';
      wait for  25 ms;
      tb_btn <= '0';
      wait for 10 ms;
  end process;
  
end tb;
