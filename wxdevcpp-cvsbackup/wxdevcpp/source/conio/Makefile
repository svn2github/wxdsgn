CC=gcc
AR=ar
RANLIB=ranlib

libconio.a: conio.o
	$(AR) r libconio.a conio.o
	$(RANLIB) libconio.a

conio.o: conio.c
	$(CC) -Wall -O2 -s -c conio.c -o conio.o

clean:
	rm -f *.o libconio.a
