#!/bin/bash

cc -m32 -c main.c
nasm -f elf32 mystrlen.s
nasm -f elf32 invertstr.s
cc -m32 -o main main.o mystrlen.o invertstr.o

