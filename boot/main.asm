[bits 16]
[extern main]

mov bx, 0x1000
mov ds, bx

call main
jmp $
; GDT - Stores the segments of protected mode
;
;
;
;
;
;
