/* Teste para funcionalidade básica: Funções */
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int funcaoTeste(int, int);

int main(){
  int a, b, c;
  a = 4;
  b = 2;
  c = funcaoTeste(a, b);
  /* ebreak para parar a execução do processador assim que o programa for finalizado */
  asm(
    "ebreak\n\t"
  );
}

int funcaoTeste(int a, int b){
  int c;
  c = 5;
  return a + b + c;
}