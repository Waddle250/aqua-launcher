all: aquaiso.bin

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.c
	gcc -ffreestanding -m32 -fno-pic -c kernel.c -o kernel.o
	ld -m elf_i386 -e start -Ttext 0x1000 --oformat binary -o kernel.bin kernel.o

aquaiso.bin: boot.bin kernel.bin
	cat boot.bin kernel.bin > aquaiso.bin

run:
	qemu-system-x86_64 -drive format=raw,file=aquaiso.bin -d cpu_reset,int -no-reboot