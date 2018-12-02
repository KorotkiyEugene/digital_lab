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

vlog  enc_param.v enc_param_tb.v

# Open testbench module for simulation

vsim -novopt work.testbench

# Add all testbench signals to waveform diagram

add wave -radix binary      /testbench/one_hot
add wave -radix unsigned    /testbench/bin
add wave                    /testbench/active

onbreak resume

# Run simulation
run -all

wave zoom full


