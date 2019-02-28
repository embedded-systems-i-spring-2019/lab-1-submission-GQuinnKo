library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture tb of counter_tb is

  component counter
  port (
    clk : in std_logic;
   newf : out std_logic
   --cnto : out std_logic_vector (25 downto 0)
  );
  end component;

  signal tb_clk : std_logic := '0';
  signal tb_cnt : std_logic := '0';
  --signal test : std_logic_vector (25 downto 0) := (others => '0');
  
begin

  dut: counter port map (clk => tb_clk, newf => tb_cnt);

  process begin
      tb_clk <= '0';
      wait for 4 ns;
      tb_clk <= '1';
      wait for 4 ns;
  end process;
  
end tb;