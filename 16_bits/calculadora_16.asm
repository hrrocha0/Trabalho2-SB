global	_start
; Constantes
%define		OPTN_ADD	1
%define		OPTN_SUB	2
%define		OPTN_MUL	3
%define		OPTN_DIV	4
%define		OPTN_EXP	5
%define		OPTN_MOD	6
%define		OPTN_END	7

%define		TRUE		1
%define		FALSE		0

%define		NAME_SIZE	30
%define		LF			10

%define		SYS_EXIT	1
%define		SYS_READ	3
%define		SYS_WRITE	4

%define		STDIN		0
%define		STDOUT		1

section	.data
; Variáveis globais inicializadas
nmsg1		db		"Bem-vindo. Digite seu nome:", LF
NMSG1_SIZE	equ		$ - nmsg1

wmsg1		db		"Olá, "
WMSG1_SIZE	equ		$ - wmsg1

wmsg2		db		", bem-vindo ao programa de CALC IA-32", LF
WMSG2_SIZE	equ		$ - wmsg2

omsg1		db		"ESCOLHA UMA OPÇÃO:", LF
			db		"- 1: SOMA", LF
			db		"- 2: SUBTRACAO", LF
			db		"- 3: MULTIPLICACAO", LF
			db		"- 4: DIVISAO", LF
			db		"- 5: EXPONENCIACAO", LF
			db		"- 6: MOD", LF
			db		"- 7: SAIR", LF
OMSG1_SIZE	equ		$ - omsg1

emsg1		db		"OCORREU OVERFLOW", LF
EMSG1_SIZE	equ		$ - emsg1

section	.bss
; Variáveis globais não inicializadas
name		resb	NAME_SIZE
option		resd	1

section	.text
; Software Básico (2023.2) - Trabalho 2
; Henrique Rodrigues Rocha: 211036061
; Vinícius de Sousa Brito: 211042748
_start:
	push	NMSG1_SIZE
	push	nmsg1
	call	print

	push	NAME_SIZE
	push	name
	call	read

	push	WMSG1_SIZE
	push	wmsg1
	call	print

	dec		eax
	push	eax
	push	name
	call	print

	push	WMSG2_SIZE
	push	wmsg2
	call	print
.fetch:
	push	OMSG1_SIZE
	push	omsg1
	call	print

	call	readi
	mov		[option], eax

	push	eax
	call	execute

	jmp		.fetch

; Realiza uma operação
; Parâmetros:
;	 1 - código da operação
; Retorno: nenhum
%define		code	dword	[ebp + 8]
execute:
	enter	0, 0

	cmp		code, OPTN_ADD
	je		.execute_l1
	cmp		code, OPTN_SUB
	je		.execute_l2
	cmp		code, OPTN_MUL
	je		.execute_l3
	cmp		code, OPTN_DIV
	je		.execute_l4
	cmp		code, OPTN_EXP
	je		.execute_l5
	cmp		code, OPTN_MOD
	je		.execute_l6
	cmp		code, OPTN_END
	je		.execute_l7

	jmp		.execute_l8
.execute_l1:
	call	op_add
	jmp		.execute_l8
.execute_l2:
	call	op_sub
	jmp		.execute_l8
.execute_l3:
	call	op_mul
	jmp		.execute_l8
.execute_l4:
	call	op_div
	jmp		.execute_l8
.execute_l5:
	call	op_exp
	jmp		.execute_l8
.execute_l6:
	call	op_mod
	jmp		.execute_l8
.execute_l7:
	push	0
	call	exit
.execute_l8:
	leave
	ret		4

; Imprime uma string na tela
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - ponteiro para a string
; Retorno: nenhum
%define		size	dword	[ebp + 12]
%define		address	dword	[ebp + 8]
print:
	enter	0, 0
	push	eax
	push	ebx
	push	ecx
	push	edx

	mov		eax, SYS_WRITE
	mov		ebx, STDOUT
	mov		ecx, address
	mov		edx, size
	int		80h

	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	leave
	ret		8

; Lê uma string do teclado
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - endereço da string
; Retorno: quantidade de caracteres
%define		size	dword	[ebp + 12]
%define		address	dword	[ebp + 8]
read:
	enter	0, 0
	push	ebx
	push	ecx
	push	edx

	mov		eax, SYS_READ
	mov		ebx, STDIN
	mov		ecx, address
	mov		edx, size
	int		80h

	pop		edx
	pop		ecx
	pop		ebx
	leave
	ret		8

; Imprime um inteiro na tela
; Parâmetros:
;	 1 - valor do inteiro
; Retorno: nenhum
%define		integer	word	[ebp + 8]
%define		string	dword	[ebp - 4]
printi:
	enter	11, 0
	push	ebx

	lea		ebx, [ebp - 11]
	mov		string, ebx

	push	integer
	push	7
	push	string
	call	itos

	push	eax
	push	string
	call	print

	pop		ebx
	leave
	ret		2

; Lê um inteiro do teclado
; Parâmetros: nenhum
; Retorno: valor do inteiro
%define		string	dword	[ebp - 4]
readi:
	enter	11, 0
	push	ebx

	lea		ebx, [ebp - 11]
	mov		string, ebx

	push	7
	push	string
	call	read

	dec		eax
	push	eax
	push	string
	call	stoi

	pop		ebx
	leave
	ret

; Converte um inteiro em uma string
; Parâmetros:
;	 1 - valor do inteiro
;	 2 - tamanho da string em bytes
;	 3 - ponteiro para a string
; Retorno: quantidade de caracteres
%define		integer	word	[ebp + 16]
%define		size	dword	[ebp + 12]
%define		string	dword	[ebp + 8]
%define		buffer	dword	[ebp - 4]
%define		value	word	[ebp - 6]
%define		char	word	[ebp - 8]
%define		digit	word	[ebp - 10]
%define		minus	word	[ebp - 12]
itos:
	enter	19, 0
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi

	lea		ebx, [ebp - 19]
	mov		buffer, ebx

	mov		ax, integer
	mov		value, ax

	mov		minus, FALSE
	mov		esi, 0
	mov		edi, 0

	cmp		value, 0
	jge		.itos_l1

	mov		minus, TRUE
	neg		value
.itos_l1:
	mov		ax, value
	mov		dx, 0
	mov		cx, 10
	idiv	cx

	mov		value, ax
	mov		digit, dx

	add		dl, '0'
	mov		char, dx

	mov		[ebx + esi], dl

	inc		esi

	cmp		value, 0
	jne		.itos_l1

	cmp		minus, TRUE
	jne		.itos_l2

	mov		ebx, string
	mov		byte [ebx], '-'

	inc		edi
.itos_l2:
	cmp		esi, 0
	jbe		.itos_l3

	cmp		edi, size
	jae		.itos_l3

	dec		esi

	mov		eax, 0
	mov		ebx, buffer
	mov		al, [ebx + esi]
	mov		char, ax

	mov		ebx, string
	mov		[ebx + edi], al

	inc		edi
	jmp		.itos_l2
.itos_l3:
	mov		eax, edi

	pop		edi
	pop		esi
	pop		edx
	pop		ecx
	pop		ebx
	leave
	ret		10

; Converte uma string em um inteiro
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - ponteiro para a string
; Retorno: valor do inteiro
%define		size	dword	[ebp + 12]
%define		string	dword	[ebp + 8]
%define		value	word	[ebp - 2]
%define		char	word	[ebp - 4]
%define		digit	word	[ebp - 6]
%define		minus	word	[ebp - 8]
stoi:
	enter	8, 0
	push	ebx
	push	edx
	push	esi

	mov		value, 0
	mov		minus, FALSE
	mov		esi, 0

	mov		eax, 0
	mov		ebx, string
	mov		al, [ebx]
	mov		char, ax

	cmp		al, '-'
	jne		.stoi_l1

	mov		minus, TRUE

	inc		esi
.stoi_l1:
	cmp		esi, size
	jae		.stoi_l2

	mov		ax, value
	mov		dx, 0
	imul	ax, 10

	mov		dl, [ebx + esi]
	mov		digit, dx

	sub		dl, '0'
	mov		char, dx

	add		ax, dx
	mov		value, ax

	inc		esi
	jmp		.stoi_l1
.stoi_l2:
	cmp		minus, TRUE
	jne		.stoi_l3

	neg		value
.stoi_l3:
	mov		ax, value

	pop		esi
	pop		edx
	pop		ebx
	leave
	ret		8

; Termina a execução do programa
; Parâmetros:
;	 1 - código de saída
; Retorno: nenhum
%define		code	dword	[ebp + 8]
exit:
	enter	0, 0
	mov		eax, SYS_EXIT
	mov		ebx, code
	int		80h

; Includes
%include	"add_16.asm"
%include	"sub_16.asm"
%include	"mul_16.asm"
%include	"div_16.asm"
%include	"exp_16.asm"
%include	"mod_16.asm"
