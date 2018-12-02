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

vlog  bin8_to_bcd.v bin8_to_bcd_tb.v

# Open testbench module for simulation

vsim -novopt work.testbench

# Add all testbench signals to waveform diagram

add wave -radix unsigned    /testbench/bin
add wave -radix hex         /testbench/bcd

onbreak resume

# Run simulation
run -all

wave zoom full


