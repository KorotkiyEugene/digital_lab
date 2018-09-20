// This program compiled with https://os.mbed.com/compiler
// You can import this project into mbed via the link:
// https://os.mbed.com/users/korotkiy_eugene/code/Nucleo_SPI_Sender/file/8b87ec0dce1b/main.cpp/

#include "mbed.h"
 
SPI spi(D11, D12, D13); // spi_mosi, spi_miso, spi_sck
DigitalOut cs(D10);     // spi_cs
 
int main() 
{    
    cs = 1;
    uint8_t val = 0;

    // Setup the spi for 8 bit data, low steady state clock,
    // first edge capture, with a 1MHz clock rate
    spi.format(8,0);
    spi.frequency(1000000);
 
    while (1) {
        wait(0.5);
        cs = 0;
        spi.write(val++);
        cs = 1;
    }
}
