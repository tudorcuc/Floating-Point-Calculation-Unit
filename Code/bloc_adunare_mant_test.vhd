library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bloc_adunare_mant_test is
	-- Port ();
end bloc_adunare_mant_test;
architecture Behavioral of bloc_adunare_mant_test is
	signal mant_X : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
	signal mant_Y : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
	signal bigger : STD_LOGIC := '0';
	signal op : STD_LOGIC := '0';
	signal diff : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal mant_rez : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
begin
	DUT : entity WORK.bloc_adunare_mant
		port map(mant_X => mant_X, mant_Y => mant_Y, op => op, diff => diff, mant_rez => mant_rez, bigger => bigger);
		process
		variable NrErori : integer := 0;
	begin
		wait for 10 ns;
		op <= '0';
		wait for 10 ns;
		diff <= "00000001";
		wait for 10 ns;
		mant_X <= "00000000001111000000100";
		wait for 10 ns;
		mant_Y <= "00000000000101000100100";
		wait for 10 ns;
		if mant_rez /= "110000000010001100010110" then
			NrErori := NrErori + 1;
		end if;
		wait for 10 ns;
		op <= '0';
		wait for 10 ns;
		diff <= "00000000";
		wait for 10 ns;
		mant_X <= "00000000000000000001000";
		wait for 10 ns;
		mant_Y <= "00000000000001100000110";
		wait for 10 ns;
		if mant_rez /= "1000000100110011101101110" then
			NrErori := NrErori + 1;
		end if;
		wait for 10 ns;
		op <= '1';
		wait for 10 ns;
		diff <= "00000100";
		wait for 10 ns;
		mant_X <= "00000001000000000001000";
		wait for 10 ns;
		mant_Y <= "00000000000011100000110";
		wait for 10 ns;
		if mant_rez /= "011110000111111110011000" then
			NrErori := NrErori + 1;
		end if;
		if nrErori = 0 then
			report "Succces";
		else
			report integer'IMAGE (NrErori) & " erori";
		end if;
		wait;
	end process;
end Behavioral;