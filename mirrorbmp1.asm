section     .text
    global      mirrorbmp1
mirrorbmp1:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,8 ; adress początku najwiekszej liczby [ebp-8]
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
; ciało procedury
  	mov		eax,0
  	mov		ebx,0
	mov		ecx,0
	mov		edx,0
	mov		esi,0
	mov		edi,0
	
	
	mov		ecx,[ebp+12] ; pobieram szerokosc obrazka
	mov		esi,[ebp+16] ; pobieram wysokosc obrazka
	mov		edi,0
	mov		edx,0
	mov		ebx,ecx
	mov		eax,8
	div		ebx
	cmp		edx,0
	je		go
	inc		eax
go:
	mov		esi,edx
	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	add		ebx,22
	
	mov		eax,0
	
lop:
	mov		al,[ebx]
	not		al
	mov		[ebx],al
	add		ebx,1
	dec		esi
	cmp		esi,0
	jne		lop
	mov		esi,edx
	dec		ecx
	cmp		ecx,0
	
	jne		lop
; epilog
end:
;   przywrucenie rejestrow
    pop     edi
    pop     esi
    pop     ebx
;   dealokacja danych lokanych
    mov     esp, ebp        
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót
