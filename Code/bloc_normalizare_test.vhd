library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
entity bloc_normalizare_test is
	-- Port ();
end bloc_normalizare_test;
architecture Behavioral of bloc_normalizare_test is
	signal mant, shift : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	signal same_sign, sign : STD_LOGIC := '0';
	signal exp, count, final_exp : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal rez : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
	DUT : entity WORK.bloc_normalizare
		port map(mant => mant, exp => exp, same_sign => same_sign, sign => sign, rez => rez, count => count, final_exp => final_exp, shift => shift);
		process
		variable NrErori : integer := 0;
	begin
		wait for 10 ns;
		mant <= "000101000000000000000000";
		wait for 10 ns;
		exp <= "00000110";
		wait for 10 ns;
		sign <= '0';
		wait for 10 ns;
		same_sign <= '1';
		wait for 10 ns;
		if rez /= "00000001101000000000000000000000" then
			nrErori := nrErori + 1;
		end if;
		wait for 10 ns;
		mant <= "001000001000000000001000";
		wait for 10 ns;
		exp <= "00000100";
		wait for 10 ns;
		sign <= '0';
		wait for 10 ns;
		same_sign <= '0';
		wait for 10 ns;
		if rez /= "00000010100100000100000000000100" then
			nrErori := nrErori + 1;
		end if;
		if nrErori = 0 then
			report "Succces";
		else
			report integer'IMAGE (NrErori) & " erori";
		end if;
		wait;
	end process;
end Behavioral;