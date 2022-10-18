# Conjunto pseudocódigos para decodificação de instruções

Decodificador:
Sendo I a instrução

## Portas

Alu_sel_a = 0, seleciona o registrador RS1 <br>
Alu_sel_a = 1, seleciona program counter PC <br>

Alu_sel_b = 0, seleciona registrador RS2 <br>
Alu_sel_b = 1, seleciona imm <br>

sub_sra = 0, operações convencionais <br>
sub_sra = 1, operações subtração e shift aritmético <br>

sx_size: Códigos para extensão de valores provenientes da memória

Addr_sel = 0, seleciona o PC para endereço atual <br>
Addr_sel = 1, selecionando resultado da ALU para o endereço atual <br>

Rd_sel = 00, selecionando valor da memória para o RD <br>
Rd_sel = 01, selecionando imm para o RD <br>
Rd_sel = 10, selecionando resultado da alu para o RD <br>
Rd_sel = 11, program counter incrementado de 4 para o RD<br>

Pc_next_sel = 0, program counter recebe program counter + 4 <br>
Pc_next_sel = 1, program counter recebe resultado da alu <br>

Pc_alu_sel = 0, incrementa pc de 4 <br>
Pc_alu_sel = 1, incrementa pc de um valor arbitrário <br>

## Instruções do tipo R

```
If (I[6:0] == 0110011)
  RSA = I[19:15]
  RSB = I[24:20]
  RD = I[11:7]
  FUNC3 = I[14:12]
  If (FUNC3 == 010 || FUNC3 == 011)
    Sub_sra = 1;
  Else
    Sub_sra = I[30]
  sx_size = x

  Alu_sel_a = 0;
  Alu_sel_b = 0;
  Addr_sel = 0;

  Rd_sel = 10;
  Pc_next_sel = 0;
  Pc_alu_sel = 0;

  Sobe e desce rd_clk
```

## Instruções do tipo I

## Instruções LOAD
```
If (I[6:0] == 0000011)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  FUNC3 = 000
  sub_sra = 0
  sx_size = I[14:12]

  Alu_sel_a = 0
  Alu_sel_b = 1
  Addr_sel = 1

  Rd_sel = 00
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  Sobe e desce rd_clk

  Addr_sel = 0
```

## Instruções ALU

```
If (I[6:0] == 0010011)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  Func3 = I[14:12]
  sx_size = x

  If (FUNC3 == 010 || FUNC3 == 011)
    Sub_sra = 1;
  Else if (FUNC3 == 101)
    Sub_sra = I[30];
  else
    Sub_sra = 0;

  Alu_sel_a = 0;
  Alu_sel_b = 1;
  Addr_sel = 0;

  Rd_sel = 10;
  Pc_next_sel = 0
  pc_alu_sel = 0

  Sobe e desce rd_clk
```

## JARL

```
If (I[6:0] == 1100111)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  sx_size = x

  Alu_sel_a = 0;
  Alu_sel_b = 1;
  Addr_sel = 0;

  Rd_sel = 11;
  Pc_next_sel = 1;
  pc_alu_sel = 0;

  Sobe e desce rd_clk
```

## Instruções tipo U

## Instrução LUI
```
If (I[6:0] == 0110111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = x
  sub_sra = x
  sx_size = x

  Alu_sel_a = x
  Alu_sel_b = x
  Addr_sel = 0

  Rd_sel = 01
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  Sobe e desce rd_clk
```

## Instrução AUIPC

```
If (I[6:0] == 0010111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  sx_size = x

  Alu_sel_a = 1
  Alu_sel_b = 1
  Addr_sel = 0

  Rd_sel = 10
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  Sobe e desce rd_clk
```

## Instrução Tipo J (Jal)

```
If (I[6:0] == 1101111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  sx_size = x

  Alu_sel_a = 1
  Alu_sel_b = 1
  Rd_sel = 11

  Sobe e desce rd_clk

  Addr_sel = 0
  Pc_next_sel = 0
  pc_alu_sel = 1

  (sobe e desce pc_clk)
```

## Instruções Tipo B (branches)

```
If (I[6:0] == 1100011)
  RSA = [19:15]
  RSB = [24:20]
  RD = x
  Func3 = 000
  Sub_sra = 1
  sx_size = x

  Alu_sel_a = 0
  Alu_sel_b = 0
  rd_sel = x

  Addr_sel = 0
  pc_next_sel = 0

  Case (I[14:12])
    000: pc_alu_sel = EQ
    001: pc_alu_sel = ~EQ
    100: pc_alu_sel = LS
    101: pc_alu_sel = ~LS
    110: pc_alu_sel = LU
    111: pc_alu_sel = ~LU
  
(pc clk sobe e desce)
```

## Instruções tipo S (stores)

```
If (I[6:0] == 0100011)
  RSA = [19:15]
  RSB = [24:20]
  RD = x
  Func3 = 000
  sub_sra = 0
  sx_size = x

  Alu_sel_a = 0
  Alu_sel_b = 1
  rd_sel = x

  Addr_sel = 1
  Pc_next_sel = 0
  pc_alu_sel = 0

  Sobe e desce mem_clk
  
  Addr_sel = 0
```
