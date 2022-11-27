/* Teste para funcionalidade básica: Recursão */
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int multiplicainc(int, int);

int main(){
  int a, b;
  a = 5;
  b = 3;
  multiplicainc(a, b);
  /* ebreak para parar a execução do processador assim que o programa for finalizado */
  asm(
    "ebreak\n\t"
  );
}

int multiplicainc (int a, int b){
  int c = 2;
  if (a == 0)
    return c;
  return b + multiplicainc(a-1, b) + c;
}

