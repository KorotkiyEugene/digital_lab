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
vlog  counter.v counter_tb.v

# Open counter_tb module for simulation
vsim -novopt work.counter_tb

# Add all testbench signals to waveform diagram
add wave sim:/counter_tb/*

# Run simulation
run -all
