;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS


section .text
    global load
    
;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    mov     esi, -1                               ; line=-1
    push    edi                                   ; salvez edi pe stiva 
    mov     edi, edx                              ; edi=address            
    shr     edi, OFFSET_BITS                      ; edi=tag=address>>3
    push    eax                                   ; salvez eax pe stiva
    xor     eax, eax                              ; eax=i=0
search_address_in_tags:
    cmp     eax, CACHE_LINES                      ; daca i>=CACHE_LINES 
    jge     next                                  ; sfarsitul cautarii adresei in tags
    cmp     edi, [ebx + eax*4]                    ; daca tags[i]==tag
    je      keep_the_line                         ; retin linia pe care l-am gasit
    inc     eax                                   ; altfel, i++
    jmp     search_address_in_tags                ; inapoi la search_address_in_tags (for)
keep_the_line:
    mov     esi, eax                              ; line=i, break
next:
    pop     eax                                   ; scot eax de pe stiva: eax=address of reg
    cmp     esi, 0                                ; daca line<0, nu am gasit adresa
    jl      address_not_found_case                ; incarc datele din memorie si scriu in registru
    jmp     address_found_case                    ; altfel, doar scriu in registru
address_not_found_case: 
    pop     esi                                   ; scot esi de pe stiva: esi=to_replace
    mov     [ebx + esi*4], edi                    ; tags[to_replace]=tag
    shl     edi, OFFSET_BITS                      ; tag=tag<<3
    push    ebx                                   ; salvez ebx pe stiva
    xor     ebx, ebx                              ; ebx=i=0
    push    eax                                   ; salvez eax pe stiva
    lea     eax, [ecx + esi*CACHE_LINE_SIZE]      ; eax=cache[to_replace]
load_in_cache:
    cmp     ebx, CACHE_LINE_SIZE                  ; daca i>=CACHE_LINE_SIZE
    jge     put_in_reg                            ; scriu in registru, sfarsit
    push    edx                                   ; salvez edx pe stiva
    xor     edx, edx                              ; edx=0
    mov     dl, [edi + ebx]                       ; dl=*(tag+i)
    mov     [eax + ebx], dl                       ; cache[to_replace][i]=*(tag+i)
    pop     edx                                   ; scot edx de pe stiva: edx=address
    inc     ebx                                   ; i++
    jmp     load_in_cache                         ; inapoi la load_in_cache (for)
put_in_reg:
    pop     eax                                   ; scot eax de pe stiva: eax=address of reg
    lea     edi, [ecx + esi*CACHE_LINE_SIZE]      ; edi=cache[to_replace]
    and     edx, 7                                ; edx=offset (ultimii 3 biti)
    xor     ebx, ebx                              ; ebx=0
    mov     bl, [edi + edx]                       ; bl=cache[to_replace][offset]
    mov     [eax], bl                             ; reg=cache[to_replace][offset]
    pop     ebx                                   ; scot ebx de pe stiva: ebx=tags
    jmp     the_end                               ; sfarsit
address_found_case:
    lea     edi, [ecx + esi*CACHE_LINE_SIZE]      ; edi=cache[to_replace]
    and     edx, 7                                ; edx=offset (ultimii 3 biti)
    push    ebx                                   ; salvez ebx pe stiva 
    xor     ebx, ebx                              ; ebx=0
    mov     bl, [edi + edx]                       ; bl=cache[to_replace][offset]
    mov     [eax], bl                             ; reg=cache[to_replace][offset]
    pop     ebx                                   ; scot ebx de pe stiva: ebx=tags
    pop     edi                                   ; scot edi de pe stiva: edi=to_replace
the_end:                                          ; sfarsit
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
