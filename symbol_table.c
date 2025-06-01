#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

symbol symtab[MAX_SYMBOLS];
int sym_count = 0;

void add_symbol(char *name) {
    strcpy(symtab[sym_count].name, name);
    symtab[sym_count].temp_id = sym_count + 100;
    sym_count++;
}

int lookup_symbol(char *name) {
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0)
            return 1;
    }
    return 0;
}

int get_var(char *name) {
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0)
            return symtab[i].temp_id;
    }
    return -1;
}
