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
	la $t1, buf
findEnd:
	lbu  $t3 ,($t1) # pobranie pierwszego znaku z buffora i zapisanie go do rejestru
	addiu $t1,$t1,1 # zwiększenie rejestru o jeden (wskazanie na kolejny znak w stringu)
	bltu $t3,' ', prepare # sprawdzenie czy to koniec string-u SPACJA ma większą wartość niż koniec stringu
	b findEnd # pętla
prepare:
	subu $t1,$t1,1 # zmiana adresu w rejestrze $1 zeby wskazywal na ostatni znak przez bajtem zerowym
nxtchr:	
	bge $t0,$t1,finish
	lbu  $t2 ,($t0) # pobranie pierwszego znaku z buffora i zapisanie go do rejestru
	lbu  $t3, ($t1) # pobranie ostatniego znaku z buffora i zapisanie go do rejestru
	
	sb $t3, ($t0)  # zamiana literek z koncia trafia na początek
	sb $t2, ($t1) # z początku trafia na koniec
	addiu $t0,$t0,1  # zwiększenie adresu z początku
	subu $t1,$t1,1 # zmniejszeni adresu z koncia
	b nxtchr # petla
finish:
	la $a0, buf # przygotowanie nowego stringa
	li $v0, 4 # wybranie funkcji systemowej
	syscall # wywołanie
	
	li $v0, 10 # wybranie zamknięcia programu
	syscall