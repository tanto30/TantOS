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
popa
ret

print_nl:
push ax
mov ah, 0x0e
mov al, 0xa
int 0x10
mov al, 0xd
int 0x10
pop ax
ret