onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_ram_test/clk
add wave -noupdate -radix unsigned /data_ram_test/address
add wave -noupdate -radix unsigned /data_ram_test/Data_in
add wave -noupdate /data_ram_test/R_W
add wave -noupdate -radix unsigned /data_ram_test/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {475344828 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
configure wave -valuecolwidth 86
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
WaveRestoreZoom {0 ps} {520344828 ps}
