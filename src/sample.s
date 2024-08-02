.globl plus, main

plus:
    add w0, w1, w0
    ret

main:
    mov w0, 3
    mov w1, 7
    bl plus
    ret

