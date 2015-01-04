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
	not		edx

;lop:
	
	mov		edx,[ebx]
	mov		ecx,[ebx+8]
	mov		[ebx+16],edx
	mov		[ebx+24],ecx
	;dec		esi
	;cmp		esi,0
	;jne		lop		
	
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
