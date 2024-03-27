library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
entity ALU_test is
	-- Port ();
end ALU_test;
architecture Behavioral of ALU_test is
	signal op : STD_LOGIC;
	signal X : STD_LOGIC_VECTOR(23 downto 0);
	signal Y : STD_LOGIC_VECTOR(23 downto 0);
	signal R : STD_LOGIC_VECTOR(23 downto 0);
	signal Tout : STD_LOGIC;
begin
	DUT : entity WORK.ALU
			generic map(n => 24)
			port map(op => op, X => X, Y => Y, R => R, Tout => Tout);
			process
			variable NrErori : integer := 0;
		begin
			op <= '0';
			wait for 200 ns;
			for i in 147896 to 147899 loop
				X <= CONV_STD_LOGIC_VECTOR(i, 24);
				Y <= CONV_STD_LOGIC_VECTOR(i, 24);
				wait for 200 ns;
				if R /= CONV_STD_LOGIC_VECTOR(i + i, 24) then
					nrErori := nrErori + 1;
				end if;
			end loop;
			op <= '1';
			wait for 200 ns;
			for i in 1478963 to 1478966 loop
				X <= CONV_STD_LOGIC_VECTOR(i, 24);
				Y <= CONV_STD_LOGIC_VECTOR(i - 3, 24);
				wait for 200 ns;
				if R /= CONV_STD_LOGIC_VECTOR(3, 24) then
					nrErori := nrErori + 1;
				end if;
			end loop;
			if nrErori = 0 then
				report "Succces";
			else
				report integer'IMAGE (NrErori) & " erori";
			end if;
			wait;
		end process;
end Behavioral;