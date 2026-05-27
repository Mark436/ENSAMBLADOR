/*OCHOA ROBLES MARCOS JAVIER*/

%{
#include <stdio.h>
#include <stdlib.h>

int resultado = 0;
char operador = '+';
%}

%%

[0-9]+ {

    int numero = atoi(yytext);

    if(operador == '+')
        resultado += numero;

    else if(operador == '-')
        resultado -= numero;
}

"+" {

    operador = '+';
}

"-" {

    operador = '-';
}

\n {

    printf("Resultado: %d\n", resultado);
}

[ \t] ;

%%

int main() {

    yylex();

    return 0;
}

int yywrap() {

    return 1;
}