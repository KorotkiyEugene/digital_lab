#include "SPI.h"

int spi_cs = 8; // using digital pin 8 for SPI slave chip select
 
void setup()
{
    pinMode(spi_cs, OUTPUT);
    digitalWrite(spi_cs, HIGH);
    SPI.begin();
    SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0));
}
 
void loop()
{
    for(uint8_t val = 0; val < 256; val++) {
        delay(500);
        digitalWrite(spi_cs, LOW);
        SPI.transfer(val);
        digitalWrite(spi_cs, HIGH);
    }
}
