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

vlog  dec_7seg.v dec_7seg_tb.v

# Open testbench module for simulation

vsim -novopt work.dec_7seg_tb

# Add all testbench signals to waveform diagram

add wave /dec_7seg_tb/bin_code
add wave -radix binary /dec_7seg_tb/segments

onbreak resume

# Run simulation
run -all

wave zoom full


