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

;CODE:
    print SUCCESSFUL

    print PRINTING_REGISTERS
    print_registers:
        print R_AX

    print SETTING_GDT
    setup_gdt:
    mov bp, 0x9000
    mov ss, bp
    mov bp, 0x1000
    mov sp, bp



    jmp $


;DATA:
    SUCCESSFUL: db "Successfully entered bootloader",0
    PRINTING_REGISTERS: db "PRINTING REGISTERS:",0
    SETTING_GDT: db "Setting GDT",0
    R_AX: db "AX",0
    R_BX: db "BX",0
    R_CX: db "CX",0
    R_DX: db "DX",0
    R_SS: db "SS",0
    R_CS: db "CS",0