extrn ExitProcess: PROC
extrn GetStdHandle: PROC
extrn WriteConsoleA: PROC

STDOUT EQU -11
.data
	hStdOut dd 0
	szMsg db "this is a test", 0ah
	dwWritten dw 0
.code

main PROC
	mov ecx,STDOUT
	call GetStdHandle
	mov hStdOut,eax
	mov ecx,eax
	lea rdx,szMsg
	mov r8, 15
	lea  r9, dwWritten
	push 0
	call WriteConsoleA
	xor ecx,ecx
	call ExitProcess
	main endp
end