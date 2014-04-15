TITLE Assignment1 (#16)     (Assignment1.asm)

; Add up 1+(2+2)+...+(N-1)+(N-1)+N
; Author: Matthew Yu
; Date Created: 3/3/14
; Last Modification Date: 3/6/14

INCLUDE Irvine32.inc

.data
N dword ?
prompt1 byte "Please input a positive integer:  ",0
prompt2 byte "The sum is:  ",0


.code
main PROC

mov edx, offset prompt1
call writestring		;print prompt1
call readint			;get user inputted integer

mov N,eax
mov ecx,eax			;put input int to ecx counter
mov eax,0			

L1: add eax, ecx
    add eax, ecx
    loop L1

sub eax,N			;minus the doubly added N value
dec eax				;minus the doubly added 1 value

mov edx, offset prompt2
call writeString		;print prompt2

call writeint			;print finalVal

	exit
main ENDP

END main