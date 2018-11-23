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
vlog  simple_pwm.v simple_pwm_tb.v

# Open testbench module for simulation
vsim -novopt work.testbench

# Add all testbench signals to waveform diagram
add wave sim:/testbench/*
add wave sim:/testbench/simple_pwm_inst/cnt_ff

onbreak resume

# Run simulation
run -all

wave zoom full
