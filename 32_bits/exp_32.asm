section	.text
; Realiza a operação de exponenciação de 32 bits
%define		first	dword	[ebp - 4]
%define		second	dword	[ebp - 8]
%define		result	dword	[ebp - 12]
%define		char	word	[ebp - 14]
op_exp:
	enter	14, 0
	push	eax
	push	ebx
	push	ecx
	push	edx

	call	readi
	mov		first, eax

	call	readi
	mov		second, eax

	mov		result, 1
	mov		ecx, second
.op_exp_l3:
	mov		edx, 0
	mov		eax, result
	imul	first
	mov		result, eax

	cmp		edx, 0
	jg		.op_exp_l2

	cmp		edx, -1
	jl		.op_exp_l2

	loop	.op_exp_l3

	push	result
	call	printi
.op_exp_l1:
	lea		ebx, char
	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_exp_l1

	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	leave
	ret
.op_exp_l2:
	push	EMSG1_SIZE
	push	emsg1
	call	print

	push	1
	call	exit
