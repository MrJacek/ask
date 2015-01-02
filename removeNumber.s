; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: void invertstr(const char* str);
    section .text
    global removeNumber
removeNumber:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,8 ; adress początku najwiekszej liczby [esp]
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
    ; ecx asdress
; ciało procedury
    mov     eax, [ebp+8]    ; argument – wskaźnik na łańcuch
    mov     esi,[ebp+8]


lop1:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    cmp     dl,' '
    je      lop2init
    cmp     dl, ':'
    jge     lop13
    cmp     dl, '/'
    jbe     lop13

    mov     [esp+8],eax
    inc     eax
    mov     dl,[eax]
    cmp     dl,' '
    cmp     dl,':'
    cmp     dl,'/'
    cmp     [esp+8],eax
    je     lop2init

lop13:
    inc     eax
    jmp     lop1


;==================================


lop2init:
    mov     eax,[ebp+8]
    mov     ecx,eax


lop2:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    cmp     dl, ' '
    je      end
    
    cmp     eax,[esp+8]
    je      lop21

cos:
    mov     [ecx],dl
    inc     ecx
lop21:
    inc     eax
    jmp     lop2


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
