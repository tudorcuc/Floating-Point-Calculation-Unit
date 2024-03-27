library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity main_bloc is
	port (
		signal clk : in STD_LOGIC;
		signal btn : in STD_LOGIC_VECTOR(4 downto 0);
		signal sw : in STD_LOGIC_VECTOR(15 downto 0);
		signal cat : out STD_LOGIC_VECTOR(7 downto 0);
		signal an : out STD_LOGIC_VECTOR(7 downto 0) 
	);
end main_bloc;
architecture Behavioral of main_bloc is
	signal data_X, data_Y, data : std_logic_vector(31 downto 0);
begin
	vm : entity WORK.bloc_adunare_scadere_vm
		port map(X => data_X, Y => data_Y, op => '0', rez => data);
end Behavioral;