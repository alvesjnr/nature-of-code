
all: 
	gcc -g -O2 -fPIC -c nvector.c -o nvector.o
	cython vector.pyx
	gcc -g -O2 -fPIC -c -I/usr/include/python2.7 vector.c -o vector.o
	gcc -shared -lm -o vector.so vector.o nvector.o 


