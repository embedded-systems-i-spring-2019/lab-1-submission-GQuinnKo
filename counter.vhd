library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (
  clk : in std_logic;
  newf : out std_logic
  --cnto : out std_logic_vector (25 downto 0)
);
end counter;

architecture cnt of counter is
  
  signal count : std_logic_vector (25 downto 0) := (others => '0');
begin
  --cnto <= count;
  process(clk) begin
    if rising_edge(clk) then
      count <= std_logic_vector( unsigned(count) + 1);
      
      if ( count="11101110011010110010100000") then
        newf <= '1';
        count <= (others => '0');
        
      else
        newf <= '0';
      end if;
        
    end if;
  end process;

end cnt;