TITLE Assignment2 #38     (Assignment2.asm)

; reads chars from user into array
; and replaces any digits with sum of neighbors
; Author: Matthew Yu
; Created: 3/5/14
; Last Modified: 3/6/14

INCLUDE Irvine32.inc

.data
input dword ?
prompt1 byte "Please input number of characters to be read:  ",0
prompt2 byte "Please put in characters:  ",0dh,0ah,0
myarray byte 15 dup(?)
finalarray byte lengthof myarray dup(?)


.code
main PROC

mov edx, offset prompt1
call writeString		;prompts user to input a number
call readint			
mov input,eax			;assign the user-inputted number to input

mov edx, offset prompt2
call writestring		;prompts user to put in chars in succession

mov ebx,0
mov ecx,input			;prepare counter
mov input,0

L1: mov eax,0			
    call readchar
    call writechar		;print character user input
    call crlf
    call isdigit		;if input character is a digit
    jz isDig			;then jump to label isDig
    loop L1
    jmp pastisdig		;once all characters read in and myarray is formed, jump to label pastisdig

isDig: sub al,48
       mov [myarray+ebx],al	;store input char to myarray at index of number stored in ebx
       ;call writedec		;prints ascii code of char user inputted			
       inc ebx			;inc myarray index
       inc input
       loop L1

pastisdig:

mov ecx,input			;number of times to loop is the length of myarray - 2
sub ecx,2			;not going to do loop on first and last element of array
mov ebx,0


L3: inc ebx
    mov eax,0    		;set eax since al will hold the sum of the neighbors
    mov edx,ebx			;copy index at ebx to edx
    dec edx			;make ebx index of left neighbor
    add al,[myarray+edx]	;add left neighbor     
    add edx,2			;make ebx index of right neighbor
    add al,[myarray+edx]	;add left neighbor
    mov [finalarray+ebx],al     ;copy this sum to finalarray at index given by ebx
    loop L3


mov ebx,input			;this block puts in finalarray[0] the sum of the 2nd and last index elements
dec ebx				;
mov al,0			;
add al,[myarray+1]		;add the right neighbor (2nd element) of the 1st element
add al,[myarray+ebx]		;add the left neighbor (last element) of the 1st element
mov finalarray,al		;copy this value to finalarray[0]


dec ebx				;this block puts in finalarray[last] the sum of the 2nd to last and 1st index
mov al,0			;
add al,myarray			;add the right neighbor (1st element) of the last element
add al,[myarray+ebx]		;add the left neighbor (2nd to last element) of the last element
inc ebx				;
mov [finalarray+ebx],al		;copy this value to finalarray[last]



call crlf			;
mov ecx,input			;we will print finalarray[ebx] where ebx goes from 0 to (input-1)
mov ebx,0			;
				;
L2: mov eax,0			;
    mov al,[finalarray+ebx]	;mov finalarray[ebx] to al
    call writedec		;print contents of finalarray[ebx]
    call crlf			;
    inc ebx			;mov index to next element
    loop L2			;



	exit
main ENDP

END main