    .file   "mystrlen.c"
    .text
.globl mystrlen
    .type   mystrlen, @function
mystrlen:
    /* int mystrlen(char *a) */
    /* a = %rdi */
    movq    $0, %rax
while:
    cmpb    $0, (%rdi)
    je  afterw
    addq    $1, %rax
    incq    %rdi
    jmp     while
afterw:
    ret 
