onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registers_test/clk
add wave -noupdate /registers_test/IO
add wave -noupdate /registers_test/Sel_D
add wave -noupdate /registers_test/Data_in
add wave -noupdate /registers_test/Sel_A
add wave -noupdate /registers_test/Out_A
add wave -noupdate /registers_test/Sel_B
add wave -noupdate /registers_test/Out_B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1842506609 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 159
configure wave -valuecolwidth 66
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 50
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {1498456260 ps} {2153580886 ps}
