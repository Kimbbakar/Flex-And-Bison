%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%union {
	int INT;
	char ch;
	float fl; 
}



%token<INT> DTYPE 
%token<fl> T_FLOAT 
%token<ch> T_CHAR 
%token T_INT T_STR
%token T_MOD SEMI T_ASSIGN T_ID T_COMA  
%token T_NEWLINE T_QUIT 


%left T_MINUS 
%left T_PLUS
%left T_MULTIPLY 
%left T_DIVIDE   
%left T_LEFT T_RIGHT


%start PROG

%%
PROG: STMTS
	
;

STMTS: STMT T_NEWLINE STMTS 
	| T_QUIT T_NEWLINE { printf("Program Ends\n"); exit(0) ;}
;

STMT: DTYPE T_ID IDLIST SEMI {printf("Accepted\n");   }
	| T_ID T_ASSIGN EXPR SEMI  {printf("Accepted\n");   }
;

EXPR: 
	| T_MINUS TERM EXPR
	| T_LEFT EXPR T_RIGHT EXPR
	| TERM
	| TERM T_PLUS EXPR
	| TERM T_MINUS EXPR	
	| TERM T_MULTIPLY EXPR
	| TERM T_DIVIDE EXPR 
	| TERM T_MOD EXPR 


;

TERM: T_ID
	| T_INT
	| T_STR
	| T_FLOAT
	| T_CHAR
;

IDLIST: 
	| T_COMA T_ID  IDLIST 

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
//	printf("Not Accepted\n"); 
	fprintf(stderr, "Parse error: %s\n", s);
	//return ;
	exit(1);
}