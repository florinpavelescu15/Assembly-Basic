section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov     edi, [ebp + 8]   ; key
    mov     esi, [ebp + 12]  ; haystack
    mov     ebx, [ebp + 16]  ; ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    xor     ecx, ecx               ; ecx=i=0
    xor     eax, eax               ; eax=j=0
    xor     edx, edx               ; edx=k=0
through_key: 
    cmp     ecx, [len_cheie]       ; daca i>=len_cheie       
    jge     the_end                ; sfarsit
through_haystack:                 
    cmp     eax, [len_haystack]    ; altfel, daca j>=len_haystack
    jge     go_to_next_key         ; i++, j=0, inapoi la through_key (for)
    push    ebx                    ; salvez ebx pe stiva              
    push    edx                    ; salvez edx pe stiva  
    push    eax                    ; salvez eax pe stiva  
    xor     edx, edx               ; edx=0
    mov     ebx, [len_cheie]       ; ebx=len_cheie
    div     ebx                    ; eax=j/len_cheie; edx=j%len_cheie;
    pop     eax                    ; eax=j
    cmp     edx, [edi + ecx*4]     ; daca j%len_cheie==key[i]
    je      put_char_in_ciphertext ; mergi la put_char_in_ciphertext
    pop     edx                    ; scot edx de pe stiva: edx=k    
    pop     ebx                    ; scot ebx de pe stiva: ebx=ciphertext
go_to_next_char:
    inc     eax                    ; j++
    jmp     through_haystack       ; inapoi la through_haystack (for)
go_to_next_key:
    inc     ecx                    ; i++
    xor     eax, eax               ; j=0
    jmp     through_key            ; inapoi la through_key (for)
put_char_in_ciphertext:
    pop     edx                    ; scot edx de pe stiva: edx=k
    pop     ebx                    ; scot ebx de pe stiva: ebx=ciphertext
    push    ecx                    ; salvex ecx pe stiva
    mov     cl, [esi + eax]        ; cl=haystack[j]
    mov     [ebx + edx], cl        ; ciphertext[k]=haystack[j]
    pop     ecx                    ; scot ecx de pe stiva: ecx=i
    inc     edx                    ; k++
    cmp     edx, [len_haystack]    ; daca k==len_haystack
    je      end_haystack           ; ciphertext[k]='\0'
    jmp     go_to_next_char        ; inapoi la go_to_next_char (for)
end_haystack:
    mov     byte [ebx + edx], 0    ; ciphertext[k]='\0'
    jmp     go_to_next_char        ; inapoi la go_to_next_char (for)
the_end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
