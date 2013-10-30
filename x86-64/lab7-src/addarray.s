    .text
.globl addarray
    .type   addarray, @function
addarray:
    /* int addarray(int n, int * array) */
    /* n = %rdi, array = %rsi */
    /* i = %rdx, sum = %rax */
    movq    $0, %rdx
    movq    $0, %rax
while:
    cmpq    %rdx, %rdi
    je  afterw

    addq    (%rsi), %rax
    addq    $1, %rdx
    addq    $4, %rsi
    jmp     while 
afterw:
    ret
