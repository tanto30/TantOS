;===============
;= DEFINITIONS =
;===============
	BOOTSECT_SEG equ 0x0
	STACK_SEG equ 0x9000
	STACK_OFF equ 0x1000
	BOOTLOADER_SEG equ 0x0
	BOOTLOADER_OFF equ 0x7e00

	[bits 16]
	[org 0x7c00]


	%macro print_nl 1
		mov si, %1
		call print_
		call line_down_
	%endmacro

;========
;= CODE =
;========
	mov bx, BOOTSECT_SEG
	mov ds, bx
	print_nl STARTING

	print_nl SETTING_STACK
	setup_stack:
	mov bp, STACK_SEG
	mov ss, bp
	mov bp, STACK_OFF
	mov sp, bp

	print_nl LOADING_BOOTLOADER
	read:
	mov bx, BOOTLOADER_SEG
	mov es, bx
	mov bx, BOOTLOADER_OFF
	mov dh, 50
	call disk_load

	print_nl ENTERING_BOOTLOADER
	enter:
	mov bx, BOOTLOADER_SEG
	mov ds, bx
	; For entering main.asm:main
	call BOOTLOADER_SEG:main

	%include "print.asm"
	%include "disk.asm"

;========
;= DATA =
;========
	STARTING: db "Starting",0
	SETTING_STACK: db "Setting up stack | 91000h",0
	LOADING_BOOTLOADER: db "Loading Bootloader | 10000h",0
	ENTERING_BOOTLOADER: db "Entering Bootloader| jmp 1000h:0",0
	times 510-($-$$) db 0
	dw 0xaa55

	%include "main.asm"