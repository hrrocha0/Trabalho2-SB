# Software Básico (2023.2) - Trabalho 2
- Henrique Rodrigues Rocha: 211036061
- Vinícius de Sousa Brito: 211042748

## Informações
Aqui constam informações a respeito do desenvolvimento do trabalho:

- O código foi feito para sistemas **Linux** de 32 *bits*, no formato **elf32**, por meio do montador **NASM**.
- Os testes do código foram executados em uma máquina com **Windows 10**, utilizando o **WSL** para rodar o programa na distribuição **Ubuntu**.

## Instruções

### Calculadora de 32 bits

Para montar, ligar e executar a calculadora de 32 bits, basta executar os seguintes comandos:

#### Montagem:

```shell
nasm -f elf32 -i 32_bits/ -o 32_bits/calculadora_32.o 32_bits/calculadora_32.asm
```

#### Ligação:

```shell
ld -m elf_i386 -o 32_bits/calculadora_32 32_bits/calculadora_32.o
```

#### Execução:

```shell
./32_bits/calculadora_32
```

### Calculadora de 16 bits

Para montar, ligar e executar a calculadora de 32 bits, basta executar os seguintes comandos:

#### Montagem:

```shell
nasm -f elf32 -i 16_bits/ -o 16_bits/calculadora_16.o 16_bits/calculadora_16.asm
```

#### Ligação:

```shell
ld -m elf_i386 -o 16_bits/calculadora_16 16_bits/calculadora_16.o
```

#### Execução:

```shell
./16_bits/calculadora_16
```
