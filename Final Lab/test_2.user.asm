.MODEL SMALL
.STACK 100H

.DATA
    PROMPT      DB 'Enter a number: $'
    RESULT_MSG  DB 10,13,'Sum of first and last digit: $'
    NUM_VAL     DW 0
    LAST_DIGIT  DB ?

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H

READ_INPUT:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13
    JE  END_READ
    
    SUB AL, 48
    MOV CL, AL
    MOV CH, 0
    
    MOV AX, NUM_VAL
    MOV BX, 10
    MUL BX
    ADD AX, CX
    MOV NUM_VAL, AX
    JMP READ_INPUT

END_READ:
    MOV AX, NUM_VAL
    MOV BL, 10
    DIV BL
    MOV LAST_DIGIT, AH
    
    MOV AX, NUM_VAL

FIND_FIRST:
    CMP AX, 10
    JB  DONE_CALC
    XOR DX, DX
    MOV BX, 10
    DIV BX
    JMP FIND_FIRST

DONE_CALC:
    ADD AL, LAST_DIGIT
    MOV BL, AL

    LEA DX, RESULT_MSG
    MOV AH, 09H
    INT 21H

    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    DIV CL
    
    MOV CH, AH
    CMP AL, 0
    JE  PRINT_LAST
    
    MOV DL, AL
    ADD DL, 48
    MOV AH, 02H
    INT 21H

PRINT_LAST:
    MOV DL, CH
    ADD DL, 48
    MOV AH, 02H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
END START