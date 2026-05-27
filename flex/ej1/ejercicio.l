/*Ochoa robles marcos javier*/
%{
#include <stdio.h>

int palabras = 0;
%}

%%
[a-zA-Z]+    { palabras++; }
.|\n         ;
%%

int main() {

    yylex();

    printf("Palabras: %d\n", palabras);

    return 0;
}