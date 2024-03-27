library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bloc_scadere_exp is
	port (
		exp_X : in STD_LOGIC_VECTOR(7 downto 0);
		exp_Y : in STD_LOGIC_VECTOR(7 downto 0);
		diff_exp : out STD_LOGIC_VECTOR(7 downto 0);
		exponent : out STD_LOGIC_VECTOR(7 downto 0);
		bigger : out STD_LOGIC
	);
end bloc_scadere_exp;
architecture Behavioral of bloc_scadere_exp is
	signal bigger_exp : STD_LOGIC_VECTOR(7 downto 0);
	signal smaller_exp : STD_LOGIC_VECTOR(7 downto 0);
	signal t : STD_LOGIC := '0';
begin
	mux_exponents : process (exp_X, exp_Y)
	begin
		if exp_X >= exp_Y then
			bigger_exp <= exp_X;
			smaller_exp <= exp_Y;
			bigger <= '0'; --exp_X is the bigger exp
			exponent <= exp_X;
		else
			bigger_exp <= exp_Y;
			smaller_exp <= exp_X;
			bigger <= '1';--exp_Y is the bigger exp
			exponent <= exp_Y;
		end if;
	end process;
	alu_exponents : entity WORK.ALU
			generic map(n => 8)
			port map(X => bigger_exp, Y => smaller_exp, op => '1', R => diff_exp, Tout => t);
end Behavioral;