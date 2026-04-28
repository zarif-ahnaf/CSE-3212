org 100h

.data
    sum      db 0
    temp_num db 0
    msg1     db "Enter number (press Enter to finish): $"
    msg2     db 0Dh,0Ah,"Final Sum = $"

.code
start:
    mov byte ptr sum, 0
    mov cx, 4           ; Still set to sum 4 numbers

input_loop:
    push cx             ; Save total loop counter
    
    ; Display prompt
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    call read_number    ; Result in AL
    mov bl, al          ; BL = The number just entered
    
    mov al, sum         ; AL = Current total sum
    call bit_add_no_loop
    mov sum, al         ; Update total sum

    pop cx              ; Restore total loop counter
    loop input_loop

    ; Result display
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov al, sum
    aam                 ; AH = Tens, AL = Ones
    
    add ax, 3030h       ; Convert to ASCII
    mov bx, ax          
    
    mov ah, 02h
    mov dl, bh          ; Print Tens
    int 21h
    mov dl, bl          ; Print Ones
    int 21h

    mov ah, 4Ch
    int 21h

read_number proc
    push bx
    push cx
    mov bx, 0           ; BX will store our accumulating number
    
read_char:
    mov ah, 01h         ; Read char with echo
    int 21h
    
    cmp al, 0Dh         ; Check if 'Enter' was pressed
    je finish_read
    
    sub al, '0'         ; Convert ASCII to digit
    mov cl, al          ; Save digit in CL
    
    mov al, bl          ; Move current total to AL
    mov dl, 10
    mul dl              ; AL = AL * 10
    add al, cl          ; Add the new digit
    mov bl, al          ; Store back in BL
    jmp read_char

finish_read:
    mov al, bl          ; Return the full number in AL
    pop cx
    pop bx
    ret
read_number endp

bit_add_no_loop:
    mov dl, al
    xor al, bl          ; AL = partial sum
    and dl, bl          ; DL = carry
    shl dl, 1
    mov bl, dl          ; BL = new carry to add

    mov dl, al
    xor al, bl
    and dl, bl
    shl dl, 1
    mov bl, dl

    mov dl, al
    xor al, bl
    and dl, bl
    shl dl, 1
    mov bl, dl

    mov dl, al
    xor al, bl
    and dl, bl
    shl dl, 1
    mov bl, dl

    mov dl, al
    xor al, bl
    and dl, bl
    shl dl, 1
    mov bl, dl

    xor al, bl          ; Final XOR
    ret