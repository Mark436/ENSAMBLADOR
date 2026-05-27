/*OCHOA ROBLES MARCOS JAVIER*/
%{
#include <stdio.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]* {

    printf("Identificador valido: %s\n", yytext);
}

.|\n ;
%%

int main() {

    yylex();

    return 0;
}

int yywrap() {
    return 1;
}