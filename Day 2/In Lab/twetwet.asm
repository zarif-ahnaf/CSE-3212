.MODEL SMALL
.STACK 100H
.DATA
    P1 DB 0DH,0AH,'Sum of 5 + 1 is: $'
    NUM1 DB ?
    NUM2 DB ?
    RESULT DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Jump to the initialization level
    JMP INIT_LEVEL

ADD_LEVEL:
    ; Perform Addition
    MOV AL, NUM1
    ADD AL, NUM2
    MOV RESULT, AL
     
    CMP RESULT, 5;
    JLE EXIT;
    
    ; Display the result prompt
    LEA DX, P1
    MOV AH, 09H
    INT 21H
         

         
    ; Convert single digit result to ASCII for display 
    MOV DL, RESULT
    ADD DL, 48      ; Convert to ASCII
    MOV AH, 02H
    INT 21H

    JMP EXIT        ; Jump to end to avoid repeating INIT

INIT_LEVEL:
    ; Initialize Variables
    MOV NUM1, 0
    MOV NUM2, 4
    
    ; Jump back to perform the addition
    JMP ADD_LEVEL

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN