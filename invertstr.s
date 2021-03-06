; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: void invertstr(const char* str);
    section .text
    global removeNumber
removeNumber:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,4 ; akumulator [esp+8]
    sub     esp,4 ; akumulator tymczasowy [esp+4]
    sub     esp,8 ; adress początku najwiekszej liczby [esp]
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
; ciało procedury
    mov     ecx,0
    mov     [esp+8],edi
    mov     [esp+4],edi
    mov     edi, [ebp+8]    ; argument – wskaźnik na łańcuch
    mov     dh,0
lop1:
    mov     dl, [edi]       ; kolejny bajt łańcucha
    cmp     dl,' '
    je      lop2init
    cmp     dl, ':'
    jge     lop12
    cmp     dl, '/'
    ja      zapiszPozycje
lop12:
    mov     edx,[esp+8]
    cmp     edx,[esp+4]
    je      zmienNajwiekszy
lop121:
    mov     dh,0
lop13:
    inc     edi
    jmp     lop1

zapiszPozycje:
    cmp     dh,1
    je      dodaj
    mov     dh,1
    mov     ebx,edi
dodaj:
    sub     dl,48
    mov     al,0ah
    mul     dl
    movzx   esi,ax
    add     [esp+4],esi
    jmp     lop13

zmienNajwiekszy:
    mov     edx,[esp+4]
    mov     [esp+8],edx
    mov     [esp],ebx
    jmp     lop121

lop2init:
    mov     eax,[ebp+8]
    mov     edi,eax
lop2:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    cmp     dl, ' '
    je      end
    cmp     dl, ':'
    jge     cos
    cmp     dl, '/'
    ja      cos2 
;    cmp    dl,'1'
;    je      lop21
cos:
    mov     [edi],dl
    inc     edi
lop21:
    inc     eax
    jmp     lop2

cos2:
    mov     ebx,eax
    je      lop21
    jmp     cos





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
