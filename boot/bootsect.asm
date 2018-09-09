;====================================================
; TTTTTTTTT   AAAA   N    N  TTTTTTTTT  OOOOOO  SSSSS
;     T      A    A  NN   N      T      O    O  S
;     T      AAAAAA  N N  N      T      O    O  SSSSS
;     T      A    A  N  N N      T      O    O      S
;     T      A    A  N   NN      T      OOOOOO  SSSSS
; COPYRIGHT Jonathan Banin: github.com/tanto30
;====================================================
[org 0x7c00]
[bits 16]

%macro print 1
    mov si, %1
    call print_str
%endmacro

CODE:
    print STARTING
    start:

    print SETTING_STACK
    setup_stack:
    mov bp, 0x9000
    mov ss, bp
    mov bp, 0x1000
    mov sp, bp

    print LOADING_BOOTLOADER
    read:
    mov bx, 0x1000
    mov es, bx
    xor bx, bx
    mov dh, 0x80 ; NOTE - when  running from bochs this has to be 72
    call disk_load

    print ENTERING_BOOTLOADER
    enter:
    jmp 0x1000:0
    %include "print.asm"
    %include "disk.asm"

DATA:
    STARTING: db "Starting",0
    SETTING_STACK: db "Setting up stack",0
    LOADING_BOOTLOADER: db "Loading Bootloader",0
    ENTERING_BOOTLOADER: db "Entering Bootloader",0
    times 510-($-$$) db 0
    dw 0xaa55