C = ${wildcard */*.c}
H = ${wildcard */*.h}
O = ${C:.c=.o}
INCLUDES = ${wildcard */includes/}

os-image: bootloader/bootsect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${O}
	ld -m elf_i386 -Ttext 0x200 -o $@ $^ --oformat binary

%.o: %.asm
	nasm -f aout $< -o $@

%.o: %.c
	gcc -m16 -ffreestanding -c $< -o $@ -fno-pie

%.bin: %.asm
	nasm $< -f bin -o $@ -I ${INCLUDES}


run: os-image
	qemu-system-i386 -drive file=os-image,if=floppy,index=0,format=raw

clean:
	rm -rf *.bin *.dis *.o os-image *.elf
	rm -rf */*.o */*.bin

rerun:
	make clean
	make run
