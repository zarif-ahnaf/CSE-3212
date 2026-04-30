; Junayed's code question 2
.MODEL SMALL
.STACK 100H

.DATA

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, 0

OUTER:
    CMP BX, 5    
    JGE EXIT_PROG 

    MOV CX, 0

INNER:
    CMP CX, 5    
    JGE NL        

    CMP CX, 2
    JNE PRINT_HASH
    
    CMP BX, 1
    JE PRINT_C
    CMP BX, 2
    JE PRINT_S
    CMP BX, 3
    JE PRINT_E

PRINT_HASH:
    MOV DL, '#'
    JMP DISPLAY

PRINT_C:
    MOV DL, 'C'
    JMP DISPLAY

PRINT_S:
    MOV DL, 'S'
    JMP DISPLAY

PRINT_E:
    MOV DL, 'E'

DISPLAY:
    MOV AH, 02H
    INT 21H 

    INC CX          
    JMP INNER       

NL:
    MOV AH, 02H
    MOV DL, 10
    INT 21H  

    MOV DL, 13
    INT 21H  

    INC BX       
    JMP OUTER  

EXIT_PROG:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN