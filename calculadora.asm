global	_start

section	.data
msg		db		"Hello, world!", 0dh, 0ah, 0
len		equ		$ - msg

section	.text
_start:
		mov		eax, 4		; sys_write
		mov		ebx, 1		; stdout
		mov		ecx, msg	; address
		mov		edx, len	; length
		int		80h			; syscall

		mov		eax, 1		; sys_exit
		mov		ebx, 0		; code
		int		80h
