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
msg7        DB  0Dh,0Ah,'Enter a message to decrypt: ', '$'              ; store the enter message in msg7 

msg2        DB  'Encrypted message: ', '$'                               ; store the encrepted  message in msg2 

msg3        DB  'Decrypted message: ', '$'                               ; store the decrepted  message in msg3 


msg4        DB  'To Use Monoalphabetic Cipher Enter 1',0Dh,0Ah,'To Use Mononumeric Cipher and deciphering Enter 2',0Dh,0Ah,'To End The Program Enter 3',0Dh,0Ah,'$'              ; store the starting message in msg4 


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
     
     
;-------------------------------------------------------------------------------------------encrypt-----------------------------------------------------------------------------     
encryption:
          
          

; print a choose message-output of a string at ds:dx
LEA   DX,msg4                                                           ; address msg4 with dx
MOV   AH,09h                                                            ; Selecting the sub-function
INT   21h                                                               ; Function that outputs a string at DS:DX. String must be terminated by '$'


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
JE     en_monoalphapetic                                                   ; jump if [si]=1 to monoalphapetic  
CMP    [SI], '2'                                                        ; compare between "2" and effictive address of si        
JE     mononumeric                                                      ; jump if  [si]=2  to  mononumeric
CMP    [SI], '3'                                                        ; compare between "3" and effictive address of si
JE     exit                                                             ; jump if [si]=3 to exit
               
;------------------------- Encrypting mononumeric ----------------------------             

mononumeric:

LEA DX, encrypt_msg                                                    ; Displays "Enter a message to encrypt: " message
MOV AH,9                                                               ; Selecting the sub-function
INT 21h                                                                ; Function that outputs a string at DS:DX. String must be terminated by '$'

; Takes input from user
LEA DX, buffer                                                         ; address buffer with dx
mov AH,0Ah                                                             ; Sub-function that stores input of a string to DS:DX
INT 21h                                                                ; Function that outputs a string at DS:DX. String must be terminated by '$'

; Puts $ at the end to be able to print it later
MOV BX,0                                                               ;load the BX register with 0
MOV BL, buffer[1]                                                      ;moving the content of buffer[1] into register BL
MOV buffer[BX+ 2],'$'                                                  ; put '$' at the end of buffer to print it latter

;------------------- Encrypting -


; Displays "Encrypted message: " message
LEA DX, encrypted_msg                                                  ; mov the effictive addres of the encrypted_msg to the register DX
MOV AH,9                                                               ; Selecting the sub-function
INT 21h                                                                ; interrupt 21h is called to output the string 

; The encryption code
MOV DI,3FFh                                                            ; moving (3FFh) to the register DI
MOV BX,DI                                                              ; moving the content of register DI (33fh) into register bx
LEA SI, buffer[2]                                                      ; load the effictinve address of buffer[2] into register SI

NEXT_CHAR:
CMP [SI],'$'                                                           ; Check if reached end of message
JE end_msg                                                             ; if [SI] <'$'  will jmb to label end_msg

LODSB                                                                  ; Loads first char into AL, then moves SI to next char
CMP AL,'a'                                                             ; compare content of AL minus 'a'
JB NEXT_CHAR                                                           ; If char is invalid, skip it
CMP AL,'z'                                                             ; compare the content of AL minus 'z'
JA NEXT_CHAR                                                           ; if AL > 'z' jmb to NEXT_CHAR ;; char is in valid
XLATB                                                                  ; Encrypt   converts the content of AL into the encrepted number stored in a memory table 
 
 
MOV [SI-1],AL                                                          ; moving the content of AL into [SI-1] "the offset of the SI-1"
MOV AH,0                                                               ; load the AH register with 0
CALL PRINT_NUM_UNS                                                     ; Using a procedure to print unsigne numbers in AX

DEFINE_PRINT_NUM_UNS                                                   ; to declare the procedure  PRINT_NUM_UNS


JMP NEXT_CHAR

end_msg:


; -----------------Decryption
MOV BX,DI                                                               ; moving the content of DI into register BX
LEA SI, buffer[2]                                                       ; load the effictive address of buffer[2] into  register SI


next_num:
CMP [SI],'$'                                                            ; compare  [SI]- '$'
JE end_nums                                                             ; reach the end of the message                                                           


LODSB                                                                   ; Loads byte from DS:SI to AL, then increments SI by 1
CMP AL,1 
JB next_num                                                             ; if content of AL is BELOW 1 jmp to next_num

CMP AL,26
JA next_num                                                             ; IF content of AL is above 26 jmb to next_num
XLATB                                                                   ; Decrypt 

MOV [SI-1],AL                                                           ; moving the contant  of AL register into [SI-1]
JMP next_num                     


end_nums:
LEA DX, decrypt_msg                                                     ; load the effictive address od  decrypt_msg to register DX
MOV AH,9                                                                ; Selecting the sub-function
INT 21h                                                                 ; interrupt 21H  is called to output a string 


; Displays decrypted message
LEA DX, buffer+2                                                        ; load the effictive address of (buffer+2) into register DX
MOV AH,9                                                                ; Selecting the sub-function
INT 21h                                                                 ; interrup 21H is called to output a decripted mssage

; print message-output of a string at ds:dx
LEA    DX,n_line                                                        ; load the effictive address of n_line into register dx
MOV    AH,09h                                                           ; Selecting the sub-function
INT    21h                                                              ; intterrupt 21h is called to output a string


; print message-output of a string at ds:dx
LEA    DX,n_line                                                       ; load the effictive address of n_line into register dx
MOV    AH,09h                                                          ; Selecting the sub-function
INT    21h                                                             ; intterrupt 21h is called to output a string

CALL start                                                             ; print a choose message-output of a string at ds:dx

;------------------------- encrypting monoalphapetic ---------------------------- 


en_monoalphapetic:

           
;print a string that the DS:DX segment:offset pair point to 

LEA    DX,msg1                                                                 ; save the effective address of msg1 in DX register (offset of the string)
MOV    AH,09h                                                                  ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts       
INT    21h                                                                     ; interrupt 21h is called to output the string  


;take the input from a user

PUSH   CS                                                                      ; pushes CS (code segment) into the stack
POP    DS                                                                      ; pops DS (data segment) out of the stack
LEA    DI,str                                                                  ; DI register is to save offset address 
MOV    DX,00FFH                                                                ; DX register is to save the buffer size

CALL   GET_STRING                                                              ; procedure to get string from a user
                                                                               ; the received string is written to buffer at DS:DI , buffer size should be in DX
                                                                               ; procedure stops the input when 'Enter' is pressed 

;print new line

LEA    DX,n_line                                                               ; save the effective address of n_line in DX register (offset of the string)
MOV    AH,09h                                                                  ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h                                                                     ; interrupt 21h is called   

                               
; --------------Encryption---------------------

LEA    BX, table1                                                             ; save the effective address of table1 in BX register
LEA    SI, str                                                                ; save the effective address of str in SI register
LEA    DI, enc_str                                                            ; save the effective address of enc_str in DI register

CALL   parse   

                                          
;print a string that the DS:DX segment:offset pair point to 

LEA    DX,msg2                                                               ; save the effective address of msg2 in DX register (offset of the string)
MOV    AH,09h                                                                ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h                                                                   ; interrupt 21h is called to output the string 
 
 
;print a string that the DS:DX segment:offset pair point to 

LEA    DX, enc_str                                                         ; save the effective address of enc_str in DX register (offset of the string)
MOV    AH, 09h                                                             ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h                                                                 ; interrupt 21h is called to output the string 


;print new line

LEA    DX,n_line                                                          ; save the effective address of n_line in DX register (offset of the string)
MOV    AH,09h                                                             ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h                                                                ; interrupt 21h is called

CALL start   
  

;-------------------------------------------------------------------------------------------decryption-----------------------------------------------------------------------------     
decryption:
          
; print a choose message-output of a string at ds:dx
LEA   DX,msg4                                                           ; address msg4 with dx
MOV   AH,09h                                                            ; Selecting the sub-function
INT   21h                                                               ; Function that outputs a string at DS:DX. String must be terminated by '$'


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
JE     de_monoalphapetic                                                   ; jump if [si]=1 to monoalphapetic  
CMP    [SI], '2'                                                        ; compare between "2" and effictive address of si        
JE     mononumeric                                                      ; jump if  [si]=2  to  mononumeric
CMP    [SI], '3'                                                        ; compare between "3" and effictive address of si
JE     exit                                                             ; jump if [si]=3 to exit




;------------------------- dencrypting monoalphapetic ---------------------------- 


de_monoalphapetic:

           
;print a string that the DS:DX segment:offset pair point to 

LEA    DX,msg7                                                                 ; save the effective address of msg1 in DX register (offset of the string)
MOV    AH,09h                                                                  ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts       
INT    21h                                                                     ; interrupt 21h is called to output the string  


;take the input from a user

PUSH   CS                                                                      ; pushes CS (code segment) into the stack
POP    DS                                                                      ; pops DS (data segment) out of the stack
LEA    DI,str                                                                  ; DI register is to save offset address 
MOV    DX,00FFH                                                                ; DX register is to save the buffer size

CALL   GET_STRING                                                              ; procedure to get string from a user
                                                                               ; the received string is written to buffer at DS:DI , buffer size should be in DX
                                                                               ; procedure stops the input when 'Enter' is pressed 

;print new line

LEA    DX,n_line                                                               ; save the effective address of n_line in DX register (offset of the string)
MOV    AH,09h                                                                  ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h                                                                     ; interrupt 21h is called   

         

;-------Decryption


LEA    BX, table2    							 ; save the effective address of table2 in BX register 
LEA    SI, enc_str   							 ; save the effective address of enc_str in SI register 
LEA    DI, dec_str    							 ; save the effective address of dec_str in DI register

CALL   parse 

;print a string that the DS:DX segment:offset pair point to

LEA    DX,msg3        							; save the effective address of msg3 in DX register (offset of the string)
MOV    AH,09h         							; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h            							; interrupt 21h is called to output the string 


;print a string that the DS:DX segment:offset pair point to

LEA    DX,dec_str    						       ; save the effective address of dec_str in DX register (offset of the string)
MOV    AH,09         						       ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h          						       ; interrupt 21h is called to output the string

;print new line

LEA    DX,n_line       						      ; save the effective address of n_line in DX register (offset of the string)
MOV    AH,09h          						      ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h             						      ; interrupt 21h is called
             

;print new line

LEA    DX,n_line       						     ; save the effective address of n_line in DX register (offset of the string)
MOV    AH,09h          						     ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
INT    21h             						     ; interrupt 21h is called


CALL start

;------------------------------------------------procedures-----------------------------------------------------------
;table1:    'qwertyuiopasdfghjklzxcvbnm'

;table2:    'kbumcngphqrszyijadlewgbvft'  


parse proc near                  				   ; Define parse procedure
    
nextchar:

	cmp    [SI], '$'         				  ; end of string?
	je     end_of_string     				  ; jump to end_of_string if ([si] == '$') 
	
	cmp    [SI], ' '         				  ; space?
	je     skip              				  ; jump to skip if ([si] == ' ')
	
	mov    AL, [SI]          			          ; move one character (8 bits - one byte) from DS:SI to AL register
	
	cmp    AL, 'a'           
	jb     skip             				 ; jump to skip if (al < 'a')
	
	cmp    AL, 'z'
	ja     skip	        				 ; jump to skip if (al > 'z')
	
	               
	xlatb          						 ; xlat algorithm: al = ds:[bx + unsigned al]   
	              						 ; AL -holds index into table     
		      						 ; BX -holds offset to base of table to use.
		                                                    
	mov    [DI], AL
	inc    DI
	

skip:
	inc    SI	
	jmp    nextchar
	

end_of_string:

   	inc    SI
    mov    [SI], '$'
    
     
ret              					       ; To resume execution flow at the instruction following the call

parse endp         
   
   
   
           
      
exit:       

	;print new line

	LEA    DX,n_line       				     ; save the effective address of n_line in DX register (offset of the string)
	MOV    AH,09h          				     ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
	INT    21h             				     ; interrupt 21h is called


	LEA    DX,msg5         				    ; save the effective address of msg5 in DX register (offset of the string)
	MOV    AH,09h          				    ; moving (09h) to the register ah to select sub-function 9 of the interrupt 21h DOS interrupts
	
	INT    21h             				    ; interrupt 21h is called to output the string

DEFINE_GET_STRING     					    ; predefined macro in umu8086.inc to read a string input 

end
