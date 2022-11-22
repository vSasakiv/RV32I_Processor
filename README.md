# Processador RISC-V 32I

Um processador 32-bits que implementa o ISA (Instruction Set Architecture) RISC-V 32I descrito em Verilog. Este processador foi testado por meio de Testbenches e análise de diagramas temporais.

# Compilação

Para realizar a compilação dos arquivos verilog, é primeiro criado a pasta work e em seguida os arquivos são compilados utilizando `vlog <caminho ao arquivo>` presente na ferramenta Questa, e para realizar a simulação de algum Testbench, utilizamos `vsim -c work.<Nome do módulo a ser executado>`. Também é possível utilizar a *makefile* presente neste projeto, para facilitação a compilação de um grande número de arquivos verilog. Para realizar a geração de arquivos *waveform* (.vcd) também é necessário algumas flags de compilação como `-incr` e `+acc` 

## Makefile
Este projeto contem uma makefile utilizada para compilar todos os arquivos verilog (exceto o arquivo de template) presentes no projeto. Esta ferramenta foi apenas testada no sistema operacional Windows, não sendo certa o seu funcionamento em outros ambientes.

## Comandos

~~~shell
make clear
~~~
Este comando é utilizado para limpar a pasta work, que contém códigos de erro e/ou arquivos compilados

~~~shell
make prepare
~~~
Este comando limpa a pasta work e automaticamente executa `vlib work` para refazer os arquivos perdidos antes da limpeza

~~~shell
make modules
~~~
Compila todos os arquivos terminados em mod.v, ou seja, compila apenas todos os módulos

~~~shell
make tests
~~~
Compila todos os arquivos terminados em test.v, ou seja, compila apenas testbenches

~~~shell
make all
~~~
compila todos os arquivos verilog, incluindo modulos e testbenchs.

# Exemplo de execução

TODO IMAGEM GTKWAVE