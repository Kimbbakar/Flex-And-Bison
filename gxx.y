%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
void addVariable(char *name);
%}

%union {
	int INT;
	char ch;
	float fl;
	char str[100]; 
}



%token<INT> DTYPE 
%token<fl> T_FLOAT 
%token<ch> T_CHAR 
%token<INT> T_INT 
%token T_STR
%token T_MOD SEMI T_ASSIGN T_COMA  
%token T_NEWLINE T_QUIT 
%token<str> T_ID


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

STMT: DTYPE IDLIST SEMI {printf("Accepted\n");   }
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

IDLIST: T_ID  						{addVariable($1);}
	| T_ID T_COMA IDLIST			{addVariable($1);}

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
	fprintf(stderr, "%s\n", s); 
	exit(1);
}

int countVariable=0;
char* NameOfVariable[102];
int typeofvariable[102];
int value[102];

void addVariable(char *name){
	int i =0;
	for(i=0;i<countVariable;i++){
		if(strcmp(name,NameOfVariable[i] )==0 ){
			yyerror(strcat(name, ": Declare more than once!!"));
		}
	}

	NameOfVariable[countVariable] = name;
	countVariable++;
}
 