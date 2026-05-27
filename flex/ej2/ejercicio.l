/*Ochoa robles marcos javier*/
%{
#include <stdio.h>

int numeros = 0;
%}

%%
[0-9]+    { numeros++; }
.|\n      ;
%%

int main() {

    yylex();

    printf("Numeros: %d\n", numeros);

    return 0;
}

int yywrap() {
    return 1;
}