#include <stdio.h>
#include <stdlib.h>

int * INSN (int TipoIns);
int * DecimalToBinary (int Decimal);
void INSNrd (int * INSN, int * rd, int Drd);
void INSNrs1 (int * INSN, int * rs1, int Drs1);
void INSNrs2 (int * INSN, int * rs2, int Drs2);
void UImm (int * INSN, int * imm, unsigned int Dimm);
void Binsn (int * INSN, int FUNC, int * rs1, int * rs2, int * imm, int Drs1, int Drs2, unsigned int Dimm);
void LOADinsn (int * INSN, int FUNC, int * rs1, int * rd, int * imm, int Drs1, int Drd, unsigned int Dimm);
void STOREinsn (int * INSN, int FUNC, int * rs1, int * rs2, int * imm, int Drs1, int Drs2, unsigned int Dimm);
void Iinsn (int * INSN, int FUNC, int * rs1, int * rd, int * imm, int Drs1, int Drd, unsigned int Dimm);
void Rinsn (int * INSN, int FUNC, int * rs1, int * rs2, int * rd, int Drs1, int Drs2, int Drd);
void ListaINSN();

int main () {
    int TipoIns;
    int j, S = 1, * i;


    while (S) {
        printf("Digite o tipo da instrucao ou 0 para ver a lista de insn: ");
        scanf("%d", &TipoIns); 

        while (!TipoIns) {
            ListaINSN();
            printf("Digite o tipo da instrucao ou 0 para ver a lista de insn: ");
            scanf(" %d", &TipoIns); 
        }

        i = INSN (TipoIns);

        printf("Binario: ");
        for (j = 0; j < 32; j++)
            printf("%d", i[j]);
        printf("\n");

    }
    return 0;
}

/* Constrói em um vetor o binário da instrução escolhida */
int * INSN  (int TipoIns) {
    unsigned int Dimm;
    int Drd, Drs1, Drs2, FUNC;
    int * rd, * rs1, * rs2, * imm; 
    int * INSN = malloc (32*sizeof(int));
    int i;
    
    for (i = 0; i < 32; i++)
        INSN[i] = 0;

    /* lui */
    if (TipoIns == 1) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("imm:");
        scanf("%x", &Dimm);

        printf("Instrucao: lui x%d, 0x%x\n", Drd, Dimm);
        INSN[31] = 1;
        INSN[30] = 1;
        INSN[29] = 1;
        INSN[28] = 0;
        INSN[27] = 1;
        INSN[26] = 1;
        INSN[25] = 0;

        INSNrd (INSN, rd, Drd);
        UImm (INSN, imm, Dimm);  
    }
    
    /* auipc */
    if (TipoIns == 2) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("imm:");
        scanf("%x", &Dimm);

        printf("Instrucao: auipc x%d, 0x%x\n", Drd, Dimm);

        INSN[31] = 1;
        INSN[30] = 1;
        INSN[29] = 1;
        INSN[28] = 0;
        INSN[27] = 1;
        INSN[26] = 0;
        INSN[25] = 0;

        INSNrd (INSN, rd, Drd);
        UImm (INSN, imm, Dimm); 
    }

    /* jal */
    if (TipoIns == 3) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("imm:");
        scanf("%x", &Dimm);

        printf("Instrucao: jal x%d, 0x%x\n", Drd, Dimm);

        INSN[31] = 1;
        INSN[30] = 1;
        INSN[29] = 1;
        INSN[28] = 1;
        INSN[27] = 0;
        INSN[26] = 1;
        INSN[25] = 1;

        INSNrd (INSN, rd, Drd);

        imm = DecimalToBinary(Dimm);
        INSN[19] = imm[19];
        INSN[18] = imm[18];
        INSN[17] = imm[17];
        INSN[16] = imm[16];
        INSN[15] = imm[15];
        INSN[14] = imm[14];
        INSN[13] = imm[13];    
        INSN[12] = imm[12];
        INSN[11] = imm[20];
        INSN[10] = imm[30];
        INSN[9] = imm[29];
        INSN[8] = imm[28];
        INSN[7] = imm[27];
        INSN[6] = imm[25];
        INSN[5] = imm[24];
        INSN[4] = imm[23];
        INSN[3] = imm[22];
        INSN[2] = imm[21];
        INSN[1] = imm[20];
        INSN[0] = imm[11];
    }

    /* jalr */
    if (TipoIns == 4) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("imm:");
        scanf("%x", &Dimm);

        printf("Instrucao: jalr x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
        INSN[31] = 1;
        INSN[30] = 1;
        INSN[29] = 1;
        INSN[28] = 0;
        INSN[27] = 0;
        INSN[26] = 1;
        INSN[25] = 1;

        INSNrd (INSN, rd, Drd);

        INSN[19] = 0;
        INSN[18] = 0;
        INSN[17] = 0;

        INSNrs1 (INSN, rs1, Drs1);
        
        imm = DecimalToBinary(Dimm);
        INSN[11] = imm[31];
        INSN[10] = imm[30];
        INSN[9] = imm[29];
        INSN[8] = imm[28];
        INSN[7] = imm[27];
        INSN[6] = imm[26];
        INSN[5] = imm[25];
        INSN[4] = imm[24];
        INSN[3] = imm[23];
        INSN[2] = imm[22];
        INSN[1] = imm[21];
        INSN[0] = imm[20];
    }

    /* B type */
    if (TipoIns >= 5 && TipoIns <= 10) {
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("rs2:");
        scanf("%d", &Drs2);
        printf("imm:");
        scanf("%x", &Dimm); 

        switch (TipoIns){
            case 5:
                printf("Instrucao: beq x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 1; /* beq */
                break;
            case 6:
                printf("Instrucao: bne x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 2;  /* bne */
                break;
            case 7:
                printf("Instrucao: blt x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 3;  /* blt */
                break;
            case 8:
                printf("Instrucao: bge x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 4;  /* bge */
                break;
            case 9:
                printf("Instrucao: bltu x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 5; /* bltu */
                break;
            case 10:
                printf("Instrucao: bgeu x%d, x%d, 0x%x\n", Drs1, Drs2, Dimm);
                FUNC = 6; /* bgeu */
                break;
            default:
                break;
        }
        Binsn (INSN, FUNC, rs1, rs2, imm, Drs1, Drs2, Dimm);
    }

    /* LOADS */
    if (TipoIns >= 11 && TipoIns <= 15) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("imm:");
        scanf("%x", &Dimm);
        
        switch (TipoIns){
            case 11:
                printf("Instrucao: lb x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
                FUNC = 1; /* lb */
                break;
            case 12:
                printf("Instrucao: lh x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
                FUNC = 2;  /* lh */
                break;
            case 13:
                printf("Instrucao: lw x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
                FUNC = 3;  /* lw */
                break;
            case 14:
                printf("Instrucao: lbu x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
                FUNC = 4;  /* lbu */
                break;
            case 15:
                printf("Instrucao: lhu x%d, 0x%x(x%d)\n", Drd, Dimm, Drs1);
                FUNC = 5; /* lhu */
                break;
            default:
                break;
        }
        LOADinsn (INSN, FUNC, rs1, rd, imm, Drs1, Drd, Dimm);
    }

    /* STORES */
    if (TipoIns >= 16 &&  TipoIns <= 18) {
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("rs2:");
        scanf("%d", &Drs2);
        printf("imm:");
        scanf("%x", &Dimm);

        switch (TipoIns) {
            case 16:
                printf("Instrucao: sb x%d, 0x%x(x%d)\n", Drs2, Dimm, Drs1);
                FUNC = 1; /* sb */
                break;
            case 17:
                printf("Instrucao: sh x%d, 0x%x(x%d)\n", Drs2, Dimm, Drs1);
                FUNC = 2;  /* sh*/
                break;
            case 18:
                printf("Instrucao: sw x%d, 0x%x(x%d)\n", Drs2, Dimm, Drs1);
                FUNC = 3;  /* sw */
                break;
            default:
                break;
        }
        STOREinsn (INSN, FUNC, rs1, rs2, imm, Drs1, Drs2, Dimm);
    }

    /* I type */
    if (TipoIns >= 19 && TipoIns <= 27) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("imm:");
        scanf("%x", &Dimm);
        
        switch (TipoIns) {
            case 19:
                printf("Instrucao: addi x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 1; /* addi */
                break;
            case 20:
                printf("Instrucao: slti x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 2;  /* slti */
                break;
            case 21:
                printf("Instrucao: sltiu x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 3;  /* sltiu */
                break;
            case 22:
                printf("Instrucao: xori x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 4;  /* xori */
                break;
            case 23:
                printf("Instrucao: ori x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 5;  /* ori */
                break;
            case 24:
                printf("Instrucao: andi x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 6;  /* andi */
                break;
            case 25:
                printf("Instrucao: slli x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 7;  /* slli */
                break;
            case 26:
                printf("Instrucao: srli x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 8;  /* srli */
                break;
            case 27:
                printf("Instrucao: srai x%d, x%d, 0x%x\n", Drd, Drs1, Dimm);
                FUNC = 9;  /* srai */
                break;
            default:
                break;
        }
        Iinsn (INSN, FUNC, rs1, rd, imm, Drs1, Drd, Dimm);
    }

    /* R type */
    if (TipoIns >= 28 && TipoIns <= 37) {
        printf("rd:");
        scanf("%d", &Drd);
        printf("rs1:");
        scanf("%d", &Drs1);
        printf("rs2:");
        scanf("%d", &Drs2);

        switch (TipoIns) {
            case 28:
                printf("Instrucao: add x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 1; /* add */
                break;
            case 29:
                printf("Instrucao: sub x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 2;  /* sub */
                break;
            case 30:
                printf("Instrucao: sll x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 3;  /* sll */
                break;
            case 31:
                printf("Instrucao: slt x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 4;  /* slt */
                break;
            case 32:
                printf("Instrucao: sltu x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 5;  /* sltu */
                break;
            case 33:
                printf("Instrucao: xor x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 6;  /* xor */
                break;
            case 34:
                printf("Instrucao: srl x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 7;  /* srl */
                break;
            case 35:
                printf("Instrucao: sra x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 8;  /* sra */
                break;
            case 36:
                printf("Instrucao: or x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 9;  /* or */
                break;
            case 37:
                printf("Instrucao: and x%d, x%d, 0x%x\n", Drd, Drs1, Drs2);
                FUNC = 10;  /* and */
                break;
            default:
                break;
        }
        Rinsn (INSN, FUNC, rs1, rs2, rd, Drs1, Drs2, Drd);
    }
    
    return INSN;
}

/* Posiciona o valor do rd no binário da instrução */
void INSNrd(int * INSN, int * rd, int Drd) {
    rd = DecimalToBinary(Drd);
        
    INSN[24] = rd[31];
    INSN[23] = rd[30];
    INSN[22] = rd[29];
    INSN[21] = rd[28];
    INSN[20] = rd[27];
}

/* Posiciona o valor do rs1 no binário da instrução */
void INSNrs1 (int * INSN, int * rs1, int Drs1) {
    rs1 = DecimalToBinary(Drs1);

    INSN[16] = rs1[31];
    INSN[15] = rs1[30];
    INSN[14] = rs1[29];
    INSN[13] = rs1[28];
    INSN[12] = rs1[27]; 
}

/* Posiciona o valor do rs2 no binário da instrução  */
void INSNrs2 (int * INSN, int * rs2, int Drs2) {
    rs2 = DecimalToBinary(Drs2);

    INSN[11] = rs2[31];
    INSN[10] = rs2[30];
    INSN[9] = rs2[29];
    INSN[8] = rs2[28];
    INSN[7] = rs2[27];
}

/* Posiciona o valor do imediato no binário das instruções do tipo U */
void UImm (int * INSN, int * imm, unsigned int Dimm) {
    imm = DecimalToBinary(Dimm);

    INSN[19] = imm[31];
    INSN[18] = imm[30];
    INSN[17] = imm[29];
    INSN[16] = imm[28];
    INSN[15] = imm[27];
    INSN[14] = imm[26];
    INSN[13] = imm[25];
    INSN[12] = imm[24];
    INSN[11] = imm[23];
    INSN[10] = imm[22];
    INSN[9] = imm[21];
    INSN[8] = imm[20];
    INSN[7] = imm[19];
    INSN[6] = imm[18];
    INSN[5] = imm[17];
    INSN[4] = imm[16];
    INSN[3] = imm[15];
    INSN[2] = imm[14];
    INSN[1] = imm[13];
    INSN[0] = imm[12];   
}

/* Constrói o INSN de instruções do tipo B */
void Binsn (int * INSN, int FUNC, int * rs1, int * rs2, int * imm, int Drs1, int Drs2, unsigned int Dimm) {
    INSN[31] = 1;
    INSN[30] = 1;
    INSN[29] = 0;
    INSN[28] = 0;
    INSN[27] = 0;
    INSN[26] = 1;
    INSN[25] = 1;

    imm = DecimalToBinary(Dimm);
    INSN[24] = imm[20];
    INSN[23] = imm[30];
    INSN[22] = imm[29];
    INSN[21] = imm[28];
    INSN[20] = imm[27];

    INSNrs1 (INSN, rs1, Drs1);
    INSNrs2 (INSN, rs2, Drs2);

    INSN[6] = imm[26];
    INSN[5] = imm[25];
    INSN[4] = imm[24];
    INSN[3] = imm[23];
    INSN[2] = imm[22];
    INSN[1] = imm[21];
    INSN[0] = imm[19];

    switch (FUNC) {
        case 1:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 2:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 3:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
        case 4:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
        case 5:
            INSN[19] = 0;
            INSN[18] = 1;
            INSN[17] = 1;
            break;
        case 6:
            INSN[19] = 1;
            INSN[18] = 1;
            INSN[17] = 1;
            break;
        default:
            break;
    }
}

/* Constrói o INSN de instruções de load */
void LOADinsn (int * INSN, int FUNC, int * rs1, int * rd, int * imm, int Drs1, int Drd, unsigned int Dimm) {
    INSN[31] = 1;
    INSN[30] = 1;
    INSN[29] = 0;
    INSN[28] = 0;
    INSN[27] = 0;
    INSN[26] = 0;
    INSN[25] = 0;

    INSNrd (INSN, rd, Drd);

    INSNrs1 (INSN, rs1, Drs1);

    imm = DecimalToBinary(Dimm);
    INSN[11] = imm[31];
    INSN[10] = imm[30];
    INSN[9] = imm[29];
    INSN[8] = imm[28];
    INSN[7] = imm[27];
    INSN[6] = imm[26];
    INSN[5] = imm[25];
    INSN[4] = imm[24];
    INSN[3] = imm[23];
    INSN[2] = imm[22];
    INSN[1] = imm[21];
    INSN[0] = imm[20];
    
    switch (FUNC) {
        case 1:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 2:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 3:
            INSN[19] = 0;
            INSN[18] = 1;
            INSN[17] = 0;
            break;
        case 4:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
        case 5:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
        default:
            break;
    }
}

/* Constrói o INSN de instruções de store */
void STOREinsn (int * INSN, int FUNC, int * rs1, int * rs2, int * imm, int Drs1, int Drs2, unsigned int Dimm){
    INSN[31] = 1;
    INSN[30] = 1;
    INSN[29] = 0;
    INSN[28] = 0;
    INSN[27] = 0;
    INSN[26] = 1;
    INSN[25] = 0;

    imm = DecimalToBinary(Dimm);

    INSN[24] = imm[31];
    INSN[23] = imm[30];
    INSN[22] = imm[29];
    INSN[21] = imm[28];
    INSN[20] = imm[27];

    INSNrs1 (INSN, rs1, Drs1);
    INSNrs2 (INSN, rs2, Drs2);

    INSN[6] = imm[26];
    INSN[5] = imm[25];
    INSN[4] = imm[24];
    INSN[3] = imm[23];
    INSN[2] = imm[22];
    INSN[1] = imm[21];
    INSN[0] = imm[20];

    switch (FUNC) {
        case 1:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 2:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 3:
            INSN[19] = 0;
            INSN[18] = 1;
            INSN[17] = 0;
            break;
        default:
            break;
    }
}

/* Constrói o INSN de instruções do tipo I */
void Iinsn (int * INSN, int FUNC, int * rs1, int * rd, int * imm, int Drs1, int Drd, unsigned int Dimm) {
    INSN[31] = 1;
    INSN[30] = 1;
    INSN[29] = 0;
    INSN[28] = 0;
    INSN[27] = 1;
    INSN[26] = 0;
    INSN[25] = 0;

    INSNrd(INSN, rd, Drd);
    INSNrs1 (INSN, rs1, Drs1);

    imm = DecimalToBinary(Dimm);

    INSN[11] = imm[31];
    INSN[10] = imm[30];
    INSN[9] = imm[29];
    INSN[8] = imm[28];
    INSN[7] = imm[27];

    if (FUNC == 9)
        INSN[1] = 1;
    else {
        INSN[6] = imm[26];
        INSN[5] = imm[25];
        INSN[4] = imm[24];
        INSN[3] = imm[23];
        INSN[2] = imm[22];
        INSN[1] = imm[21];
        INSN[0] = imm[20];
    }

    switch (FUNC) {
        case 1:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        case 2:
            INSN[19] = 0;
            INSN[18] = 1;
            INSN[17] = 0;
            break;
        case 3:
            INSN[19] = 1;
            INSN[18] = 1;
            INSN[17] = 0;
            break;
        case 4:
            INSN[19] = 0;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
        case 5:
            INSN[19] = 0;
            INSN[18] = 1;
            INSN[17] = 1;
            break;
        case 6:
            INSN[19] = 1;
            INSN[18] = 1;
            INSN[17] = 1;
            break;
        case 7:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 0;
            break;
        default:
            INSN[19] = 1;
            INSN[18] = 0;
            INSN[17] = 1;
            break;
    }
}

/* Constrói o INSN de instruções do tipo R */
void Rinsn (int * INSN, int FUNC, int * rs1, int * rs2, int * rd, int Drs1, int Drs2, int Drd) {
    INSN[31] = 1;
    INSN[30] = 1;
    INSN[29] = 0;
    INSN[28] = 0;
    INSN[27] = 1;
    INSN[26] = 1;
    INSN[25] = 0;

    INSNrd(INSN, rd, Drd);
    INSNrs1(INSN, rs1, Drs1);
    INSNrs2(INSN, rs2, Drs2);

    if (FUNC == 2 || FUNC == 8)
        INSN[1] = 1;

    switch (FUNC) {
    case 1:
        INSN[19] = 0;
        INSN[18] = 0;
        INSN[17] = 0;
        break;
    case 2:
        INSN[19] = 0;
        INSN[18] = 0;
        INSN[17] = 0;
        break;
    case 3:
        INSN[19] = 1;
        INSN[18] = 0;
        INSN[17] = 0;
        break;
    case 4:
        INSN[19] = 0;
        INSN[18] = 1;
        INSN[17] = 0;
        break;
    case 5:
        INSN[19] = 1;
        INSN[18] = 1;
        INSN[17] = 0;
        break;
    case 6:
        INSN[19] = 0;
        INSN[18] = 0;
        INSN[17] = 1;
        break;
    case 7:
        INSN[19] = 1;
        INSN[18] = 0;
        INSN[17] = 1;
        break;
    case 8:
        INSN[19] = 1;
        INSN[18] = 0;
        INSN[17] = 1;
        break;
    case 9:
        INSN[19] = 0;
        INSN[18] = 1;
        INSN[17] = 1;
        break;
    case 10:
        INSN[19] = 0;
        INSN[18] = 1;
        INSN[17] = 1;
        break;
    default:
        break;
    }
}

/* Converte um inteiro em um binário, botando cada bit numa posição de um vetor */
int * DecimalToBinary (int decimal) {
    int * Binario = malloc(32 * sizeof(int));
    int i;

    for (i = 0; i < 32; i++)
        Binario[i] = 0;

    for (i = 31; decimal > 0; i--, decimal /= 2)
        Binario[i] = decimal % 2;

    return Binario;
}

/* Função que imprime a lista de opções para as instruções */
void ListaINSN (){
    printf("1 - lui\n2 - auipc\n3 - jal\n4 - jalr\n5 - beq\n6 - bne\n7 - blt\n8 - bge\n9 - bltu\n10 - bgeu\n11 - lb\n12 - lh\n13 - lw\n14 - lbu\n15 - lhu\n16 - sb\n17 - sh\n18 - sw\n19 - addi\n20 - slti\n21 - sltiu\n22 - xori\n23 - ori\n24 - andi\n25 - slli\n26 - srli\n27 - srai\n28 - add\n29 - sub\n30 - sll\n31 - slt\n32 - sltu\n33 - xor\n34 - srl\n35 - sra\n36 - or\n37 - and\n");
    }