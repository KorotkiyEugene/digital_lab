###########################
# Simple modelsim do file #
###########################

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog  barrel_shifter_right.v barrel_shifter_right_tb.v

# Open testbench module for simulation

vsim -novopt work.testbench

# Add all testbench signals to waveform diagram

add wave -radix unsigned    /testbench/i_sa
add wave -radix binary      /testbench/i_st
add wave -radix binary      /testbench/i_data
add wave -radix binary      /testbench/o_data

onbreak resume

# Run simulation
run -all

wave zoom full


