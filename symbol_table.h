#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#define MAX_SYMBOLS 100

typedef struct {
    char name[100];
    int temp_id;
} symbol;

void add_symbol(char *name);
int lookup_symbol(char *name);
int get_var(char *name);

#endif
