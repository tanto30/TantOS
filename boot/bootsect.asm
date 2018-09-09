; =========================================================
; 8888888888888               888     .d88888b.   .d8888b.
; 8888888888888               888    d88P" "Y88b d88P  Y88b
;      888                    888    888     888 Y88b.
;      888   8888b.  88888b.  888888 888     888  "Y888b.
;      888      "88b 888 "88b 888    888     888     "Y88b.
;      888  .d888888 888  888 888    888     888       "888
;      888  888  888 888  888 Y88b.  Y88b. .d88P Y88b  d88P
;      888  "Y888888 888  888  "Y888  "Y88888P"   "Y8888P"
; =========================================================
;                    By Jonathan Banin
; =========================================================

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