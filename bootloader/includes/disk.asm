;========
;= CODE =
;========
    disk_load:
    pusha
    push dx

    ; ah <- int 0x13 function. 0x02 = 'read'
    ; al <- number of sectors to read (0x01 .. 0x80)
    ; cl <- sector (0x01 .. 0x11)
    ; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
    ; dl <- drive number
    ; dh <- head number (0x0 .. 0xF)
    ; es <- buffer sector
    ; bx <- buffer offset

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13

    ; error in carry bit
    jc disk_error
    ; BIOS sets 'al' to #sectors read
    pop dx
    cmp al, dh
    jne sectors_error

    popa
    ret

    disk_error:
    print_nl DISK_ERROR
    jmp disk_loop
    sectors_error:
    print_nl SECTORS_ERROR
    disk_loop:
    jmp $

;========
;= DATA =
;========
    DISK_ERROR: db "Disk read error", 0
    SECTORS_ERROR: db "Incorrect number of sectors read", 0
