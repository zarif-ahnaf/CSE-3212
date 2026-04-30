; Smart boy loop starter
.MODEL SMALL
.STACK 100H

.CODE
MAIN PROC
    MOV CX,0;
    
OUTER_LOOP:
    CMP CX,5;
    JE EXIT;  
    
    MOV BX, 0;
 
INNER_LOOP:
    CMP BX, 5;
    JE NEXT_LINE; 
    
    ; Code goes here       
    
    INC BX;
    
NEXT_LINE:
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    
    INC CX;
    JMP OUTER_LOOP;
EXIT:
    MOV AH, 4CH;
    INT 21H;      
       
MAIN ENDP
END MAIN