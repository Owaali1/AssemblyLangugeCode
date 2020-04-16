



; comment here.
.686 ; directives start with a period
.model flat,stdcall
option casemap : none ; case-sensitive

ExitProcess PROTO:DWORD

extern printf : proc
extern scanf : proc

.data
	;db means define byte - in assembly there are no 
	; type but you do have sizes  byte mean '8 bit'
szMsg db "welcome to x86 Assembly %s %i",0dh,0ah,0
szMsg2 db "enter your name and age:",0
szInput db "%s %i",0
.data?
	buffer  db 30 dup(?)
	x		dd ?
.code
main proc
	;display the prompt
	push offset szMsg2
	call printf
	pop eax
	
	;get input
	push offset x
	push offset buffer
	push offset szInput
	call scanf
	pop eax
	pop eax
	pop eax
	push x 
	push offset buffer
	push offset szMsg
	call printf
	pop eax
	pop eax
	pop eax
	invoke ExitProcess,0 ; call ExitProcess with parameter 0 
main endp

end main
