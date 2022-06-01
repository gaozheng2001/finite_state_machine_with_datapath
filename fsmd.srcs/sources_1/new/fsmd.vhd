----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/21 10:56:32
-- Design Name: 
-- Module Name: fsmd - Behavioral
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsmd is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           start : in std_logic;
           n : in STD_LOGIC_VECTOR (5 downto 0);
           ready : out std_logic;
           fib : out STD_LOGIC_VECTOR (42 downto 0));
end fsmd;

architecture Behavioral of fsmd is
type state_type is(isready, contro, done);
signal state, state_next : state_type;
signal t0_next, t1_next, t0_reg, t1_reg : std_logic_vector(42 downto 0);
signal fib_n_next, fib_n_reg : std_logic_vector(5 downto 0);
begin
clk_pro: process(CLK, RESET)is
begin
    if RESET = '1' then
        state <= isready;
        t0_reg <= (others => '0');
        t1_reg <= (others => '0');
        fib_n_reg <= n;
    elsif (CLK'event and clk = '1')then
        state <= state_next;
        t0_reg <= t0_next;
        t1_reg <= t1_next;
        fib_n_reg <= fib_n_next;
    end if;
end process clk_pro;
-- combinational circuit
process(state, state_next, t0_reg, t0_next, t1_reg, t1_next, fib_n_reg, fib_n_next) is
begin
    state_next <= state;
    t0_next <= t0_reg;
    t1_next <=t1_reg;
    fib_n_next <= fib_n_reg;
    ready <= '0';
    case state is 
    when isready => 
        if start = '1' then
            t0_next <= (others => '0');
            t1_next <= (0 => '1', others => '0');
            state_next <= contro;
        else 
            state_next <= isready;
        end if;
        ready <= '1';
    when contro => 
        if fib_n_reg = 0 then
            t1_next <= (others => '0');
            state_next <= done;
        elsif fib_n_reg = 1 then
            state_next <= done;
        else
            t0_next <= t1_reg;
            t1_next <= t0_reg + t1_reg;
            fib_n_next <= fib_n_reg - 1;
            state_next <= contro;
        end if;
    when done => 
        state_next <= isready;
    end case;
end process;
fib <= t1_reg;
end Behavioral;
