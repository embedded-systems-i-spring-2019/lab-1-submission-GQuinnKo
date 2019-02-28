----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2019 07:48:46 PM
-- Design Name: 
-- Module Name: top_design - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- CLOCK DIVIDER COMPONENT
entity clock_div is
port (
  clk_in : in std_logic;
  div : out std_logic
);
end clock_div;

architecture cnt of clock_div is
  signal count1 : std_logic_vector (25 downto 0) := (others => '0');
begin
process(clk_in) begin
  if rising_edge(clk_in) then
    count1 <= std_logic_vector( unsigned(count1) + 1);
    
    if ( count1="11101110011010110010100000") then
      div <= '1';
      count1 <= (others => '0');
      
    else
      div <= '0';
    end if;
      
  end if;
end process;
end cnt;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--DEBOUNCER COMPONENT
entity debouncer is
 Port ( clkd, btn : in std_logic;
        debounce: out std_logic);
end debouncer;

architecture deb of debouncer is
signal count2 : std_logic_vector (21 downto 0) := (others => '0');
signal samp : std_logic_vector (1 downto 0) := (others => '0');

begin
process(clkd) begin
  if rising_edge(clkd) then
  
    samp(1) <= samp(0);
    samp(0) <= btn;
    
    if(samp(1) = '1') then
        if(count2 /= "1001100010010110100000") then
            count2 <= std_logic_vector( unsigned(count2) + 1);
        end if;
        
        if(count2 = "1001100010010110100000") then
            debounce <= '1';
        end if;
    else
        count2 <= (others => '0');
        debounce <= '0';
    end if;

 end if;

end process;
end deb;


--FANCY COUNTER COMPONENT
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_counter is
 Port ( en, clkf, clk_en : in std_logic;
        dir, ld, rst, updn : in std_logic;
        val : in std_logic_vector (3 downto 0);
        cnt : out std_logic_vector (3 downto 0));
end fancy_counter;

architecture fc of fancy_counter is

signal count3 : std_logic_vector (3 downto 0) := "0000";
signal value : std_logic_vector (3 downto 0) := "1111";
signal direct : std_logic := '1';

begin

process(clkf) begin

if rising_edge(clkf) then
    if(en = '1') then

        if(rst = '1') then
            count3 <= (others => '0');
        end if;
        
        if(clk_en = '1') then
        
            if(rst = '1') then
                count3 <= (others => '0');
            end if;
            
            if(ld = '1') then
                value <= val;
            end if;
            
            if(updn = '1') then
                direct <= dir;
            end if;
            
            if(direct = '1') then
                if(count3 = value) then
                    count3 <= (others => '0');
                else
                    count3 <= std_logic_vector( unsigned(count3) + 1);
                end if;
                                
            else
                if(count3 = "0000") then
                    count3 <= value;
                else
                    count3 <= std_logic_vector( unsigned(count3) - 1);
                end if;
            end if;
            
            
        end if;
    end if;
end if;

cnt <= count3;
end process;
end fc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_design is
  Port ( button, swt : in std_logic_vector(3 downto 0);
         clk : in std_logic;
         led : out std_logic_vector(3 downto 0));
end top_design;

architecture td of top_design is

component clock_div is
port (
  clk_in : in std_logic;
  div : out std_logic
);
end component;

component debouncer is
 Port ( clkd, btn : in std_logic;
        debounce: out std_logic);
end component;

component fancy_counter is
 Port ( en, clkf, clk_en : in std_logic;
        dir, ld, rst, updn : in std_logic;
        val : in std_logic_vector (3 downto 0);
        cnt : out std_logic_vector (3 downto 0));
end component;

signal dbnc : std_logic_vector (3 downto 0);
signal temp_div : std_logic;

begin


u1: debouncer
port map ( btn => button(0),
           clkd => clk,
           debounce => dbnc(0));

u2: debouncer
port map ( btn => button(1),
           clkd => clk,
           debounce => dbnc(1));
           
u3: debouncer
port map ( btn => button(2),
           clkd => clk,
           debounce => dbnc(2));

u4: debouncer
port map ( btn => button(3),
           clkd => clk,
           debounce => dbnc(3));
u5: clock_div
port map ( clk_in => clk,
           div => temp_div);

u6: fancy_counter
port map ( clkf => clk,
           clk_en => temp_div,
           rst => dbnc(0),
           en => dbnc(1),
           updn => dbnc(2),
           ld => dbnc(3),
           dir => swt(0),
           val => swt,
           cnt => led);
           
end td;
