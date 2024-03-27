library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
entity bloc_normalizare is
	port (
		mant : in STD_LOGIC_VECTOR(23 downto 0);
		same_sign : in STD_LOGIC;
		sign : in STD_LOGIC;
		exp : in STD_LOGIC_VECTOR(7 downto 0);
		final_exp : out STD_LOGIC_VECTOR (7 downto 0);
		count : out STD_LOGIC_VECTOR (7 downto 0);
		shift : out STD_LOGIC_VECTOR(23 downto 0);
		rez : out STD_LOGIC_VECTOR(31 downto 0)
	);
end bloc_normalizare;
architecture Behavioral of bloc_normalizare is
	signal shifted, aux_shifted : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	signal exp_count, exp_aux, expp : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal rez_aux : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal cout : STD_LOGIC;
begin
	process (same_sign, mant)
	variable pos : integer;
	begin
		if same_sign = '0' then
			shifted <= '0' & mant(23 downto 1);
			aux_shifted <= shifted;
			exp_aux <= exp + 1;
		else
			for i in 0 to 23 loop
				if mant(i) = '1' then
					pos := i;
				end if;
			end loop;
			case pos is
				when 23 => shifted <= mant;
				exp_count <= "00000000";
				when 22 => shifted <= mant(22 downto 0) & '0';
				exp_count <= "00000001";
				when 21 => shifted <= mant(21 downto 0) & "00";
				exp_count <= "00000010";
				when 20 => shifted <= mant(20 downto 0) & "000";
				exp_count <= "00000011";
				when 19 => shifted <= mant(19 downto 0) & "0000";
				exp_count <= "00000100";
				when 18 => shifted <= mant(18 downto 0) & "00000";
				exp_count <= "00000101";
				when 17 => shifted <= mant(17 downto 0) & "000000";
				exp_count <= "00000110";
				when 16 => shifted <= mant(16 downto 0) & "0000000";
				exp_count <= "00000111";
				when 15 => shifted <= mant(15 downto 0) & "00000000";
				exp_count <= "00001000";
				when 14 => shifted <= mant(14 downto 0) & "000000000";
				exp_count <= "00001001";
				when 13 => shifted <= mant(13 downto 0) & "0000000000";
				exp_count <= "00001010";
				when 12 => shifted <= mant(12 downto 0) & "00000000000";
				exp_count <= "00001011";
				when 11 => shifted <= mant(11 downto 0) & "000000000000";
				exp_count <= "00001100";
				when 10 => shifted <= mant(10 downto 0) & "0000000000000";
				exp_count <= "00001101";
				when 9 => shifted <= mant(9 downto 0) & "00000000000000";
				exp_count <= "00001110";
				when 8 => shifted <= mant(8 downto 0) & "000000000000000";
				exp_count <= "00001111";
				when 7 => shifted <= mant(7 downto 0) & "0000000000000000";
				exp_count <= "00100000";
				when 6 => shifted <= mant(6 downto 0) & "00000000000000000";
				exp_count <= "00100001";
				when 5 => shifted <= mant(5 downto 0) & "000000000000000000";
				exp_count <= "00100010";
				when 4 => shifted <= mant(4 downto 0) & "0000000000000000000";
				exp_count <= "00100011";
				when 3 => shifted <= mant(3 downto 0) & "00000000000000000000";
				exp_count <= "00100100";
				when 2 => shifted <= mant(2 downto 0) & "000000000000000000000";
				exp_count <= "00100101";
				when 1 => shifted <= mant(1 downto 0) & "0000000000000000000000";
				exp_count <= "00100110";
				when others => shifted <= "000000000000000000000000";
				exp_count <= "00100111";
			end case;
			aux_shifted <= shifted;
		end if;
	end process;
	ADD_SUB : entity WORK.ALU
			generic map(8)
			port map(same_sign, exp, exp_count, expp, cout);
			final_exp <= expp;
			count <= exp_count;
			shift <= shifted;
			rez_aux(31) <= sign;
			rez_aux(30 downto 23) <= expp when same_sign = '1' else
			                         exp_aux;
			rez_aux(22 downto 0) <= shifted(22 downto 0);
			rez <= rez_aux;
end Behavioral;