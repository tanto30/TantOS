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
;DEFINITIONS:
    [bits 16]

    STACK_SEGMENT equ 0x9000
    STACK_OFFSET equ 0x1000

    BOOTLOADER_SEGMENT equ 0x7c0
    BOOTLOADER_OFFSET equ 0x200

    %macro print 1
        mov si, %1
        call print_str
    %endmacro

;CODE:
    mov bx, 0x7c0
    mov ds, bx
    print STARTING

    print SETTING_STACK
    setup_stack:
    mov bp, STACK_SEGMENT
    mov ss, bp
    mov bp, STACK_OFFSET
    mov sp, bp

    print LOADING_BOOTLOADER
    read:
    mov bx, BOOTLOADER_SEGMENT
    mov es, bx
    mov bx, BOOTLOADER_OFFSET
    mov dh, 50
    call disk_load

    print ENTERING_BOOTLOADER
    enter:
    mov bx, BOOTLOADER_SEGMENT
    mov ds, bx
    jmp BOOTLOADER_SEGMENT:BOOTLOADER_OFFSET

    %include "print.asm"
    %include "disk.asm"

;DATA:
    STARTING: db "Starting",0
    SETTING_STACK: db "Setting up stack | 91000h",0
    LOADING_BOOTLOADER: db "Loading Bootloader | 10000h",0
    ENTERING_BOOTLOADER: db "Entering Bootloader| jmp 1000h:0",0
    times 510-($-$$) db 0
    dw 0xaa55

    %include "main.asm"