library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity sumator_nbiti is
	generic (n : integer);
	port (
		X : in STD_LOGIC_VECTOR(n - 1 downto 0);
		Y : in STD_LOGIC_VECTOR(n - 1 downto 0);
		Tin : in STD_LOGIC;
		S : out STD_LOGIC_VECTOR(n - 1 downto 0);
		Tout : out STD_LOGIC
	);
end sumator_nbiti;
architecture Behavioral of sumator_nbiti is
	signal T : STD_LOGIC_VECTOR(n downto 0);
begin
	T(0) <= Tin;
	sumator : for i in 0 to n - 1 generate
		SE : entity WORK.sumator_elementar
			port map(X => X(i), Y => Y(i), Tin => T(i), S => S(i), Tout => T(i + 1));
	end generate;
	Tout <= T(n);
end Behavioral;