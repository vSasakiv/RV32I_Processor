/* Teste para funcionalidade básica: Recursão */
/* inicia o stack pointer em 1000, para realizar os testes */
asm(
  "addi sp,zero,1000\n\t"
);
int multiplica(int, int);

int main(){
  int a, b;
  a = 5;
  b = 3;
  multiplica(a, b);
}

int multiplica (int a, int b){
  int c = 2;
  if (a == 0)
    return c;
  return b + multiplica(a-1, b) + c;
}

