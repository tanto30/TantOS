;DEFINITIONS:
   %macro print 1
        mov si, %1
        call print_
   %endmacro
   %macro hex_down 0
        call print_hex
        call line_down_
   %endmacro
   %include "utils.asm"
;CODE:
    main:
    call line_down_
    print_nl SUCCESSFUL

    print_nl PRINTING_REGISTERS
    print_registers:
        push bx
        print R_AX
        mov bx, ax
        hex_down
        print R_BX
        pop bx
        hex_down
        push bx
        print R_CX
        mov bx, cx
        hex_down
        print R_DX
        mov bx, dx
        hex_down
        print R_SS
        mov bx, ss
        hex_down
        print R_CS
        mov bx, cs
        hex_down
        pop bx

    print_nl SETTING_GDT
    setup_gdt:

    jmp $

;DATA:
    SUCCESSFUL: db "Successfully entered bootloader",0
    PRINTING_REGISTERS: db "PRINTING REGISTERS:",0
    SETTING_GDT: db "Setting GDT",0
    R_AX: db "AX: ",0
    R_BX: db "BX: ",0
    R_CX: db "CX: ",0
    R_DX: db "DX: ",0
    R_SS: db "SS: ",0
    R_CS: db "CS: ",0