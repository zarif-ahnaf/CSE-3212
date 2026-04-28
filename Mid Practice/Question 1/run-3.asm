.MODEL SMALL
.STACK 100H
.DATA
  MSG DB "BAUETCSE",'$'
 
.CODE

MAIN PROC
  ; INIT SEQ
  MOV AX,@DATA
  MOV DS,AX      
                       
  MOV CX, 09H;
  
PRINT_LOOP:
  LEA DX,MSG; 
  MOV AH, 09H;
  INT 21H;
  
  
  LOOP PRINT_LOOP                     
  ; EXIT SEQ
  MOV AX, 4CH;
  INT 21H      
MAIN ENDP
END MAIN