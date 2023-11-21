global	_start

section	.data
msg		db		"Hello, world!", 0dh, 0ah, 0
len		equ		$ - msg

section	.text
_start:
		push	msg
		push	len
		call	print

		push	0
		call	exit

print:	enter	0, 0			; create stack frame
		mov		eax, 4			; sys_write
		mov		ebx, 1			; stdout
		mov		ecx, [ebp + 12]	; buffer
		mov		edx, [ebp + 8]	; size
		int		80h				; syscall
		leave					; destroy stack frame
		ret		8				; return and clear parameters

exit:	enter	0, 0			; create stack frame
		mov		eax, 1			; sys_exit
		mov		ebx, [ebp + 8]	; code
		int		80h				; syscall
		leave					; destroy stack frame
		ret		4				; return and clear parameters
