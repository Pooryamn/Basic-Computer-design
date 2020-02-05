onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /stackpointer_test/clk
add wave -noupdate /stackpointer_test/Reset
add wave -noupdate /stackpointer_test/Inc
add wave -noupdate /stackpointer_test/Dec
add wave -noupdate /stackpointer_test/Address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 176
configure wave -valuecolwidth 52
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
WaveRestoreZoom {549015410 ps} {1905181275 ps}
