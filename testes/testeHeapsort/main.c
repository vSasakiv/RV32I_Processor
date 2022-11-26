/* Teste refinado para teste de maior parte das funções: heapsort*/
/* inicia o stack pointer em 2000, para realizar os testes */
asm(
  "addi sp,zero,2000\n\t"
);

void heapfica (int v[], int n);
void heapsort (int v[], int n);
void rebaixa(int v[], int i, int n);
void sobe (int v[], int i, int n);
void troca (int v[], int i, int j);

int main(){
  int n;
  int v[10];
  n = 10;
  v[0] = 13; // 0x0000000d
  v[1] = -30; // 0xffffffe2
  v[2] = 56; // 0x00000038
  v[3] = -92; // 0xffffffa4
  v[4] = 10; // 0x0000000a
  v[5] = 26; // 0x0000001a
  v[6] = 2; // 0x00000002
  v[7] = -9; // 0xfffffff7
  v[8] = 0; // 0x00000000
  v[9] = 0; // 0x00000000
  
  heapsort(v, n);
  return 0;
}

void troca (int v[], int i, int j){
  int aux = v[i]; 
  v[i] = v[j];
  v[j] = aux;
}


void heapfica (int v[], int n){
  int i;
  for (i = ((n-2) >> 1); i >= 0; i--)
    rebaixa(v, i, n);
}


void heapsort (int v[], int n){
  int i;
  heapfica(v,n);
  for (i=n-1; i>0; i--){
    troca (v, 0, i);
    rebaixa(v, 0, i);
  }
}

void rebaixa(int v[], int i, int n){
  int pai = i, filho = i + i + 1; 

  while (filho < n){
    if (filho+1 < n && v[filho+1] > v[filho])
      filho = filho + 1;
    if (v[pai] > v[filho])
      break;
    troca (v, pai, filho); 
    pai = filho; 
    filho = 2 * pai + 1;
  }
}

void sobe (int v[], int i, int n){
  int filho = i, pai = (i-1) >> 1; 
  while (filho > 0){
    if (v[pai] < v[filho]){
      troca (v,pai,filho);
      filho = pai; 
      pai = (filho-1) >> 1; 
    }
    else break;
  }
}
