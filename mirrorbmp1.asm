section     .text
    global      mirrorbmp1
mirrorbmp1:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,8 ; adress początku najwiekszej liczby [esp]
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
; ciało procedury
  	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	mov		ecx,0
	mov		ecx,[ebp+12] ; pobieram szerokosc obrazka
	mov		esi,0
	mov		esi,[ebp+16] ; pobieram wysokosc obrazka
	add		ebx,7Ah
	mov		edx,0

	mov		eax,0
	add		ebx,8
	
lop:
	mov		ax,[ebx]
	not		ax
	mov		[ebx],ax
	add		ebx,2
	dec		esi
	cmp		esi,0
	jne		lop
	dec		ecx
        mov		esi,[ebp+16]
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
