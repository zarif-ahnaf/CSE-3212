.MODEL SMALL
.STACK 100H

.DATA
  MSG DB "BAUETCSE","$"

.CODE


MAIN PROC
   MOV AX, @DATA
   MOV DS, AX;
   
   MOV CX, 09;
   
PRINT:
   LEA DX, MSG;
   MOV AH,09h;
   INT 21H;
   
   LOOP PRINT
   
   ; Loop Ends here
   MOV AX, 4CH;
   INT 21H;
        
MAIN ENDP
END MAIN