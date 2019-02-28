----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2019 03:10:45 PM
-- Design Name: 
-- Module Name: fancy_counter_tb - tb
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

entity fancy_counter_tb is
end fancy_counter_tb;

architecture tb of fancy_counter_tb is

component fancy_counter is
 Port ( en, clk, clk_en : in std_logic;
       dir, ld, rst, updn : in std_logic;
       val : in std_logic_vector (3 downto 0);
       cnt : out std_logic_vector (3 downto 0));

end component;

  signal tb_clk, tb_ld, tb_rst, tb_updn : std_logic := '0';
  signal tb_en, tb_dir, tb_clk_en : std_logic := '1';
  signal tb_cnt : std_logic_vector(3 downto 0);
  signal tb_val : std_logic_vector(3 downto 0) := "0110";

begin
    fc: fancy_counter port map (clk => tb_clk, clk_en => tb_clk_en, en => tb_en,
                                dir => tb_dir, ld => tb_ld, rst => tb_rst, updn => tb_updn,
                                val => tb_val, cnt => tb_cnt);
 tb_dir <= '1';                              
    process begin
        tb_clk <= '0';
        wait for 4 ns;
        tb_clk <= '1';
        wait for 4 ns;
    end process;
    
--    process begin
--        tb_dir <= '0';
--        wait for 1 ms;
--        tb_updn <= '1';
--        wait for 5 ms;
--        tb_dir <= '1';
--        wait for 5 ms;
--        tb_updn <= '0';
--        wait for 30 ms;
--    end process;
    


end tb;
