----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/21 12:51:48
-- Design Name: 
-- Module Name: tb_fsmd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_fsmd is
--  Port ( );
end tb_fsmd;

architecture Behavioral of tb_fsmd is
    component fsmd is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           start : in std_logic;
           n : in STD_LOGIC_VECTOR (5 downto 0);
           ready : out std_logic;
           fib : out STD_LOGIC_VECTOR (42 downto 0));
    end component;
    
    --input 
    signal CLK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal start : std_logic := '0';
    signal n : std_logic_vector(5 downto 0) := "000000";
    
    --output 
    signal ready : std_logic := '0';
    signal fib : std_logic_vector(42 downto 0) := (others => '0');
    
    constant per : time := 63 ns;
    
begin
uut: fsmd
port map(
CLK => CLK,
RESET => RESET,
start => start,
n => n,
ready => ready,
fib => fib
);

clk_pro: process
begin
    CLK <= '0';
    wait for per/2;
    CLK <= '1';
    wait for per/2;
end process;

reset_pro: process
begin
    RESET <= '1';
    for i in 1 to 2 loop
    wait until CLK = '1';
    end loop;
    RESET <= '0';
    wait;
end process;

in_pro: process
begin
    start <= '1';
    n <= "111111";
    wait for 10*per;
    start <= '0';
    wait;
end process;

end Behavioral;
