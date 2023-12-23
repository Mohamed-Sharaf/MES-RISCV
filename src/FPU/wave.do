onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fp_add_sub/Num_A
add wave -noupdate /fp_add_sub/Num_B
add wave -noupdate /fp_add_sub/A_S
add wave -noupdate /fp_add_sub/R_M
add wave -noupdate /fp_add_sub/Result
add wave -noupdate /fp_add_sub/case_Enable
add wave -noupdate /fp_add_sub/case_out
add wave -noupdate /fp_add_sub/vector_out
add wave -noupdate /fp_add_sub/pre_S_A
add wave -noupdate /fp_add_sub/pre_S_B
add wave -noupdate /fp_add_sub/pre_Comp
add wave -noupdate /fp_add_sub/pre_MA
add wave -noupdate /fp_add_sub/pre_MB
add wave -noupdate /fp_add_sub/pre_E
add wave -noupdate /fp_add_sub/adder_S_O
add wave -noupdate /fp_add_sub/adder_SUM
add wave -noupdate /fp_add_sub/adder_CARRY
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/S_G
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/Co
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/E_S
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/M_S
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/R_M
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/E
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/M
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/lzc_cnt
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/Shift
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/shift_out
add wave -noupdate /fp_add_sub/block_norm_vector/standardize/carry_shift
add wave -noupdate -divider add_sub
add wave -noupdate /fp_add_sub/block_adder/add_sub/A
add wave -noupdate /fp_add_sub/block_adder/add_sub/B
add wave -noupdate /fp_add_sub/block_adder/add_sub/AS
add wave -noupdate /fp_add_sub/block_adder/add_sub/SU
add wave -noupdate /fp_add_sub/block_adder/add_sub/CA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2315 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2163 ps} {2413 ps}
