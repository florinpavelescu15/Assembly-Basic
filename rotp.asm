section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    xor     ebx, ebx                  ; ebx=i=0
build_ciphertext:
    mov     al, [esi + ebx]           ; al=plaintext[i]
    xor     al, [edi + ecx - 1]       ; al=plaintext[i]^key[len-i-1]
    mov     [edx + ebx], al           ; ciphertext[i]=plaintext[i]^key[len-i-1]
    inc     ebx                       ; i++
    loop    build_ciphertext          ; ecx--, practic ecx=len-i
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
