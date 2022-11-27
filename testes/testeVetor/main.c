/* Teste para funcionalidade básica: uso e alocamento de vetores*/
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int main(){
  int v[6];
  v[0] = 1;
  v[1] = v[0] + 1;
  v[2] = 3;
  v[3] = 890;
  v[4] = v[3] - v[2];
  v[5] = -90;
  /* ebreak para parar a execução do processador assim que o programa for finalizado */
  asm(
    "ebreak\n\t"
  );
}
