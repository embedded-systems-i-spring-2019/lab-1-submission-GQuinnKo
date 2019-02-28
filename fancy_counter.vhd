----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 04:07:03 PM
-- Design Name: 
-- Module Name: fancy_counter - Behavioral
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

entity fancy_counter is
 Port ( en, clk, clk_en : in std_logic;
        dir, ld, rst, updn : in std_logic;
        val : in std_logic_vector (3 downto 0);
        cnt : out std_logic_vector (3 downto 0) := (others => '0'));
end fancy_counter;

architecture fc of fancy_counter is

signal count : std_logic_vector (3 downto 0) := "0000";
signal value : std_logic_vector (3 downto 0) := "1111";
signal direct : std_logic := '1';

begin

process(clk) begin

if rising_edge(clk) then
    if(en = '1') then

        if(rst = '1') then
            count <= (others => '0');
        end if;
        
        if(clk_en = '1') then
        
            if(rst = '1') then
                count <= (others => '0');
            end if;
            
            if(ld = '1') then
                value <= val;
            end if;
            
            if(updn = '1') then
                direct <= dir;
            end if;
            
            if(direct = '1') then
                if(count = value) then
                    count <= (others => '0');
                else
                    count <= std_logic_vector( unsigned(count) + 1);
                end if;
                                
            else
                if(count = "0000") then
                    count <= value;
                else
                    count <= std_logic_vector( unsigned(count) - 1);
                end if;
            end if;
            
            
        end if;
    end if;
end if;

cnt <= count;
end process;
end fc;
