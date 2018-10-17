TARGET = sin_table_gen
CFLAGS = -g -Wall -std=gnu99
LDFLAGS = -g -Wall
LIBS = -lm
CC = gcc

build: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(LDFLAGS) $^ -o $@ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean

clean:
	rm -f $(TARGET) *.a *.o
