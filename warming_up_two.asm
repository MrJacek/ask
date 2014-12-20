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
	move $t1,$t0 #dst - skopiowanie do drugiego rejestru adresu buffor-a
nxtchr:	
	lbu  $t2 ,($t0) # pobranie pierwszego znaku z buffora i zapisanie go do rejestru
	addiu $t0,$t0,1 # zwiększenie rejestru o jeden (wskazanie na kolejny znak w stringu)
	bltu $t2,' ', fin # sprawdzenie czy to koniec string-u SPACJA ma większą wartość niż koniec stringu
	beq $t2,' ',nxtchr # sprawdzenie czy znak to SPACJA jeśli nie..
	sb $t2,($t1) # nad pisujemy w bufforze znak wskazywany przez 'wskaźnik' $t2 znakiem pod 'wskaźnikiem' $t1
	addiu $t1, $t1, 1 # zwiększamy wskaźnik na nową tablice żeby wskazywał na nowy element
	b nxtchr # pętla
fin:
	sb $zero, ($t1) # ustawienie zera na koniec nowego stringa
	la $a0, buf # przygotowanie nowego stringa
	li $v0, 4 # wybranie funkcji systemowej
	syscall # wywołanie 
	
	li $v0, 10 # wybranie zamknięcia programu
	syscall
