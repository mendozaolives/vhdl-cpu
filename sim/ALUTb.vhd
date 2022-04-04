library ieee;
use ieee.std_logic_1164.all;

entity ALUTb is
end entity;

architecture sim of ALUTb is 
    -- artificial AC and DR
    signal testDR : std_logic_vector(7 downto 0);
    signal testAC : std_logic_vector(7 downto 0);

    -- would be from control unit, ALUS7 downto ALUS1; separated by units they control
    signal ALUS : std_logic_vector (6 downto 0) := '0' & "00" & '0' & "00" & '0';

    -- stores result of ALU operation
    signal result : std_logic_vector(7 downto 0);

begin
    ALU : entity work.ALU(rtl) port map(
        fromDR => testDR,
        fromAC => testAC,
        ALUS => ALUS,
        output => result);
    
    process is
    begin
        testAC <= x"A5";
        testDR <= x"F0";

        -- test logical functions

        -- AND
        ALUS <= '1' & "00" & 'X' & "XX" & 'X';
        wait for 10 ns;
        
        -- OR
        ALUS <= '1' & "10" & 'X' & "XX" & 'X';
        wait for 10 ns;
        
        -- XOR
        ALUS <= '1' & "01" & 'X' & "XX" & 'X';
        wait for 10 ns;
        
        -- NOT AC
        ALUS <= '1' & "11" & 'X' & "XX" & 'X';
        wait for 10 ns;

        -- test arithmetic functions
        ALUS <= '0' & "XX" & '0' & "00" & '0';
        wait for 10 ns;

    end process;
end architecture;