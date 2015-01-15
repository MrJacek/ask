section     .text
    global      mirrorbmp1
mirrorbmp1:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,4 ; adress początku najwiekszej liczby [ebp-8]
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
	
;======= Wyliczenie ile potworzen na jeden wiersz
	mov		ecx,32
	div		ecx
	cmp		edx,0
	je		go
	inc		eax
go:
	mov		[ebp-4],eax
;======= Wyliczenie ostatniego wiersza 
	mov		edx,0
	mul		esi
	mov		ecx,4
	mul		ecx
	mov		edi,eax
	
	mov		edx,0
	mov		eax,[ebp-4]
	mov		ecx,4
	mul		ecx
	sub		edi,eax
	mov		edx,eax
;======= Przygotowanie do pętli

	mov		ecx,[ebp-4]
	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	add		ebx,22
	add		edi,ebx
	mov		eax,0
	
;======= Pętla
		
lop:
	mov		eax,[ebx]	; uzyte: eax,ebx,esi,edi,ecx,edx
	mov		esi,[edi]	
	mov		[edi],eax	
	mov		[ebx],esi
	add		ebx,4
	add		edi,4
	dec		ecx
	cmp		ecx,0
	ja		lop
	sub		edi,edx
	sub		edi,edx
	mov		ecx,[ebp-4]
	cmp		ebx,edi
	jbe		lop
	jmp		end
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
