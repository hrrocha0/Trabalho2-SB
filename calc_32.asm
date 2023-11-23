global	_start

%define	NULL		0
%define	LF			10
%define	CHAR_ZERO	48

%define NAME_SIZE	30
%define	OPTN_SIZE	1

section	.data
; Variáveis globais inicializadas
nmsg1		db		"Bem-vindo. Digite seu nome:", LF, NULL
NMSG1_SIZE	equ		$ - nmsg1

wmsg1		db		"Hola, ", NULL
WMSG1_SIZE	equ		$ - wmsg1
wmsg2		db		", bem-vindo ao programa de CALC IA-32", LF, NULL
WMSG2_SIZE	equ		$ - wmsg2

omsg1		db		"ESCOLHA UMA OPÇÃO:", LF
			db		"- 1: SOMA", LF
			db		"- 2: SUBTRACAO", LF
			db		"- 3: MULTIPLICACAO", LF
			db		"- 4: DIVISAO", LF
			db		"- 5: EXPONENCIACAO", LF
			db		"- 6: MOD", LF
			db		"- 7: SAIR", LF, NULL
OMSG1_SIZE	equ		$ - omsg1

section	.bss
; Variáveis globais não inicializadas
name		resb	NAME_SIZE
option		resd	OPTN_SIZE

section	.text
; Software Básico (2023.2) - Trabalho 2
; Henrique Rodrigues Rocha: 211036061
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

	push	NAME_SIZE
	push	name
	call	print

	push	WMSG2_SIZE
	push	wmsg2
	call	print
.fetch:
	push	OMSG1_SIZE
	push	omsg1
	call	print

	push	option
	call	readi32

	jmp		.fetch

; Imprime uma string na tela
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - endereço da string
%define	size	dword	[ebp + 12]
%define	address	dword	[ebp + 8]
print:
	enter	0, 0					; cria um novo stack frame
	push	eax						; empilha eax
	push	ebx						; empilha ebx
	push	ecx						; empilha ecx
	push	edx						; empilha edx

	mov		eax, 4					; sys_write
	mov		ebx, 1					; stdout
	mov		ecx, address			; endereço
	mov		edx, size				; tamanho
	int		80h						; syscall

	pop		edx						; desempilha edx
	pop		ecx						; desempilha ecx
	pop		ebx						; desempilha ebx
	pop		eax						; desempilha eax
	leave							; volta ao stack frame anterior
	ret		8						; retorna e desempilha os parâmetros

; Lê uma string do teclado
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - endereço da string
; Retorno: tamanho da string lida, desconsiderando o caractere NULL
%define	size	dword	[ebp + 12]
%define	address	dword	[ebp + 8]
read:
	enter	0, 0					; cria um novo stack frame
	push	ebx						; empilha ebx
	push	ecx						; empilha ecx
	push	edx						; empilha edx

	mov		eax, 3					; sys_read
	mov		ebx, 0					; stdin
	mov		ecx, address			; endereço
	mov		edx, size				; tamanho
	int		80h						; syscall
	dec		eax						; índice do último caractere

	cmp		byte [eax + ecx], LF	; verifica se o último caractere é LF
	jne		.read_done				; se não for, retorna
	mov		byte [eax + ecx], NULL	; define o último caractere como NULL
.read_done:
	pop		edx						; desempilha edx
	pop		ecx						; desempilha ecx
	pop		ebx						; desempilha ebx
	leave							; volta ao stack frame anterior
	ret		8						; retorna e desempilha os parâmetros

; Lê um inteiro de 32 bits do teclado
; Parâmetros:
;	 1 - endereço do inteiro
%define	address	dword	[ebp + 8]
%define buffer	byte	[ebp - 15]
readi32:
	enter	11, 0					; cria um novo stack frame
	push	eax						; empilha eax
	push	ebx						; empilha ebx

	lea		ebx, buffer				; endereço do buffer

	push	11						; tamanho do buffer
	push	ebx						; endereço do buffer
	call	read

	push	eax						; tamanho da string
	push	ebx						; endereço do buffer
	push	address					; endereço do inteiro
	call	stoi32

	pop		ebx						; desempilha ebx
	pop		eax						; desempilha eax
	leave							; volta ao stack frame anterior
	ret		4						; retorna e desempilha os parâmetros

; Transforma uma string em um inteiro de 32 bits
; Parâmetros:
;	 1 - tamanho da string em bytes
;	 2 - endereço da string
;	 3 - endereço do inteiro
%define	address	dword	[ebp + 8]
%define	source	dword	[ebp + 12]
%define	size	dword	[ebp + 16]
%define	value	dword	[ebp - 4]
stoi32:
	enter	0, 0					; cria um novo stack frame
	push	eax						; empilha eax
	push	ebx						; empilha ebx
	push	ecx						; empilha ecx
	push	edx						; empilha edx

	mov		value, 0				; define o valor como 0
	mov		ecx, 0					; define o contador como 0
.stoi32_loop:
	mov		eax, value				; carrega o valor em eax
	shl		eax, 3					; multiplica eax por 8
	shl		value, 1				; multiplica o valor por 2
	add		value, eax				; soma o valor com eax (multiplica o valor por 10)

	mov		ebx, source				; endereço da string
	mov		edx, [ebx + ecx]		; caractere
	sub		edx, CHAR_ZERO			; converte o caractere em inteiro
	add		value, edx				; adiciona esse inteiro a valor

	inc		ecx						; incrementa o contador
	cmp		ecx, size				; verifica se o contador é menor que o tamanho da string
	jl		.stoi32_loop			; se for, repete

	mov		eax, value				; carrega o valor em eax
	mov		ebx, address			; carrega o endereço do inteiro em ebx
	mov		[ebx], eax				; define o inteiro como o valor

	pop		edx						; desempilha edx
	pop		ecx						; desempilha ecx
	pop		ebx						; desempilha ebx
	pop		eax						; desempilha eax
	leave							; volta ao stack frame anterior
	ret		12						; retorna e desempilha os parâmetros

; Termina a execução do programa
; Parâmetros:
;	 1 - Código de saída
%define code	dword	[ebp + 8]
exit:
	enter	0, 0					; cria um novo stack frame
	mov		eax, 1					; sys_exit
	mov		ebx, code				; código de saída
	int		80h						; syscall
