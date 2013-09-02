library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

library std;
use std.textio.all;

entity and_comb_tb is
end and_comb_tb;

architecture SIM of and_comb_tb is
  component and_comb
    port (
           A: in  std_logic;
           B: in  std_logic;
           Y: out std_logic
         );
  end component;

  procedure display(
    A: in std_logic;
    B: in std_logic;
    Y: in std_logic
  ) is
    variable LO: line;
  begin
    write(LO, string'("A="));
    write(LO, std_logic'image(A));
    write(LO, string'(" B="));
    write(LO, std_logic'image(B));
    write(LO, string'(" Y="));
    write(LO, std_logic'image(Y));
    writeline(output, LO);
  end display;

  constant CYCLE: Time:= 100 ns;
  signal SA, SB, SY: std_logic;

begin
  AndComb: and_comb port map (SA, SB, SY);

  process begin
                    SA <= '0'; SB <= '0';
    wait for CYCLE; SA <= '1'; SB <= '0';
    wait for CYCLE; SA <= '0'; SB <= '1';
    wait for CYCLE; SA <= '1'; SB <= '1';
    wait for CYCLE;
    assert false report "end of simulation" severity failure;
  end process;

  process begin
    wait for  50 ns; display(SA, SB, SY);
    wait for 100 ns; display(SA, SB, SY);
    wait for 100 ns; display(SA, SB, SY);
    wait for 100 ns; display(SA, SB, SY);
  end process;
end SIM;

configuration AND_COMB_CFG of and_comb_tb is
  for SIM
  end for;
end AND_COMB_CFG;
