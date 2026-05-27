/*OCHOA ROBLES MARCOS JAVIER*/

%{
#include <stdio.h>
%}

%%

\/\*([^*]|\*+[^*/])*\*\/ {

    printf("Comentario encontrado:\n%s\n", yytext);
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