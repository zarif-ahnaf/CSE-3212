; Convulated Print of Fuck pattern
; #####
; ##C##
; ##S##
; ##E##
; #####

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
    
    CMP BX,2;
    JNE PRINT_HASH;
    
    CMP CX,1;
    JE PRINT_C;
    CMP CX,2;
    JE PRINT_S;
    CMP CX,3;
    JE PRINT_E;
    
PRINT_HASH:
    MOV DL,"#";
    JMP DISPLAY;

PRINT_C:
    MOV DL,"C"
    JMP DISPLAY

PRINT_S:
    MOV DL,"S"
    JMP DISPLAY

PRINT_E:
    MOV DL,"E"

DISPLAY:
    MOV AH, 02H
    INT 21H;
    
    INC BX;
    JMP INNER_LOOP;
    
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