	.data
hello: 
	.asciiz "Hello world\n"
	
	.text
	.globl main
main:
	la $a0, hello
	li $v0, 4
	syscall
	la $v0, 10
	syscall
	