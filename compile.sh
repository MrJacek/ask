#!/bin/bash
rm *.o
rm main
cc -m32 -c main.c
nasm -f elf32 mirrorbmp1.asm
cc -m32 -o main main.o mirrorbmp1.o

