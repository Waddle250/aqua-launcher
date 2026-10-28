[org 0x7c00]

xor ax, ax
mov ds, ax ; ds was being naughty so i did uh... this?

mov ax, 0x0000
mov es, ax
mov bx, 0x1000

mov ah, 0x02
mov al, 32
mov dh, 0
mov cl, 2
mov ch, 0

int 0x13 ; reads disk or smth

cli
lgdt [gdt_descriptor]
mov eax, cr0
or eax, 0x1       ; bit go flippy-flippy :D
mov cr0, eax


[bits 32]; 32 bit stuff omg

jmp 0x08:init_32bit 
init_32bit:
    mov ax, 0x10   
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000     
    mov esp, ebp         

    jmp 0x1000    

[bits 16]
gdt_start:
    dd 0x0
    dd 0x0

    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start -1
    dd gdt_start

times 510-($-$$) db 0   
dw 0xaa55