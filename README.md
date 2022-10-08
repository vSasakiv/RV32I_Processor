# processador_RV32I
TODO

# Makefile
Este projeto contem uma makefile utilizada para compilar todos os arquivos verilog (exceto o arquivo de template) presentes no projeto.

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