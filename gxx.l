%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

#include "y.tab.h"

%}

%%


[ \t]   ; // ignore all whitespace
\".*\"                  {printf("STRING = %s\n",yytext); return T_STR;}
\'.*\'                  {printf("CHAR  = %s\n",yytext);return T_CHAR;}
[0-9]+\.[0-9]+          {printf("FLOAT = %s\n",yytext);return T_FLOAT;}
[1-9][0-9]+                  {printf("INT = %s\n",yytext);yylval.INT = atoi(yytext) ; return T_INT;}
"+"                     {printf("OP = %s\n",yytext); return T_PLUS;}
"SAY:"					{return SAY;}
"int"                   {printf("TYPE = %s\n",yytext); return DTYPE;}
"float"                 {printf("TYPE = %s\n",yytext); return DTYPE;}
"char"                  {printf("TYPE = %s\n",yytext); return DTYPE;}
"string"                {printf("TYPE = %s\n",yytext); return DTYPE;} 
"-"                     {printf("OP = %s\n",yytext); return T_MINUS;}
"*"                     {printf("OP = %s\n",yytext); return T_MULTIPLY;}
"/"                     {printf("OP = %s\n",yytext); return T_DIVIDE;}
"%"                     {printf("OP = %s\n",yytext); return T_MOD;}
"("                     {printf("OP = %s\n",yytext); return T_LEFT;}
")"                     {printf("OP = %s\n",yytext); return T_RIGHT;}
"exit"                  {return T_QUIT;}
";"                     {return SEMI;}
\n                      {return T_NEWLINE;}
":="                    {return T_ASSIGN;}
","                     {return T_COMA;}
[a-zA-Z][a-zA-Z0-9]*    {strcpy(yylval.str , yytext) ;printf("ID = %s\n",yytext); return T_ID;}
.						{yyerror("Not Accepted") ;}
%%