;===============
;= DEFINITIONS =
;===============
   %macro print 1
		mov si, %1
		call print_
   %endmacro
   %macro hex_down 0
		call print_hex
		call line_down_
   %endmacro
   %macro reg 1
		%strcat label "R_", %1, ": "
		%deftok label label
		%strcat value %1, ": "
		label db value,0
   %endmacro
   %include "utils.asm"

;========
;= CODE =
;========
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
		print R_DS
		mov bx, ds
		hex_down

	print_nl SETTING_GDT
	setup_gdt:
		cli
		lgdt [gdt_descriptor]
		mov eax, cr0
		or eax, 0x1
		mov cr0, eax
		jmp CODE_SEG:PM
	jmp $
	%include "gdt.asm"

;========
;= DATA =
;========
	SUCCESSFUL: db "Successfully entered bootloader",0
	PRINTING_REGISTERS: db "PRINTING REGISTERS:",0
	SETTING_GDT: db "Setting GDT",0
	reg "AX"
	reg "BX"
	reg "CX"
	reg "DX"
	reg "DS"
	reg "CS"
	reg "SS"

[bits 32]
	PM:
		mov ax, DATA_SEG
		mov ds, ax
		mov ss, ax
		mov es, ax
		mov gs, ax
		mov fs, ax
		mov ebp, 0x90000
		mov esp, ebp
		mov ebx, SUCCESSFUL32
		call print_string_pm
		jmp $
		%include "print32.asm"
		SUCCESSFUL32: db "Successful 32 mode!",0