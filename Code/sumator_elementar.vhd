library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity sumator_elementar is
	port (
		X : in STD_LOGIC;
		Y : in STD_LOGIC;
		Tin : in STD_LOGIC;
		S : out STD_LOGIC;
		Tout : out STD_LOGIC
	);
end sumator_elementar;
architecture Behavioral of sumator_elementar is
begin
	S <= X xor Y xor Tin;
	Tout <= (X and Y) or (Tin and (X or Y));
end Behavioral;