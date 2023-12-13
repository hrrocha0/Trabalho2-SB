section	.text
; Realiza a operação de multiplicação
%define		first	dword	[ebp - 4]
%define		second	dword	[ebp - 8]
%define		result	dword	[ebp - 12]
%define		char	word	[ebp - 14]
op_mul:
	enter	14, 0
	push	eax
	push	ebx
	push	edx

	call	readi
	mov		first, eax

	call	readi
	mov		second, eax

	mov		edx, 0
	mov		eax, first
	imul	second
	mov		result, eax

	cmp		edx, 0
	je		.op_mul_l1
	cmp		edx, -1
	je		.op_mul_l1

	push	EMSG1_SIZE
	push	emsg1
	call	print

	push	1
	call	exit
.op_mul_l1:
	push	eax
	call	printi
.op_mul_l2:
	lea		ebx, char

	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_mul_l2

	pop		edx
	pop		ebx
    pop		eax
	leave
	ret
