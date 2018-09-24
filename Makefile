C := ${wildcard kernel/*.c kernel/modules/*.c}
H := ${wildcard kernel/*.h kernel/modules/*.h}
O := ${C:.c=.o}
INCLUDES = ${wildcard */includes/}

WARNINGS := -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align \
			-Wwrite-strings -Wmissing-prototypes -Wmissing-declarations \
			-Wredundant-decls -Wnested-externs -Winline -Wno-long-long \
			-Wconversion -Wstrict-prototypes
GCC_FLAGS := -m32 -ffreestanding $(WARNINGS)

os-image: bootloader/bootsect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${O}
	ld -m elf_i386 -Ttext 0x7f8c -o $@ $^ --oformat binary

%.o: %.asm
	nasm -f aout $< -o $@

%.o: %.c
	gcc ${GCC_FLAGS} -c $< -o $@ -fno-pie

%.bin: %.asm
	nasm $< -f bin -o $@ -I ${INCLUDES} -I bootloader/


run: os-image
	qemu-system-i386 -drive file=os-image,if=floppy,index=0,format=raw

clean:
	rm -rf *.bin *.dis *.o os-image *.elf
	rm -rf */*.o */*.bin */*/*.o

rerun:
	make clean
	make run
