; param = si
print_str:
pusha
mov ah, 0x0e
start_print:
lodsb
cmp al, 0
je done
int 0x10
jmp start_print
done:
mov al, 0x0a ; newline char
int 0x10
mov al, 0x0d ; carriage return
int 0x10
popa
ret