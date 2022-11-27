/* Teste para funcionalidade básica: operações aritméticas*/
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int main(){
  int a, b, c, d, e, f, g, h;
  a = 3;
  b = 2;
  c = 0;
  
  d = a + b; /* d = 5*/
  e = a - b;  /* e = 1*/
  f = a >> (b-1); /* a = 011 >> 1 -> a = 001*/
  g = a << (b); /* a = 011 << 2 -> a = 1100 */

  /*
  funções não disponíveis / devem ser implementada de forma diferente:
  a = a * b;
  b = b / b;
  c = b / c;
  a = a * b * c; 
  */
  /* ebreak para parar a execução do processador assim que o programa for finalizado */
  asm(
    "ebreak\n\t"
  );
  return 0;
}