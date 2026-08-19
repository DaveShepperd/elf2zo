DEFINES = -DEXTERNAL_PACKED_STRUCTS -DALIGNMENT=0 -DLINUX=2 -D_ISOC99_SOURCE
ELFLIB = /usr/include/libelf
INCS =  -I${ELFLIB}

#
# For Linux systems:
CFLAGS = $(INCS) $(DEFINES) -g -std=c99 -Wall -pedantic -ansi -m32
CPPFLAGS = $(INCS) $(DEFINES) -g -std=c++17 -Wall -ansi 
CC = gcc 
CPP = g++

#.slient:
	
%.o : %.c
	$(CC) $(CFLAGS) -c $<

%.o : %.cpp
	$(CPP) $(CPPFLAGS) -c $<

default: elf2zo rdelf

rdelf.o : rdelf.c
rdelf: rdelf.o
	$(CC) $(CFLAGS) -o $@ $< -lelf

elf2zo.o : elf2zo.c
elf2zo: elf2zo.o
	$(CC) $(CFLAGS) -o $@ $< $(ZLIB) -lz -lelf

clean:
	rm -f *.o rdelf elf2zo
