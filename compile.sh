#!/bin/bash
rm *.o
rm main
cc -m32 -c main.c
nasm -f elf32 removeNumber.s
nasm -f elf32 mirrorbmp8.s
cc -m32 -o main main.o removeNumber.o mirrorbmp8.o

