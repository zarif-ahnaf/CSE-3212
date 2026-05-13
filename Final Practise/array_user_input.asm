; Smart boy array input loop checker


.MODEL SMALL
.STACK 100H
.DATA
    PROMPT DB 'Enter 5 single-digit numbers (e.g., 12345): $'
    RESULT_MSG DB 0DH, 0AH, 'The sum is: $'
    
    MY_ARRAY DB 5 DUP(0)
    ARRAY_SIZE EQU 5
    SUM DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- 1. Get Array Input from User ---
    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H

    MOV CX, ARRAY_SIZE
    LEA SI, MY_ARRAY

INPUT_LOOP:
    MOV AH, 01H            ; Read a char with echo
    INT 21H
    
    SUB AL, 30H            ; Convert ASCII ('1' = 31h) to Digit (1)
    MOV [SI], AL           ; Store in array
    INC SI
    LOOP INPUT_LOOP

    ; --- 2. Calculate the Sum ---
    LEA SI, MY_ARRAY
    MOV CX, ARRAY_SIZE
    MOV AL, 0              ; Accumulator for sum

SUM_LOOP:
    ADD AL, [SI]
    INC SI
    LOOP SUM_LOOP
    
    MOV SUM, AL            ; Store result

    ; --- 3. Display the Result ---
    LEA DX, RESULT_MSG
    MOV AH, 09H
    INT 21H

    ; Handle 2-digit sums (since 9+9+9+9+9 = 45)
    MOV AL, SUM
    AAM                    ; ASCII Adjust for Multiplication
                           ; AH = Tens digit, AL = Units digit
    
    ADD AX, 3030H          ; Convert both to ASCII at once
    MOV BX, AX             ; Save for printing

    ; Print Tens Digit
    MOV DL, BH
    MOV AH, 02H
    INT 21H

    ; Print Units Digit
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN