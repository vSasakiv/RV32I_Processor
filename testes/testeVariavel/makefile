
compileasm:
	riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -fno-pic -nostdlib -Wl,-Ttext=0x0 -Wl,--no-relax  main.s -o main

compilec:
	riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -fno-pic -nostdlib -Wl,-Ttext=0x0 -Wl,--no-relax  main.c -o main

dump:
	riscv32-unknown-elf-objdump -Mnumeric,no-aliases -dr main > main.dump

bin:
	riscv32-unknown-elf-objcopy main -O binary main.bin

