; Functional Print of 
; #####
; ##C##
; ##S##
; ##E##
; #####

.MODEL SMALL
.STACK 100H
.DATA
   HASH DB '#','$'
   C DB 'C','$'
   S DB 'S','$'
   E DB 'E','$' 
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

       

MAIN PROC  
   MOV AX, @DATA;
   MOV DS,AX;  
   
   MOV CX,05H;First 5 hash
   CALL PRINT_HASH_N;
   
   LEA DX, NL;
   CALL PRINT;   
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;
   
   LEA DX,C;
   CALL PRINT;
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;  
   
   LEA DX, NL;
   CALL PRINT;  
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;
   
   LEA DX,S;
   CALL PRINT;
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;  
   
   LEA DX, NL;
   CALL PRINT;  
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;
   
   LEA DX,E;
   CALL PRINT;
   
   MOV CX,02H;     
   CALL PRINT_HASH_N;  
   
   LEA DX, NL;
   CALL PRINT;        
   
   MOV CX,05H;First 5 hash
   CALL PRINT_HASH_N;
   

      
   MOV AH, 4CH;
   INT 21H;
MAIN ENDP
END MAIN