; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: void invertstr(const char* str);
    section .text
    global removeNumber
removeNumber:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,16 ; adres najwiekszej ebp-8
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
    ; ecx asdress
; ciało procedury
    mov     eax, [ebp+8]    ; argument – wskaźnik na łańcuch
    mov     ebx,0  ; najwieksza
    mov	    [ebp-8],ebx
    mov     [ebp-16],ebx
    mov     ecx,0  ; adress
    mov     edx,0  ; znak i flaga
    mov     esi,10 ; mnozenie
    mov	    edi,0  ; mnozenie
    mov     dh,1

;==================================

lop1:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    test    dl,dl
    jz      lop2init
    cmp     dl, ':'
    jge     lop12
    cmp     dl, '/'
    jnbe    zapisz
;    mov     ebx,eax
;    jmp     zapisz
lop12:
    cmp     dh,1
    je      lop121 
lop121:    
    mov     dh,1
    cmp     [ebp-16],ecx
    jnbe     lop13
    mov     [ebp-16],ecx 
    mov     [ebp-8],ebx
    mov     ecx,0
lop13:
    inc     eax
    jmp     lop1

;==================================
zapisz:
    cmp     dh,0 ;Sprawdzamy czy jest kontnuacja liczby
    je      dodaj ; jesli tak to przechodzimy do dodawani jej wartosci
    mov     ebx,eax ; jak nie to zapisujem adres poczatkowy tej liczby
    mov     dh,0 ; ustawiamy flage
dodaj:
    sub     dl,48
    mov     esi,10
    imul    ecx,esi
    movzx   edi,dl
    add     ecx,edi
    jmp     lop13

;=================================
lop2init:
   
    mov     esi,[ebp-8]
    mov     eax,[ebp+8]
    mov     ecx,eax
    mov     dh,0

lop2:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    test    dl, dl
    jz      end

    cmp     eax,esi
    je      flaga
    cmp     dl, '9'
    ja     lop20
    cmp     dl, '0'
    jb     lop20
    cmp     dh,1
    je      lop22
lop20:
    mov     dh,0
lop21:
    mov     [ecx],dl
    inc     ecx
lop22:
    inc     eax
    jmp     lop2

flaga:
    mov     dh,1
    jmp     lop22

; epilog
end:
    mov     dl,0
    mov     [ecx],dl
    mov	    eax,[ebp-16]
;   przywrucenie rejestrow
    pop     edi
    pop     esi
    pop     ebx
;   dealokacja danych lokanych
    mov     esp, ebp        
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót
