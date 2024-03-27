library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity bloc_adunare_mant is
	port (
		mant_X : in STD_LOGIC_VECTOR(22 downto 0);
		mant_Y : in STD_LOGIC_VECTOR(22 downto 0);
		diff : in STD_LOGIC_VECTOR(7 downto 0);
		bigger : in STD_LOGIC;
		op : in STD_LOGIC;
		mant_rez : out STD_LOGIC_VECTOR(23 downto 0)
	);
end bloc_adunare_mant;
architecture Behavioral of bloc_adunare_mant is
	signal small_mant, mant_shift, aux_shift, big_mant, aux_rez : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	signal carry : STD_LOGIC := '0';
begin
	MUX_EXPONENTS : process (mant_X, mant_Y)
	begin
		if bigger = '0' then
			small_mant <= '1' & mant_Y;
			big_mant <= '1' & mant_X;
		else
			small_mant <= '1' & mant_X;
			big_mant <= '1' & mant_Y;
		end if;
	end process;
	ALINIERE_MANTISE_DEPLASARE_DREAPTA : process (small_mant, diff)
	begin
		case diff is
			when "00000000" => aux_shift <= small_mant;
			when "00000001" => aux_shift <= '0' & small_mant(23 downto 1);
			when "00000010" => aux_shift <= "00" & small_mant(23 downto 2);
			when "00000011" => aux_shift <= "000" & small_mant(23 downto 3);
			when "00000100" => aux_shift <= "0000" & small_mant(23 downto 4);
			when "00000101" => aux_shift <= "00000" & small_mant(23 downto 5);
			when "00000110" => aux_shift <= "000000" & small_mant(23 downto 6);
			when "00000111" => aux_shift <= "0000000" & small_mant(23 downto 7);
			when "00001000" => aux_shift <= "00000000" & small_mant(23 downto 8);
			when "00001001" => aux_shift <= "000000000" & small_mant(23 downto 9);
			when "00001010" => aux_shift <= "0000000000" & small_mant(23 downto 10);
			when "00001011" => aux_shift <= "00000000000" & small_mant(23 downto 11);
			when "00001100" => aux_shift <= "000000000000" & small_mant(23 downto 12);
			when "00001101" => aux_shift <= "0000000000000" & small_mant(23 downto 13);
			when "00001110" => aux_shift <= "00000000000000" & small_mant(23 downto 14);
			when "00001111" => aux_shift <= "000000000000000" & small_mant(23 downto 15);
			when "00010000" => aux_shift <= "0000000000000000" & small_mant(23 downto 16);
			when "00010001" => aux_shift <= "00000000000000000" & small_mant(23 downto 17);
			when "00010010" => aux_shift <= "000000000000000000" & small_mant(23 downto 18);
			when "00010011" => aux_shift <= "0000000000000000000" & small_mant(23 downto 19);
			when "00010100" => aux_shift <= "00000000000000000000" & small_mant(23 downto 20);
			when "00010101" => aux_shift <= "000000000000000000000" & small_mant(23 downto 21);
			when "00010110" => aux_shift <= "0000000000000000000000" & small_mant(23 downto 22);
			when "00010111" => aux_shift <= "00000000000000000000000" & small_mant(23);
			when others => aux_shift <= "000000000000000000000000";
		end case;
	end process;
	ALU_MANTISE : entity WORK.ALU
			generic map(n => 24)
			port map(X => big_mant, Y => mant_shift, op => op, R => aux_rez, Tout => carry);
			mant_rez <= aux_rez;
			mant_shift <= aux_shift;
end Behavioral;