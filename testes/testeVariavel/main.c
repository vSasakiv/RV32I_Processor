/* Arquivo para testar funcionalidade básica: alocar uma variável */
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int main(){
  int a;
  a = 1;
  a = a + 1;
  return 0;
}
