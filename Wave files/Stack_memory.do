onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /stack_memory_test/clk
add wave -noupdate /stack_memory_test/Address
add wave -noupdate /stack_memory_test/Data_in
add wave -noupdate /stack_memory_test/Push
add wave -noupdate /stack_memory_test/Pop
add wave -noupdate /stack_memory_test/Data_out
add wave -noupdate /stack_memory_test/Full
add wave -noupdate /stack_memory_test/Empty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49998750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {948028311 ps} {1368028311 ps}
