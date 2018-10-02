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

vlog  simple_spi.v spi_tb.v

# Open testbench module for simulation

vsim -novopt work.spi_tb

# Add all testbench signals to waveform diagram

add wave /spi_tb/*
add wave /spi_tb/spi_inst/*

onbreak resume

# Run simulation
run -all

wave zoom full


