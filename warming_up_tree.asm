	.data
buf: 
	.space 100
	
	.text
	.globl main
main:	 
	# pobranie string-a z konsoli
	la $a0, buf # parametr funckji systemowej - bufor w którym będzie zapisany string
	li $a1, 100 # dułgośc maksymalnego stringa który można pobrać z konsoli
	li $v0, 8 # wybranie funckji systemowej pobrania  wejscia konsoli
	syscall # wywołanie funkcji wybranej powyżej
	
	la $t0, buf # src - zapisanie do rejestru adresu buffor-a
	li $s1,0
	move $t1,$t0 #dst - skopiowanie do drugiego rejestru adresu buffor-a
	move $t4,$zero
	li $t6,10
	move $t7,$zero

nxtchr:	
	lbu  $t1 ,($t0) # pobranie pierwszego znaku z buffora i zapisanie go do rejestru
	bltu $t1,' ', usun # sprawdzenie czy to koniec string-u SPACJA ma większą wartość niż koniec stringu 
	bltu $t1,':',cyfra
niecyfra:
	li $s0,0
	bgt $t4,$t7,wiekszy
nxtchr2:
	addiu $t0,$t0,1 # zwiększenie rejestru o jeden (wskazanie na kolejny znak w stringu)
	b nxtchr # pętla 
	
cyfra:
	bgtu $t1,'/',zapiszpoczatek
	b niecyfra
zapiszpoczatek:
	beq $s0,0,z1
	b dodaj
z1:
	li $s0,1
	move $s1,$t0
	b dodaj
dodaj:	
	
	subiu $t1,$t1,48
	multu $t6,$t4
	addu $t4,$v0,$t1
	b nxtchr2
	
wiekszy:
	move $t5,$s1
	move $t7,$t4
	b nxtchr2

wiekszy2:
	move $t5,$s1
	move $t7,$t4
	b nxtchr3

usun:
	la $t0, buf
	move $t1,$t0 #dst - skopiowanie do drugiego rejestru adresu buffor-a
	li $s0,0
	bgt $t4,$t7,wiekszy2
nxtchr3:	# zaczynamy wypisywan
	lbu  $t2 ,($t0) # pobranie pierwszego znaku z buffora i zapisanie go do rejestru
	move $t3,$t0
	addiu $t0,$t0,1 # zwiększenie rejestru o jeden (wskazanie na kolejny znak w stringu)
	bltu $t2,' ', fin # sprawdzenie czy to koniec string-u SPACJA ma większą wartość niż koniec stringu 
	beq $t3,$t5, mojacyfra
	bltu $t2,':',cyfra10
niecyfra2:
	li $s0,0
	sb $t2,($t1) # nad pisujemy w bufforze znak wskazywany przez 'wskaźnikiem' $t2 znakiem pod 'wskaźnikiem' $t1
	addiu $t1, $t1, 1 # zwiększamy wskaźnik na nową tablice żeby wskazywał na nowy element
	b nxtchr3 # pętla

mojacyfra:
	li $s0,1	
	b nxtchr3

cyfra10:
	bgtu $t1,'/',mojacyfra2
	b nxtchr3	
mojacyfra2:
	beq $s0,1, nxtchr3
	b niecyfra2
	
fin:
	sb $zero, ($t1) # ustawienie zera na koniec nowego stringa
	la $a0, buf # przygotowanie nowego stringa
	li $v0, 4 # wybranie funkcji systemowej
	syscall # wywołanie 

	li $v0, 10 # wybranie zamknięcia programu
	syscall
