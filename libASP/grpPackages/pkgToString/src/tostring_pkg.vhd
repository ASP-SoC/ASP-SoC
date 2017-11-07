library ieee;
use ieee.std_logic_1164.all;

package ToStringPkg is

    function to_character (
      a               : std_ulogic
      ) return character;

    function to_string (
      a                 : std_ulogic_vector
      ) return string;

end ToStringPkg;

package body ToStringPkg is

    ---------------------------------------------------------------------------
    -- converting a std_ulogic_vector to a string
    ---------------------------------------------------------------------------
    function to_character (
      a               : std_ulogic
      ) return character is
      variable a_char : character;
    begin
      case a is
        when 'U' => a_char := 'U';
        when 'X' => a_char := 'X';
        when '0' => a_char := '0';
        when '1' => a_char := '1';
        when 'W' => a_char := 'W';
        when 'L' => a_char := 'L';
        when 'H' => a_char := 'H';
        when 'Z' => a_char := 'Z';
        when '-' => a_char := '-';
      end case;
      return a_char;
    end to_character;

    function to_string (
      a                 : std_ulogic_vector
      ) return string is
      constant a_length : integer                                := a'length;
      variable a_str    : string(1 to a'length);
      variable a_copy   : std_ulogic_vector(a'length-1 downto 0) := a;
      -- a copy is made of a because a may not use a 0-based index,
      -- it could be 7 downto 4, for example
    begin
      -- convert each bit of the vector to a char
      for i in 1 to a'length loop
        -- conversion is done by assigning from the msb of a_copy from the
        -- left downto the lsb so that the textual "image" of a_str follows
        -- that of a_copy and thus a itself. Without the length-i trick
        -- a_copy would effectively be reversed onto a_str as a_str is declared
        -- with a "to" range as opposed to a_copy's downto range.

        a_str(i) := to_character(std_ulogic(a_copy(a_length-i)));
      end loop;
      return a_str;
    end;

end ToStringPkg;
