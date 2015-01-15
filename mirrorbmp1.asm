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
	
	mov		ecx,32
	div		ecx
	cmp		edx,0
	je		go
	inc		eax
go:
	mov		[ebp-4],eax
	
	;mov		edx,0
	;mov		eax,esi
	;mov		ecx,[ebp+16]
	;mul		ecx

	mov		ecx,[ebp-4]
	mov		edx,ecx
	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	add		ebx,22
	
	;add		ebx,512

	
lop:
	mov		eax,[ebx]
	not		eax
	mov		[ebx],eax
	add		ebx,4
	dec		ecx
	cmp		ecx,0
	ja		lop
	mov		ecx,edx
	dec		esi
	cmp		esi,0
	ja		lop
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
