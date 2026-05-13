; Smart boy array

.MODEL SMALL
.STACK 100H
.DATA
    MY_ARRAY DB 1, 2, 3, 4, 5
    ARRAY_SIZE EQU 5
    SUM DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV SI, OFFSET MY_ARRAY ; Load starting address (Register Indirect base)
    MOV CX, ARRAY_SIZE      ; Set loop counter
    MOV AL, 0               ; Clear AL to store the sum

SUM_LOOP:
    ADD AL, [SI]            ; Register Indirect Addressing: Access data at address in SI
    INC SI                  ; Move to next element in the array
    LOOP SUM_LOOP           ; Decrement CX and repeat if CX > 0

    MOV SUM, AL             ; Store the final result in a register/memory
    
    MOV AH, 4CH             ; DOS interrupt to exit
    INT 21H
MAIN ENDP
END MAIN