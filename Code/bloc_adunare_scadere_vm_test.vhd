library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bloc_adunare_scadere_vm_test is
	-- Port ();
end bloc_adunare_scadere_vm_test;
architecture Behavioral of bloc_adunare_scadere_vm_test is
	signal X : STD_LOGIC_VECTOR (31 downto 0);
	signal Y : STD_LOGIC_VECTOR (31 downto 0);
	signal op : STD_LOGIC;
	signal rez : STD_LOGIC_VECTOR (31 downto 0);
begin
	DUT : entity WORK.bloc_adunare_scadere_vm
		port map(X => X, Y => Y, op => op, rez => rez);
		process
	begin
		X <= "01000000000011001100110011001101"; --2.2
		wait for 10 ns;
		Y <= "01000000000100110011001100110011"; --2.3
		wait for 10 ns;
		op <= '0'; --rezultat 4.5
		wait for 10 ns;
		wait for 10 ns;
		X <= "01000000110101100110011001100110"; --6.7
		wait for 10 ns;
		Y <= "00111111111100110011001100110011"; --1.9
		wait for 10 ns;
		op <= '1';
		wait for 10 ns; --rezultat 4.8
		wait for 10 ns;
		X <= "00111111100110011001100110011010"; --1.2
		wait for 10 ns;
		Y <= "11000000001001100110011001100110"; -- -2.6
		wait for 10 ns;
		op <= '0';
		wait for 10 ns; --rezultat -1.4
		wait for 10 ns;
		X <= "10111111110011001100110011001101"; -- -1.6
		wait for 10 ns;
		Y <= "10111111101001100110011001100110"; -- -1.3
		wait for 10 ns;
		op <= '0';
		wait for 10 ns; -- rezultat -2.9
		wait for 10 ns;
		X <= "01000010001000001100110011001101"; -- 40.2
		wait for 10 ns;
		Y <= "11000001111100001100110011001101"; -- -30.1
		wait for 10 ns;
		op <= '1';
		wait for 10 ns; -- rezultat 70.3
		wait for 10 ns;
		X <= "11000011110100100110111101011100"; -- -420.87
		wait for 10 ns;
		Y <= "01000011000000101100011110101110"; -- 130.78
		wait for 10 ns;
		op <= '1'; -- rezultat -551.65
		wait for 10 ns;
		X <= "11000010111101100011111011111010"; -- -123.123
		wait for 10 ns;
		Y <= "11000011111001000011101001011110"; -- -456.456
		wait for 10 ns;
		op <= '1';
		wait for 10 ns; -- rezultat 333.333
		wait for 10 ns;
		X <= "11000010010100000110011001100110"; -- -52.1
		wait for 10 ns;
		Y <= "01000010011100110011001100110011"; -- 60.8
		wait for 10 ns;
		op <= '0';
		wait for 10 ns; --rezultat 8.7
		wait;
	end process;
end Behavioral;