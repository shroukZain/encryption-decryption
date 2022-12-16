  ;* This code contains two types of chipers :
 ;*                                           1- MonoNumeric 
 ;*                                           2-MonoAlphaptic             

name "d-encryption"
include 'emu8086.inc'
org 100h 
  
;-------------- Saving Tables --------------
; Storing letters from a to z (lower case)

MOV CX,26                      ; Size of letters in the alphabet
MOV AL,61h                     ; ASCII code for letter 'a'
MOV DI,400h                    ; Hold the offset of memory location in the ES
CLD                            ; clears the direction flag ( DF = 0 ,auto increament)

store_letters:
STOSB                          ; Copies a byte from AL to a memory location in ES. DI is used to hold the offset of the memory location in the ES.
                               ; After the copy, DI is automatically incremented or decremented to point to the next string element in memory.
INC AL                         ; Increases AL value by 1, therefore changing the letter
LOOP store_letters             ; Loops if CX after decrementing by 1 not equal 0

; Store numbers from 1 to 26

MOV CX,26                      ; Size of letters in the alphabet
MOV AL,1                       ; Starting from number 1
MOV DI,460h                    ; Hold the offset of memory location in the ES


store_numbers:
STOSB                          ; Copies a byte from AL to a memory location in ES. DI is used to hold the offset of the memory location in the ES.
                               ; After the copy, DI is automatically incremented or decremented to point to the next number element in memory.
INC AL                         ; Increases AL value by 1, therefore changing the number
LOOP store_numbers             ; Loops if CX after decrementing by 1 not equal 0

JMP start                      ;to start the program

;--------------------------------------------------------------------------------------------------------------------------------------------

encrypt_msg DB 0Dh,0Ah,"Enter a message to encrypt: $"     

encrypted_msg DB 0Dh,0Ah,"Encrypted message: $"

decrypt_msg DB 0Dh,0Ah,"Decrypted message: $"

buffer DB 27,?,27 dup(' ')   
            
;--------------------------------------------------------------------------------------------------------------------------------------------         

									  

table1      DB 97 dup (' '), 'klmnxyzabcopqrstvuwdefghij'                ; store normal letters in table1 at size of 97 

table2      DB 97 dup (' '), 'hijtuvwxyzabcdklmnoprqsefg'                ; store code letters in table2 at size of 97

msg1        DB  0Dh,0Ah,'Enter a message to encrypt: ', '$'              ; store the enter message in msg1 

msg2        DB  'Encrypted message: ', '$'                               ; store the encrepted  message in msg2 

msg3        DB  'Decrypted message: ', '$'                               ; store the decrepted  message in msg3 


msg4        DB  'To Use Monoalphabetic Cipher Enter 1',0Dh,0Ah,'To Use Mononumeric Cipher Enter 2',0Dh,0Ah,'To End The Program Enter 3',0Dh,0Ah,'$'              ; store the starting message in msg4 


msg5        DB  'Thank You For Your Time  ', '$'                         ; store the thank message in msg5
                                                                                            
msg6        DB  'To Use ecryption Enter 1',,0Dh,0Ah,'To Use decryption Enter 2',0Dh,0Ah,'To End The Program Enter 3',0Dh,0Ah,'$'              ; store the choosing message in msg6                                                                                       

n_line      DB  0DH,0AH,'$'                                              ; for new line 

cho         DB  '$'                                                      ; for your choose

str         DB  256 DUP('$')                                             ; buffer string

enc_str     DB  256 DUP('$')                                             ; encrypted string

dec_str     DB  256 DUP('$')                                             ; decrypted string 

Welcome_msg DB  "WELCOME TO CIPHERS PROGRAM: '$'"                        ; welcome massage

;--------------------------------------------------------------------------------------------------------------------------------------------
start:                                                                  ; start program


LEA   DX,Welcome_msg                                                    ; address Welcome-msg with dx
MOV   AH,09h                                                            ; Selecting the sub-function
INT   21h       


LEA  DX ,n_line                                                         ; address n_line with dx
MOV  AH,09h                                                             ; Selecting the sub-function
INT   21h  


; print a choose encryption or decryption of a string at ds:dx
LEA   DX,msg6                                                           ; address msg4 with dx
MOV   AH,09h                                                            ; Selecting the sub-function
INT   21h     

;read the string

PUSH   CS                                                               ; push code segment from stack
POP    DS                                                               ; pop data segment from stack
LEA    DI,cho                                                           ; address cho with di
MOV    DX,000FH                                                         ; exchange dx with 000FH
CALL   GET_STRING                                                       ; call get string function



LEA  DX ,n_line                                                         ; address n_line with dx
MOV  AH,09h                                                             ; Selecting the sub-function
INT   21h                                                               ; Function that outputs a string at DS:DX. String must be terminated by '$'
       
LEA    SI, cho                                                          ; address cho with si
CMP    [SI], '1'                                                        ; compare between "1" and effictive address of si
JE     encryption                                                   ; jump if [si]=1 to monoalphapetic  
CMP    [SI], '2'                                                        ; compare between "2" and effictive address of si        
JE     decryption                                                      ; jump if  [si]=2  to  mononumeric
CMP    [SI], '3'                                                        ; compare between "3" and effictive address of si
JE     exit                                                             ; jump if [si]=3 to exit        
     
         
 
