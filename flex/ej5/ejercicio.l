/*OCHOA ROBLES MARCOS JAVIER*/
%{
#include <stdio.h>
%}

%%
[ \t]+ ;

\n {

    printf("\n");
}

. {

    printf("%s", yytext);
}
%%

int main() {

    yylex();

    return 0;
}

int yywrap() {
    return 1;
}