%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "y.tab.h"

%}

%%

[a-zA-Z][a-zA-Z0-9]*    {return T_ID}
[ \t]   ; // ignore all whitespace
[0-9]+\.[0-9]+          {T_FLOAT;}
[0-9]+                  {return T_INT;}
"+"                     {return T_PLUS;}
"int"                   {return DTYPE;}
"float"                 {return DTYPE;}
"char"                  {return DTYPE;}
"-"                     {return T_MINUS;}
"*"                     {return T_MULTIPLY;}
"/"                     {return T_DIVIDE;}
"("                     {return T_LEFT;}
")"                     {return T_RIGHT;}
"exit"                  {return T_QUIT;}
";"                     {return SEMI;}
\n                      {return T_NEWLINE;}
":="                    {return T_ASSIGN;}
","                     {return T_COMA;}

%%