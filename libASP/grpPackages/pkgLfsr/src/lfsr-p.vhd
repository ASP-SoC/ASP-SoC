-------------------------------------------------------------------------------
-- package for lfsr next state determination
-- the determination use the maximum feedback taps
-- the sequence will cycle through all values from 0 to 2^n-1
-- the lfsr should start with state (others => '0')
-- and the state (others => '1') is not allowed,
-- because the lfsr will stuck in this state
-- implementation:
-- must be implementet with n downto 1 because a lfsr has no zero tap
-- lfsr_state : std_ulogic_vector(n downto 1);
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package lfsr is

  -- determinate next lfsr state
  function lfsr_nx_state (
    constant lfsr_state : std_ulogic_vector)
    return std_ulogic_vector;

end package lfsr;

package body lfsr is

  function lfsr_nx_state (
    constant lfsr_state : std_ulogic_vector)
    return std_ulogic_vector is

    -- feedback taps
    -- table from xilinx app note 052
    constant lfsr_fb_table_len_c : natural := 168;
    type lfsr_fb_table_t is array (
      3 to lfsr_fb_table_len_c,
      1 to lfsr_fb_table_len_c) of boolean;
    constant lfsr_fb_table_c : lfsr_fb_table_t := (
      (3 | 2                       => true, others => false),
      (4 | 3                       => true, others => false),
      (5 | 3                       => true, others => false),
      (6 | 5                       => true, others => false),
      (7 | 6                       => true, others => false),
      (8 | 6 | 5 | 4               => true, others => false),
      (9 | 5                       => true, others => false),
      (10 | 7                      => true, others => false),
      (11 | 9                      => true, others => false),
      (12 | 6 | 4 | 1              => true, others => false),
      (13 | 4 | 3 | 1              => true, others => false),
      (14 | 5 | 3 | 1              => true, others => false),
      (15 | 14                     => true, others => false),
      (16 | 15 | 13 | 4            => true, others => false),
      (17 | 14                     => true, others => false),
      (18 | 11                     => true, others => false),
      (19 | 6 | 2 | 1              => true, others => false),
      (20 | 17                     => true, others => false),
      (21 | 19                     => true, others => false),
      (22 | 21                     => true, others => false),
      (23 | 18                     => true, others => false),
      (24 | 23 | 22 | 17           => true, others => false),
      (25 | 22                     => true, others => false),
      (26 | 6 | 2 | 1              => true, others => false),
      (27 | 5 | 2 | 1              => true, others => false),
      (28 | 25                     => true, others => false),
      (29 | 27                     => true, others => false),
      (30 | 6 | 4 | 1              => true, others => false),
      (31 | 28                     => true, others => false),
      (32 | 22 | 2 | 1             => true, others => false),
      (33 | 20                     => true, others => false),
      (34 | 27 | 2 | 1             => true, others => false),
      (35 | 33                     => true, others => false),
      (36 | 25                     => true, others => false),
      (37 | 5 | 4 | 3 | 2 | 1      => true, others => false),
      (38 | 6 | 5 | 1              => true, others => false),
      (39 | 35                     => true, others => false),
      (40 | 38 | 21 | 19           => true, others => false),
      (41 | 38                     => true, others => false),
      (42 | 41 | 20 | 19           => true, others => false),
      (43 | 42 | 38 | 37           => true, others => false),
      (44 | 43 | 18 | 17           => true, others => false),
      (45 | 44 | 42 | 41           => true, others => false),
      (46 | 45 | 26 | 25           => true, others => false),
      (47 | 42                     => true, others => false),
      (48 | 47 | 21 | 20           => true, others => false),
      (49 | 40                     => true, others => false),
      (50 | 49 | 24 | 23           => true, others => false),
      (51 | 50 | 36 | 35           => true, others => false),
      (52 | 49                     => true, others => false),
      (53 | 52 | 38 | 37           => true, others => false),
      (54 | 53 | 18 | 17           => true, others => false),
      (55 | 31                     => true, others => false),
      (56 | 55 | 35 | 34           => true, others => false),
      (57 | 50                     => true, others => false),
      (58 | 39                     => true, others => false),
      (59 | 58 | 38 | 37           => true, others => false),
      (60 | 59                     => true, others => false),
      (61 | 60 | 46 | 45           => true, others => false),
      (62 | 61 | 6 | 5             => true, others => false),
      (63 | 62                     => true, others => false),
      (64 | 63 | 61 | 60           => true, others => false),
      (65 | 47                     => true, others => false),
      (66 | 65 | 57 | 56           => true, others => false),
      (67 | 66 | 58 | 57           => true, others => false),
      (68 | 59                     => true, others => false),
      (69 | 67 | 42 | 40           => true, others => false),
      (70 | 69 | 55 | 54           => true, others => false),
      (71 | 65                     => true, others => false),
      (72 | 66 | 25 | 19           => true, others => false),
      (73 | 48                     => true, others => false),
      (74 | 73 | 59 | 58           => true, others => false),
      (75 | 74 | 65 | 64           => true, others => false),
      (76 | 75 | 41 | 40           => true, others => false),
      (77 | 76 | 47 | 46           => true, others => false),
      (78 | 77 | 59 | 58           => true, others => false),
      (79 | 70                     => true, others => false),
      (80 | 79 | 43 | 42           => true, others => false),
      (81 | 77                     => true, others => false),
      (82 | 79 | 47 | 44           => true, others => false),
      (83 | 82 | 38 | 37           => true, others => false),
      (84 | 71                     => true, others => false),
      (85 | 84 | 58 | 57           => true, others => false),
      (86 | 85 | 74 | 73           => true, others => false),
      (87 | 74                     => true, others => false),
      (88 | 87 | 17 | 16           => true, others => false),
      (89 | 51                     => true, others => false),
      (90 | 89 | 72 | 71           => true, others => false),
      (91 | 90 | 8 | 7             => true, others => false),
      (92 | 91 | 80 | 79           => true, others => false),
      (93 | 91                     => true, others => false),
      (94 | 73                     => true, others => false),
      (95 | 84                     => true, others => false),
      (96 | 94 | 49 | 47           => true, others => false),
      (97 | 91                     => true, others => false),
      (98 | 87                     => true, others => false),
      (99 | 97 | 54 | 52           => true, others => false),
      (100 | 63                    => true, others => false),
      (101 | 100 | 95 | 94         => true, others => false),
      (102 | 101 | 36 | 35         => true, others => false),
      (103 | 94                    => true, others => false),
      (104 | 103 | 94 | 93         => true, others => false),
      (105 | 89                    => true, others => false),
      (106 | 91                    => true, others => false),
      (107 | 105 | 44 | 42         => true, others => false),
      (108 | 77                    => true, others => false),
      (109 | 108 | 103 | 102       => true, others => false),
      (110 | 109 | 98 | 97         => true, others => false),
      (111 | 101                   => true, others => false),
      (112 | 110 | 69 | 67         => true, others => false),
      (113 | 104                   => true, others => false),
      (114 | 113 | 33 | 32         => true, others => false),
      (115 | 114 | 101 | 100       => true, others => false),
      (116 | 115 | 46 | 45         => true, others => false),
      (117 | 115 | 99 | 97         => true, others => false),
      (118 | 85                    => true, others => false),
      (119 | 111                   => true, others => false),
      (120 | 113 | 9 | 2           => true, others => false),
      (121 | 103                   => true, others => false),
      (122 | 131 | 63 | 62         => true, others => false),
      (123 | 121                   => true, others => false),
      (124 | 87                    => true, others => false),
      (125 | 124 | 18 | 17         => true, others => false),
      (126 | 125 | 90 | 89         => true, others => false),
      (127 | 126                   => true, others => false),
      (128 | 126 | 101 | 99        => true, others => false),
      (129 | 124                   => true, others => false),
      (130 | 127                   => true, others => false),
      (131 | 130 | 84 | 83         => true, others => false),
      (132 | 103                   => true, others => false),
      (133 | 132 | 82 | 81         => true, others => false),
      (134 | 77                    => true, others => false),
      (135 | 124                   => true, others => false),
      (136 | 125 | 11 | 10         => true, others => false),
      (137 | 116                   => true, others => false),
      (138 | 137 | 131 | 130       => true, others => false),
      (139 | 136 | 134 | 131       => true, others => false),
      (140 | 111                   => true, others => false),
      (141 | 140 | 110 | 109       => true, others => false),
      (142 | 121                   => true, others => false),
      (143 | 142 | 123 | 122       => true, others => false),
      (144 | 143 | 75 | 74         => true, others => false),
      (145 | 93                    => true, others => false),
      (146 | 145 | 87 | 86         => true, others => false),
      (147 | 146 | 110 | 109       => true, others => false),
      (148 | 121                   => true, others => false),
      (149 | 148 | 40 | 39         => true, others => false),
      (150 | 97                    => true, others => false),
      (151 | 148                   => true, others => false),
      (152 | 151 | 87 | 86         => true, others => false),
      (153 | 152                   => true, others => false),
      (154 | 152 | 27 | 25         => true, others => false),
      (155 | 154 | 124 | 123       => true, others => false),
      (156 | 155 | 41 | 40         => true, others => false),
      (157 | 156 | 131 | 130       => true, others => false),
      (158 | 157 | 132 | 131       => true, others => false),
      (159 | 128                   => true, others => false),
      (160 | 159 | 142 | 141       => true, others => false),
      (161 | 143                   => true, others => false),
      (162 | 161 | 75 | 74         => true, others => false),
      (163 | 162 | 161 | 104 | 103 => true, others => false),
      (164 | 163 | 151 | 150       => true, others => false),
      (165 | 164 | 135 | 134       => true, others => false),
      (166 | 165 | 128 | 127       => true, others => false),
      (167 | 161                   => true, others => false),
      (168 | 166 | 153 | 151       => true, others => false));

    constant xnor_neutral_elem_c : std_ulogic := '1';

    variable fb_v : std_ulogic := xnor_neutral_elem_c;

  begin
    assert (lfsr_state'right = 1)
      report "LFSR needs to be indexed like n downto 1"
      severity failure;

    assert (lfsr_state'left <= lfsr_fb_table_len_c)
      report "Maximum LFSR length is 168!"
      severity failure;

    assert (lfsr_state'left >= 3)
      report "Minimum LFSR length is 3!"
      severity failure;

    -- Since the xnor function is commutative and associative 
    for idx in lfsr_state'range loop
      if lfsr_fb_table_c(lfsr_state'length, idx) then
        fb_v := fb_v xnor lfsr_state(idx);
      end if;
    end loop;

    -- Shift the computed bit into the LFSR. This is the next state of the LFSR
    return lfsr_state(lfsr_state'length-1 downto 1) & fb_v;

  end function lfsr_nx_state;

end package body lfsr;
