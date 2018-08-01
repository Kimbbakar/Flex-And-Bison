%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "y.tab.h"

%}

%%


[ \t]   ; // ignore all whitespace
\".*\"                  {return T_STR;}
\'.*\'                  {return T_CHAR;}
[0-9]+\.[0-9]+          {return T_FLOAT;}
[0-9]+                  {return T_INT;}
"+"                     {return T_PLUS;}
"int"                   {return DTYPE;}
"float"                 {return DTYPE;}
"char"                  {return DTYPE;}
"string"                {return DTYPE;} 
"-"                     {return T_MINUS;}
"*"                     {return T_MULTIPLY;}
"/"                     {return T_DIVIDE;}
"%"                     {return T_MOD;}
"("                     {return T_LEFT;}
")"                     {return T_RIGHT;}
"exit"                  {return T_QUIT;}
";"                     {return SEMI;}
\n                      {return T_NEWLINE;}
":="                    {return T_ASSIGN;}
","                     {return T_COMA;}
[a-zA-Z][a-zA-Z0-9]*    {return T_ID;}

%%