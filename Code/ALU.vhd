library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ALU is
	generic (n : integer);
	port (
		op : in STD_LOGIC;
		X : in STD_LOGIC_VECTOR(n - 1 downto 0);
		Y : in STD_LOGIC_VECTOR(n - 1 downto 0);
		R : out STD_LOGIC_VECTOR(n - 1 downto 0);
		Tout : out STD_LOGIC
	);
end ALU;
architecture Behavioral of ALU is
	signal newY : STD_LOGIC_VECTOR(n - 1 downto 0);
	signal newTin : STD_LOGIC := '0';
begin
	process (op, Y)
	begin
		if op = '1' then --se face scadere
			newY <= not (Y); --ideea complementului fata de 2
			newTin <= '1';
		else --se face adunarea
			newY <= Y;
			newTin <= '0';
		end if;
	end process;
	sumator : entity WORK.sumator_nbiti
			generic map(n => n)
			port map(X => X, Y => newY, Tin => newTin, S => R, Tout => Tout);
end Behavioral;