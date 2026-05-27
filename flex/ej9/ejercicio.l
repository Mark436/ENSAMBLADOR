/*OCHOA ROBLES MARCOS JAVIER*/

%{
#include <stdio.h>
%}

%%

[0-9]+ {

    printf("NUMERO: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {

    printf("IDENTIFICADOR: %s\n", yytext);
}

[\+\-\*\/=] {

    printf("OPERADOR: %s\n", yytext);
}

[ \t\n] ;

. {

    printf("DESCONOCIDO: %s\n", yytext);
}

%%

int main() {

    yylex();

    return 0;
}

int yywrap() {

    return 1;
}