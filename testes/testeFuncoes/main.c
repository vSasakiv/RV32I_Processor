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
  return 0;
}

int funcaoTeste(int a, int b){
  int c;
  c = 5;
  return a + b + c;
}