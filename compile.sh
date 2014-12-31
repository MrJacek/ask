#!/bin/bash
rm *.o
rm main
cc -m32 -c main.c
nasm -f elf32 removeNumber.s
cc -m32 -o main main.o removeNumber.o

