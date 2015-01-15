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
	
	
	mov		esi,[ebp+16] ; pobieram wysokosc obrazka
	mov		eax,[ebp+12] ; pobieram szerokosc obrazka
	
	mov		ecx,8
	div		ecx
	cmp		edx,0
	je		go
	inc		eax
go:
	mov		ecx,eax
	mov		edx,eax
	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	add		ebx,22
	
lop:
	mov		al,[ebx]
	not		al
	mov		[ebx],al
	add		ebx,1
	dec		ecx
	cmp		ecx,0
	jne		lop
	mov		ecx,edx
	dec		esi
	cmp		esi,0
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
