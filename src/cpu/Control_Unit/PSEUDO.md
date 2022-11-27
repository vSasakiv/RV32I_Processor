# Conjunto de pseudocódigos para decodificação de instruções

## Entradas

## Instrução (I)
Palavra de 32 bits que contém um código que representa uma série de operações a ser realizado pelo processador

## Clock (clk)
Sinal períodico utilizado para fazer o processador prosseguir sua execução.

## Portas

## Alu_sel_a
Porta responsável por escolher a primeira entrada da ALU (primária), podendo ser o registrador RS1 ou o Program Counter <br>
>Alu_sel_a = 0, seleciona o registrador RS1 <br>
>Alu_sel_a = 1, seleciona program counter PC <br>

## Alu_sel_b
Porta responsável por escolher a segunda entrada da ALU (primária), podendo ser o registrador RS2 ou um imediato <br>
>Alu_sel_b = 0, seleciona registrador RS2 <br>
>Alu_sel_b = 1, seleciona imm <br>

## sub_sra
Sinal responsável por decidir se deve ser realizada uma subtração ao invés de uma soma ou um shift aritmético ao invés de um shift lógico <br>
>sub_sra = 0, operações convencionais <br>
>sub_sra = 1, operações subtração e shift aritmético <br>

## mem_extend
Códigos para extensão de valores provenientes da memória, integrado na própria instrução
> mem_extend = 000, guarda um byte extendido signed <br>
> mem_extend = 001, guarda uma halfword extendida signed <br>
> mem_extend = 010, guarda uma word, não é necessário extensão pois não existem zeros à esquerda <br>
> mem_extend = 100, guarda um byte extendido unsigned <br>
> mem_extend = 101, guarda uma halfword extendida unsigned

## mem_size
Código utilizado para saber que tamanho deve ser armazenado na memória, podendo ser um byte (8 bits), uma halfword (16 bits) ou uma word (32 bits).
> mem_size = 00, armazena byte
> mem_size = 01, armazena halfword
> mem_size = 10, armazena word

## Addr_sel
Sinal que seleciona se o endereço a acessar na RAM deve ser o Program Counter (possívelmente acessando uma instrução) ou o valor da ALU (possível executando um store)
>Addr_sel = 0, seleciona o PC para endereço atual <br>
>Addr_sel = 1, selecionando resultado da ALU para o endereço atual <br>

## Rd_sel
Sinal que seleciona qual valor deve ir para a entrada da regfile
>Rd_sel = 00, selecionando valor da memória para o RD <br>
>Rd_sel = 01, selecionando imediato para o RD <br>
>Rd_sel = 10, selecionando resultado da ALU para o RD <br>
>Rd_sel = 11, Program Counter incrementado para o RD<br>

## Pc_next_sel
Sinal que seleciona qual deverá ser o próximo valor irá para o data do registrador PC (Program Counter)
>Pc_next_sel = 0, Program Counter recebe program counter + 4 <br>
>Pc_next_sel = 1, Program Counter recebe resultado da alu <br>

## Pc_alu_sel
Sinal que seleciona qual deve ser o valor que será enviado para a segunda entrada da ALU do Program Counter, podendo ser o 4 padrão (para passar para a próxima instrução) ou um imediato
>Pc_alu_sel = 0, incrementa Program Counter de 4 <br>
>Pc_alu_sel = 1, incrementa Program Counter de um valor arbitrário <br>

## Rd_clk
Toda vez que esse sinal emite uma borda de subida, o registrador destino selecionado irá receber o valor de entrada

## mem_clk
Toda vez que esse sinal emite uma borda de subida, a memória RAM irá gravar o conteúdo em sua porta de entrada no endereço selecionado

## Instruções do tipo R
Instruções que, geralmente, realizam operações na ALU primária entre dois registradores
```
If (I[6:0] == 0110011)
  RSA = I[19:15]
  RSB = I[24:20]
  RD = I[11:7]
  FUNC3 = I[14:12]
  If (FUNC3 == 010 || FUNC3 == 011)
    Sub_sra = 1
  Else
    Sub_sra = I[30]
  mem_extend = x
  mem_size = xx

  Alu_sel_a = 0
  Alu_sel_b = 0
  Addr_sel = 0

  Rd_sel = 10
  Pc_next_sel = 0
  Pc_alu_sel = 0

  rc_clk = clk
```

## Instruções do tipo I
Instruções que se utilizam de valores imediatos para realizar suas funções
## Instruções LOAD
Instruções utilizadas para carregar um valor da memória para um registrador
```
If (I[6:0] == 0000011)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  FUNC3 = 000
  sub_sra = 0
  mem_extend = I[14:12]
  mem_size = xx

  Alu_sel_a = 0
  Alu_sel_b = 1

  Rd_sel = 00
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  rd_clk = clk
  Addr_sel = ~clk
```

## Instruções ALU
Instruções utilizadas para realizar uma operação com a ALU primária entre o valor contido em um registrador, e um imediato
```
If (I[6:0] == 0010011)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  Func3 = I[14:12]
  mem_extend = x
  mem_size = xx

  If (FUNC3 == 010 || FUNC3 == 011)
    Sub_sra = 1
  Else if (FUNC3 == 101)
    Sub_sra = I[30]
  else
    Sub_sra = 0

  Alu_sel_a = 0
  Alu_sel_b = 1
  Addr_sel = 0

  Rd_sel = 10
  Pc_next_sel = 0
  pc_alu_sel = 0

  rd_clk = clk
```

## JARL
Instrução que armazena o valor do Program Counter + 4 no registrador destino, e depois muda o Program Counter para o endereço dado pela soma do registrador rs1 com o imediato
```
If (I[6:0] == 1100111)
  RSA = I[19:15]
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  mem_extend = x
  mem_size = xx

  Alu_sel_a = 0
  Alu_sel_b = 1
  Addr_sel = 0

  Rd_sel = 11
  Pc_next_sel = 1
  pc_alu_sel = 0

  rd_clk = clk
```

## Instruções tipo U
Instruções que se utilizam de um imediato maior (20 bits) e um registrador de destino (rd)
## Instrução LUI
Instrução que armazena o imediato no registrador destino
```
If (I[6:0] == 0110111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = x
  sub_sra = x
  mem_extend = x
  mem_size = xx

  Alu_sel_a = x
  Alu_sel_b = x
  Addr_sel = 0

  Rd_sel = 01
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  rd_clk = clk
```

## Instrução AUIPC
Instrução que armazena o valor da soma do Program Counter com o imediato no registrador destino
```
If (I[6:0] == 0010111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  mem_extend = x
  mem_size = xx

  Alu_sel_a = 1
  Alu_sel_b = 1
  Addr_sel = 0

  Rd_sel = 10
  Pc_next_sel = 0
  pc_alu_sel = 0
  
  rd_clk = clk
```

## Instrução Tipo J (Jal)
Instrução *jump and link*, armazena no registrador destino o valor do Program Counter incrementado em 4, e depois altera o Program Counter para a sua soma com o imediato.
```
If (I[6:0] == 1101111)
  RSA = x
  RSB = x
  RD = I[11:7]
  Func3 = 000
  sub_sra = 0
  mem_extend = x
  mem_size = xx

  Alu_sel_a = 1
  Alu_sel_b = 1
  Rd_sel = 11

  rd_clk = clk
  
  Addr_sel = 0
  Pc_next_sel = ~clk
  pc_alu_sel = clk
```

## Instruções Tipo B (branches)
Instruções *branch*, verifica uma igualdade ou desigualdade entre os registradores rs1 e rs2, e caso ela seja verdade, soma o valor imediato ao Program Counter
```
If (I[6:0] == 1100011)
  RSA = I[19:15]
  RSB = I[24:20]
  RD = x
  Func3 = 000
  Sub_sra = 1
  mem_extend = x
  mem_size = xx

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
  
```

## Instruções tipo S (stores)
Instruções que armazenam um valor do registrador na memória, colocando o valor do registrador rs2 no endereço dado pela soma do registrador rs1 com o imediato
```
If (I[6:0] == 0100011)
  RSA = I[19:15]
  RSB = I[24:20]
  RD = x
  Func3 = 000
  sub_sra = 0
  mem_extend = x
  mem_size = I[13:12]

  Alu_sel_a = 0
  Alu_sel_b = 1
  rd_sel = x

  
  Pc_next_sel = 0
  pc_alu_sel = 0

  mem_clk = clk
  Addr_sel = ~clk
```
