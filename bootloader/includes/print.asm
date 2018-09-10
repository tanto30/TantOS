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
call print_nl
popa
ret

print_nl:
push ax
mov ah, 0x0e
mov al, 0x0a ; newline char
int 0x10
mov al, 0x0d ; carriage return
int 0x10
pop ax
ret


;bx
print_hex:
pusha
mov ah, 0x0e
mov al, '0'
int 0x10
mov al, 'x'
int 0x10
mov cx, 4
al_ascii:
rol bx, 4
mov al, bl
and al, 0xF
cmp al, 0ah
sbb al, 69h
das
int 0x10
loop al_ascii
call print_nl
popa
ret