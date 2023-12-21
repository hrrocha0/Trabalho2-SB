section	.text
; Realiza a operação de adição de 16 bits
%define		first	word	[ebp - 2]
%define		second	word	[ebp - 4]
%define		result	word	[ebp - 6]
%define		char	word	[ebp - 8]
op_add:
	enter	8, 0
	push	ax
	push	bx

	call	readi
	mov		first, ax

	call	readi
	mov		second, ax

	mov		ax, first
	add		ax, second
	mov		result, ax

	cwde
	push	eax
	call	printi
.op_add_l1:
	lea		ebx, char

	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_add_l1

	pop		ebx
	pop		eax
	leave
	ret
