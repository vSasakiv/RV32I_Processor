/* Arquivo para testar funcionalidade básica: alocar uma variável */
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int main(){
  int a;
  a = 1;
  a = a + 1;
  /* ebreak para parar a execução do processador assim que o programa for finalizado */
  asm(
    "ebreak\n\t"
  );
}
