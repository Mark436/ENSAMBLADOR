/*OCHOA ROBLES MARCOS JAVIER*/
%{
#include <stdio.h>

int lineas = 0;
int palabras = 0;
int caracteres = 0;
%}

%%
\n {

    lineas++;
    caracteres++;
}

[a-zA-Z]+ {

    palabras++;
    caracteres += yyleng;
}

. {

    caracteres++;
}
%%

int main() {

    yylex();

    printf("Lineas: %d\n", lineas);
    printf("Palabras: %d\n", palabras);
    printf("Caracteres: %d\n", caracteres);

    return 0;
}

int yywrap() {
    return 1;
}
