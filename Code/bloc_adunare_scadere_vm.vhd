library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bloc_adunare_scadere_vm is
	port (
		X : in STD_LOGIC_VECTOR(31 downto 0);
		Y : in STD_LOGIC_VECTOR(31 downto 0);
		op : in STD_LOGIC;
		rez : out STD_LOGIC_VECTOR(31 downto 0) 
	);
end bloc_adunare_scadere_vm;
architecture Behavioral of bloc_adunare_scadere_vm is
	signal final_rez, aux_X, aux_Y : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal mant_rez, shift : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
	signal exp, diff_exp, final_exp, count : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal comp, sign, oper : STD_LOGIC := '0';
begin
	process (X, Y, op) begin
	if X(31) = '0' and Y(31) = '0' then
		sign <= comp and op;
		oper <= op;
		aux_X <= X;
		aux_Y <= Y;
	elsif X(31) = '0' and Y(31) = '1' then
		if op = '1' then
			oper <= '0';
			sign <= '0';
		else
			oper <= '1';
			sign <= comp;
		end if;
		aux_X <= X;
		aux_Y <= Y;
	elsif X(31) = '1' and Y(31) = '0' then
		if op = '1' then
			oper <= '0';
			aux_X <= X;
			aux_Y <= Y;
			sign <= '1';
		else
			aux_X <= Y;
			aux_Y <= X;
			oper <= '1';
			sign <= comp;
		end if;
	else
		if op = '1' then
			oper <= op;
			aux_X <= Y;
			aux_Y <= X;
			sign <= not(comp);
		else
			aux_X <= X;
			aux_Y <= Y;
			oper <= '0';
			sign <= '1';
		end if;
	end if;
end process;
bloc_scadere_exp : entity WORK.bloc_scadere_exp
	port map(exp_X => aux_X(30 downto 23), exp_Y => aux_Y(30 downto 23), exponent => exp, diff_exp => diff_exp, bigger => comp);
	bloc_adunare_mant : entity WORK.bloc_adunare_mant
		port map(mant_X => aux_X(22 downto 0), mant_Y => aux_Y(22 downto 0), bigger => comp, op => oper, diff => diff_exp, mant_rez => mant_rez);
		bloc_normalizare_mant : entity WORK.bloc_normalizare
			port map(mant => mant_rez, exp => exp, sign => sign, same_sign => oper, rez => final_rez, final_exp => final_exp, shift => shift, count => count);
			rez <= final_rez;
end Behavioral;