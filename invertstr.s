; odpowiednik funkcji strlen z biblioteki standardowej C
; deklaracja na poziomie C: void invertstr(const char* str);
    section .text
    global invertstr
invertstr:
; prolog
    push    ebp ; zapamiętanie wskaźnika ramki procedury wołającej
    push    ebx    
    mov     ebp, esp ; ustanowienie własnego wskaźnika ramki
    
; procedura nie alokuje danych lokalnych na stosie

; ciało procedury
    mov     eax, [ebp+8]    ; argument – wskaźnik na łańcuch
    mov     ecx,[ebp+8]     ; drugi wksaznik;
lop1:
    mov     dl, [eax]       ; kolejny bajt łańcucha
    inc     eax             ; inkrementacja adresu
    test    dl, dl          ; test czy bajt = 0
    jnz     lop1            ; nie – następny bajt
    dec     eax             ; cofnięcie wskaźnika o 1, mamy koniec łańcucha
    
lop2:
    
   ; mov dl,[ecx]
   ; mov bl,[eax]
   ; mov [ecx],dl
   ; mov [eax],bl
    test eax,ecx
    jge end
    inc ecx
    dec eax
    jmp lop2

; wartość funkcji w EAX

; epilog
end:
    ;mov    esp, ebp        ; dealokacja danych lokalnych - zbędna
    pop     ebx
    pop     ebp             ; odtworzenie wskaźnika ramki procedury wołającej
    ret                     ; powrót