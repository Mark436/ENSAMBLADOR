/*OCHOA ROBLES MARCOS JAVIER*/
%{
#include <stdio.h>
%}

%%
if {

    printf("Reservada: if\n");
}

while {

    printf("Reservada: while\n");
}

return {

    printf("Reservada: return\n");
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