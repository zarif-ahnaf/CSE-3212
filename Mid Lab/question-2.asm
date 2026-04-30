.MODEL SMALL
.STACK 100H
.DATA
   HASH DB '#','$'
   C DB 'C','$'
   S DB 'S','$'
   E DB 'E','$'       
   ONE DB "1","$"
   SEVEN DB "7","$"
   TAB DB 09h;
   NL DB 0Dh,0Ah,'$'
.CODE      

PRINT PROC
   MOV AH,09H;
   INT 21H;
   RET;
PRINT ENDP

PRINT_HASH_N PROC    
PRINT_HASH:
   LEA DX, HASH;      
   CALL PRINT;   
   LOOP PRINT_HASH;
   RET
PRINT_HASH_N ENDP

             
PRINT_SPACE_N PROC    
PRINT_SPACE:
   MOV DX,32;
   MOV AH,02H;
   INT 21H;
   
   LOOP PRINT_SPACE;
   RET
PRINT_SPACE_N ENDP  

PRINT_NL PROC
  LEA DX,NL;
  CALL PRINT; 
  RET
PRINT_NL ENDP


MAIN PROC  
   MOV AX, @DATA;
   MOV DS,AX;  
   
   MOV CX,07H; First 7 hash
   CALL PRINT_HASH_N;
   
   CALL PRINT_NL;
 
   MOV CX,01H;
   CALL PRINT_SPACE_N;
   
   MOV CX, 01H;
   CALL PRINT_HASH_N;
    
   LEA DX, C;
   CALL PRINT;
   
   LEA DX, S;
   CALL PRINT;
   
   LEA DX, E;
   CALL PRINT
   
   MOV CX, 01H;
   CALL PRINT_HASH_N;
                    
   CALL PRINT_NL;   
   
   MOV CX, 02H;
   CALL PRINT_SPACE_N;
   
   MOV CX, 03H;
   CALL PRINT_HASH_N;
   
   
   CALL PRINT_NL;
   
   MOV CX, 03H;
   CALL PRINT_SPACE_N;
   
   
   LEA DX, ONE;
   CALL PRINT;
   
   CALL PRINT_NL;
   
   MOV CX, 03H;
   CALL PRINT_SPACE_N;
   
   LEA DX, SEVEN;
   CALL PRINT;
                
   CALL PRINT_NL;
   
   MOV CX, 02H;
   CALL PRINT_SPACE_N;
   
   MOV CX, 03H;
   CALL PRINT_HASH_N; 
   
   CALL PRINT_NL;
   
   MOV CX,01H;
   CALL PRINT_SPACE_N;
   
   MOV CX, 01H;
   CALL PRINT_HASH_N;
    
   LEA DX, C;
   CALL PRINT;
   
   LEA DX, S;
   CALL PRINT;
   
   LEA DX, E;
   CALL PRINT
   
   MOV CX, 01H;
   CALL PRINT_HASH_N;
                    
   CALL PRINT_NL;
   
   MOV CX,07H; First 7 hash
   CALL PRINT_HASH_N;   
   
      
   MOV AH, 4CH;
   INT 21H;
MAIN ENDP
END MAIN