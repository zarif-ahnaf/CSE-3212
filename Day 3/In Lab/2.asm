.model small
.stack 100h

.data
    msg1 db "Enter digit (0-9): $"
    msg2 db 0Dh,0Ah,"Enter shift count (0-9): $"
    msg3 db 0Dh,0Ah,"Result = $"

    num1 dw ?
    shifts dw ?

.code
main proc

    mov ax, @data
    mov ds, ax

    ; --- Input first number ---
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov ah, 0
    mov num1, ax

    ; --- Input shift count ---
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov ah, 0
    mov shifts, ax

    ; --- Multiply using shift ---
    mov ax, num1
    mov cx, shifts
    shl ax, cl

    ; --- Print message ---
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    ; --- Print result ---
    call print_num

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp


print_num proc
    mov bx, 10
    xor cx, cx

convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convert_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop

    ret
print_num endp

end main