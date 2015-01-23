section     .text
    global      mirrorbmp1
mirrorbmp1:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,16
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
	div 	ecx
	cmp		edx,0
	je		go
	inc		eax
go:
	shl		eax,2
	mov		edi,eax
;======= Przygotowanie do pętli
	mov		ebx,[ebp+8]	; pobieram pierwszy parametr wskaźnik obrazu
	add		ebx,22		
	mov		ecx,ebx;	
	add		ecx,eax
	sub		ecx,4
	mov		[ebp-8],ebx
	mov		[ebp-16],ecx

;======= Pętla	 ebx - lewa strona, ecx - prawa strona

lop_inner:
	mov		eax,[ecx]
	mov 	edx,eax
	shr		eax,1
	and 	edx,055555555h
	and 	eax,055555555h
	lea 	eax,[2*edx+eax]
	mov 	edx,eax
	shr 	eax,2
	and 	edx,033333333h
	and 	eax,033333333h
	lea 	eax,[4*edx+eax]
	mov 	edx,eax
	shr 	eax,4
	and		edx,0F0F0F0Fh
	and 	eax,0F0F0F0Fh
	shl 	edx,4
	add 	eax,edx
	bswap 	eax
	
	mov		edx,[ebx]
	mov		[ebx],eax
	mov		eax,edx
	
	shr		eax,1
	and 	edx,055555555h
	and 	eax,055555555h
	lea 	eax,[2*edx+eax]
	mov 	edx,eax
	shr 	eax,2
	and 	edx,033333333h
	and 	eax,033333333h
	lea 	eax,[4*edx+eax]
	mov 	edx,eax
	shr 	eax,4
	and		edx,0F0F0F0Fh
	and 	eax,0F0F0F0Fh
	shl 	edx,4
	add 	eax,edx
	bswap 	eax
	mov		[ecx],eax
	add		ebx,4
	sub		ecx,4
	cmp		ebx,ecx
	jb		lop_inner
	je		middleWord
	
lop_outsite:
	dec		esi
	cmp		esi,0
	je		end
	mov		ebx,[ebp-8]
	mov		ecx,[ebp-16]
	add		ebx,edi
	add		ecx,edi
	mov		[ebp-8],ebx
	mov		[ebp-16],ecx
	jmp		lop_inner
	
	
middleWord:
	mov		eax,[ecx]
	mov 	edx,eax
	shr		eax,1
	and 	edx,055555555h
	and 	eax,055555555h
	lea 	eax,[2*edx+eax]
	mov 	edx,eax
	shr 	eax,2
	and 	edx,033333333h
	and 	eax,033333333h
	lea 	eax,[4*edx+eax]
	mov 	edx,eax
	shr 	eax,4
	and		edx,0F0F0F0Fh
	and 	eax,0F0F0F0Fh
	shl 	edx,4
	add 	eax,edx
	bswap 	eax
	jmp		lop_outsite
end:
;   przywrucenie rejestrow
    pop     edi
    pop     esi
    pop     ebx
;   dealokacja danych lokanych
    mov     esp, ebp        
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót
