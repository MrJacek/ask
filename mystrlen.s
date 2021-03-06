; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: unsigned mystrlen(char *s)
    section .text
    global mystrlen
mystrlen:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki

; procedura nie alokuje danych lokalnych na stosie

; ciało procedury
    mov     eax, [ebp+8]    ; argument – wskaźnik na łańcuch
lop1:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    inc     eax             ; inkrementacja adresu
    test    dl, dl          ; test czy bajt = 0
    jnz     lop1            ; nie – następny bajt
    dec     eax             ; cofnięcie wskaźnika o 1
    sub     eax, [ebp+8]    ; odjęcie adresu początku łańcucha

; wartość funkcji w EAX

; epilog
    ;mov    esp, ebp        ; dealokacja danych lokalnych - zbędna
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót
