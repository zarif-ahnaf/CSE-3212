.model small
.stack 100h
.data
    msg1 db "Enter first 4-bit binary: $"
    msg2 db 0Dh,0Ah,"Enter second 4-bit binary: $"
    result_msg db 0Dh,0Ah,"Result (XOR): $"
    val1 db ? 

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ===== First Input =====
    mov ah, 09h
    lea dx, msg1
    int 21h

    call read4
    mov val1, al 

    ; ===== Second Input =====
    mov ah, 09h
    lea dx, msg2
    int 21h

    call read4
    ; Second input is now in AL

    ; ===== XOR Operation =====
    xor al, val1 ; 

    ; ===== Print Result =====
    push ax 
    mov ah, 09h
    lea dx, result_msg
    int 21h
    pop ax 

    call print4

    ; ===== Exit =====
    mov ah, 4Ch
    int 21h
main endp

read4 proc
    xor bl, bl    ; Clear BL to store our 4 bits
    mov cx, 4     ; Set loop counter to 4
    
input_loop:
    mov ah, 01h   ; Read character
    int 21h
    sub al, '0'   ; Convert ASCII '0'/'1' to numeric 0/1
    
    shl bl, 1     ; Shift BL left to make room for the next bit
    or bl, al     ; Place the new bit into the LSB of BL
    loop input_loop

    mov al, bl    ; Move final result to AL for the caller
    ret
read4 endp

print4 proc
    mov bl, al    ; Move the result to BL for processing
    mov cx, 4     ; We want to print 4 bits
    
print_loop:
    rol bl, 1     ; Rotate Left: The highest bit moves into the Carry Flag (CF)
   
    test bl, 1000b ; Check the 4th bit (assuming result is in lower nibble)

    mov dl, '0'
    test al, 1000b ; Check the leftmost bit of a 4-bit nibble
    jz display
    mov dl, '1'
    
display:
    mov ah, 02h
    int 21h
    shl al, 1      ; Shift left to check the next bit
    loop print_loop

    ret
print4 endp

end main