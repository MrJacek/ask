        section     .text
    global      mirrorbmp8
mirrorbmp8:
    push        ebp
    mov     ebp, esp
    push        ebx
    push        esi
    push        edi
    
    
    

end:
    pop     edi
    pop     esi 
    pop     ebx

    mov     esp, ebp
    pop     ebp
    ret
