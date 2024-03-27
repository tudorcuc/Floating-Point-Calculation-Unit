library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity bloc_scadere_exp_tb is
	-- Port ();
end bloc_scadere_exp_tb;
architecture Behavioral of bloc_scadere_exp_tb is
	signal exp_X : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal exp_Y : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal diff_exp, exponent : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal bigger : STD_LOGIC := '0';
begin
	DUT : entity WORK.bloc_scadere_exp
		port map(exp_X => exp_X, exp_Y => exp_Y, diff_exp => diff_exp, exponent => exponent, bigger => bigger);
		process
		variable nrErrors : integer := 0;
	begin
		wait for 10 ns;
		exp_X <= CONV_STD_LOGIC_VECTOR(34, 8);
		wait for 10 ns;
		exp_Y <= CONV_STD_LOGIC_VECTOR(30, 8);
		wait for 10 ns;
		if diff_exp /= CONV_STD_LOGIC_VECTOR(4, 8) or bigger = '1' or exponent /= exp_X then
			nrErrors := nrErrors + 1;
		end if;
		wait for 10 ns;
		exp_X <= CONV_STD_LOGIC_VECTOR(21, 8);
		wait for 10 ns;
		exp_Y <= CONV_STD_LOGIC_VECTOR(45, 8);
		wait for 10 ns;
		if diff_exp /= CONV_STD_LOGIC_VECTOR(24, 8) or bigger = '0' or exponent /= exp_Y then
			nrErrors := nrErrors + 1;
		end if;
		if nrErrors = 0 then
			report "Succces";
		else
			report integer'IMAGE (nrErrors) & " erori";
		end if;
		wait;
	end process;
end Behavioral;