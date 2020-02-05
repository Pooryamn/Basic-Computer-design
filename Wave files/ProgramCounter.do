onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /programcountertest/clk
add wave -noupdate -radix decimal /programcountertest/Data_in
add wave -noupdate /programcountertest/LD
add wave -noupdate /programcountertest/Inc
add wave -noupdate -radix decimal /programcountertest/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 179
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
WaveRestoreZoom {383347350 ps} {1017681878 ps}
