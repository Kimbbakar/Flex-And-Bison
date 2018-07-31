%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}
 
%token DTYPE T_INT T_FLOAT T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT SEMI T_ASSIGN T_ID T_COMA
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%start PROG

%%
PROG: STMTS
	
;

STMTS: T_NEWLINE {printf("ACCEPTED\n"); return 0; }
	| STMT T_NEWLINE STMTS 
	| T_QUIT T_NEWLINE { printf("Program Ends\n"); exit(0) ;}
;

STMT: DTYPE T_ID IDLIST SEMI
	| T_ID T_ASSIGN EXPR SEMI  
;

EXPR: 

;

TEMP: T_INT
	| T_ID
;

IDLIST: T_ID T_COMA IDLIST
	| T_ID

;


%%
int main() {
	yyin = stdin;
	do { 
		yyparse();
	} while(!feof(yyin));
	return 0;
}
void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}