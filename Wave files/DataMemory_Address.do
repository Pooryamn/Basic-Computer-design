onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dm_address_test/clk
add wave -noupdate /dm_address_test/LD
add wave -noupdate -radix decimal /dm_address_test/Data_in
add wave -noupdate -radix decimal /dm_address_test/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 180
configure wave -valuecolwidth 38
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {376929601 ps} {1059172249 ps}
