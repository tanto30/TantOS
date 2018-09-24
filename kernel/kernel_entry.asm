;===============
;= DEFINITIONS =
;===============
    [bits 32]
    [extern kernel_main]
    [global _start]
;========
;= CODE =
;========
    _start:
    call kernel_main
    jmp $
