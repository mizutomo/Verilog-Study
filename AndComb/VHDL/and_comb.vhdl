library IEEE;
use IEEE.std_logic_1164.all;

entity and_comb is
  port (
         A: in  std_logic;
         B: in  std_logic;
         Y: out std_logic
       );
end and_comb;

architecture RTL of and_comb is
begin
  Y <= A and B;
end RTL;
