.model small
.stack 100h
.data
    msg1 db "Enter first 4-bit binary: $"
    msg2 db 0Dh,0Ah,"Enter second 4-bit binary: $"
    result_msg db 0Dh,0Ah,"Result (AND): $"
    val1 db ? ; Store first input here to keep it safe

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ===== First Input =====
    mov ah, 09h
    lea dx, msg1
    int 21h

    call read4
    mov val1, al ; Save first input to memory, away from busy registers

    ; ===== Second Input =====
    mov ah, 09h
    lea dx, msg2
    int 21h

    call read4
    ; Second input is now in AL

    ; ===== AND Operation =====
    and al, val1 ; AND the second input (AL) with the first input (val1)

    ; ===== Print Result =====
    push ax ; Save result for a moment
    mov ah, 09h
    lea dx, result_msg
    int 21h
    pop ax ; Get result back into AL for printing

    call print4

    ; ===== Exit =====
    mov ah, 4Ch
    int 21h
main endp

; =========================
; Read exactly 4 bits
; =========================
read4 proc
    xor cl, cl ; Use CL instead of BL to avoid conflicts

    ; Repeat this 4 times
    mov cx, 4
input_loop:
    push cx      ; Save loop counter
    mov ah, 01h
    int 21h
    sub al, '0'  ; Convert ASCII to binary
    shl bl, 1    ; Shift existing bits left
    or bl, al    ; Insert new bit
    pop cx       ; Restore loop counter
    loop input_loop

    mov al, bl
    ret
read4 endp

; =========================
; Print 4 bits
; =========================
print4 proc
    mov bh, al   ; Use BH to hold the value while we shift
    mov cx, 4    ; Loop 4 times

print_loop:
    shl bh, 1    ; Shift MSB into Carry Flag
    jc disp_one
    mov dl, '0'
    jmp display
disp_one:
    mov dl, '1'
display:
    mov ah, 02h
    int 21h
    loop print_loop

    ret
print4 endp

end main