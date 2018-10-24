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

vlog  dec_7seg.v counter.v clock.v clock_tb.v

# Open testbench module for simulation

vsim -novopt work.clock_tb

# Add all testbench signals to waveform diagram

add wave /clock_tb/clock_inst/*

onbreak resume

# Run simulation
run -all

wave zoom full


