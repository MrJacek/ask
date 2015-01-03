; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: void invertstr(const char* str);
    section .text
    global removeNumber
removeNumber:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
; procedura nie alokuje danych lokalnych na stosie
    sub     esp,4
    sub     esp,8
    sub     esp,8 ; akumulator
    sub     esp,1
; zwalnianie rejestrów
    push    ebx    
    push    esi
    push    edi
    ; ecx asdress
; ciało procedury
    mov     eax, [ebp+8]    ; argument – wskaźnik na łańcuch
    mov     edx,0
    mov     [ebp-4],dx
    mov     [ebp-12],edx
    mov     edx,0
    mov     ecx,0
    mov     si,0
    mov     [ebp-13],dh
lop1:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    test     dl,dl
    jz      lop2init
    cmp     dl, ':'
    jge     lop12
    cmp     dl, '/'
    jbe     lop12
;    mov     ebx,eax

    jmp     zapisz
lop12:
    mov     dh,0
    mov     [ebp-13],dh
    cmp     cx,[ebp-4]
    jb     lop13
    mov     [ebp-4],cx 
    mov     [ebp-12],ebx
    mov     cx,0

lop13:
    inc     eax
    jmp     lop1

;==================================
zapisz:
    mov     dh,1
    cmp     [ebp-13],dh ;Sprawdzamy czy jest kontnuacja liczby
    je      dodaj ; jesli tak to przechodzimy do dodawani jej wartosci
    mov     ebx,eax ; jak nie to zapisujem adres poczatkowy tej liczby
    mov     [ebp-13],dh ; ustawiamy flage
dodaj:
    sub     dl,48
    mov     [ebp-20],eax
    mov     eax,0
    mov     al,10
    mul     cl
    add     al,dl
    add     cx,ax
    mov     eax,[ebp-20]
    jmp     lop13
    

;=================================
lop2init:
    mov     ebx,[ebp-12]
    mov     eax,[ebp+8]
    mov     ecx,eax
    mov     dh,0

lop2:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    test    dl, dl
    jz      end

    cmp     eax,ebx
    je      flaga
    cmp     dl, ':'
    jge     lop20
    cmp     dl, '/'
    jbe     lop20
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
;   przywrucenie rejestrow
    pop     edi
    pop     esi
    pop     ebx
;   dealokacja danych lokanych
    mov     esp, ebp        
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót
