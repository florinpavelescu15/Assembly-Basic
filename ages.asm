; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages: 
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY
    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    xor     eax, eax                         ; eax=i=0            
build_all_ages:
    cmp     eax, edx                         ; daca i>=len 
    jge     the_end                          ; sfarsit
    mov     dword [ecx + eax*4], 0           ; altfel, all_ages[i]=0
    lea     ebx, [edi + eax*my_date_size]    ; ebx=dates[i]
    push    eax                              ; salvez eax pe stiva
    mov     ax, [ebx + my_date.month]        ; ax=dates[i].month
    cmp     ax, [esi + my_date.month]        ; daca dates[i].month>present->month
    jg      decrement_age1                   ; all_ages[i]=-1
    je      compare_days                     ; altfel, daca dates[i].month==present->month, compar zilele
next1:
    pop     eax                              ; scot eax de pe stiva: eax=i
    push    edx                              ; salvez edx pe stiva
    mov     edx, [esi + my_date.year]        ; edx=present->year
    sub     edx, [ebx + my_date.year]        ; edx=present->year-dates[i].year
    add     [ecx + eax*4], edx               ; all_ages[i]=edx
    pop     edx                              ; scot edx de pe stiva: edx=len
    cmp     dword [ecx + eax*4], 0           ; daca all_ages[i]<0 
    jl      negative_age_case                ; all_ages[i]=0
next2:
    inc     eax                              ; i++
    jmp     build_all_ages                   ; inapoi la build_all_ages (for)
decrement_age1:
    pop     eax                              ; scot eax de pe stiva: eax=i
    mov     dword [ecx + eax*4], -1          ; all_ages[i]=-1
    push    eax                              ; salvez eax pe stiva
    jmp     next1
compare_days:
    mov     ax, [ebx + my_date.day]          ; ax=dates[i].day
    cmp     ax, [esi + my_date.day]          ; daca dates[i].day>present->day
    jg      decrement_age2                   ; ziua de nastere nu a fost inca :)
    jmp     next1                            ; continua in build_all_ages
decrement_age2:
    pop     eax                              ; scot eax de pe stiva: eax=i
    mov     dword [ecx + eax*4], -1          ; all_ages[i]=-1
    push    eax                              ; salvez eax pe stiva
    jmp     next1                            ; continua in build_all_ages
negative_age_case:
    mov     dword [ecx + eax*4], 0           ; all_ages[i]=0
    jmp     next2                            ; continua in build_all_ages
the_end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
    