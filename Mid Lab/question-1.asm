.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter n: $'
    MSG2 DB 0DH,0AH,'Sum of even numbers = $'
    SUM DW 0
    N DW 0

.CODE    


PRINT_NUM PROC
    MOV CX, 0
    MOV BX, 10

DIV_LOOP:
    MOV DX, 0
    DIV BX          
    PUSH DX         
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

    RET
PRINT_NUM ENDP


MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H         
    SUB AL, '0'      
    MOV AH, 0
    MOV N, AX

    MOV BX, 0        
    
LOOP_START:
    CMP BX, N
    JA END_LOOP

    MOV AX, SUM
    ADD AX, BX
    MOV SUM, AX

    ADD BX, 2        
    JMP LOOP_START

END_LOOP:

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AX, SUM
    CALL PRINT_NUM

    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN