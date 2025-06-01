#include <stdio.h>
#include "codegen.h"

int temp_count = 1;

int generate_temp(char *op, int a, int b) {
    int t = temp_count++;
    printf("t%d = %d %s %d\n", t, a, op, b);
    return t;
}

void generate_assignment(char *var, int temp) {
    printf("%s = t%d\n", var, temp);
}
