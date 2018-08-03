%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
void addVariable(char *name);
void setvalue(char * name,int val);
int getvalue(char * name);
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
%token T_STR SAY T_MOD SEMI T_ASSIGN T_COMA T_NEWLINE T_QUIT 
%token<str> T_ID

%type <INT> EXPR TERM


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
	| T_QUIT T_NEWLINE 					{ printf("Program Ends\n"); exit(0) ;}
	| SAY SAYLIST SEMI T_NEWLINE STMTS		
;

SAYLIST: T_ID  							{printf("%s: %d\n",$1,getvalue($1) );}
	| T_ID T_COMA SAYLIST				{printf("%s: %d\n",$1,getvalue($1) );}
;

STMT: DTYPE IDLIST SEMI 				{printf("Accepted\n");   }
	| T_ID T_ASSIGN EXPR SEMI  			{setvalue($1,$3)  ;printf("Accepted\n");   }
;

EXPR: TERM								{$$ = $1;}
;
 

TERM: T_INT 
;

IDLIST: T_ID  							{addVariable($1);}
	| T_ID T_COMA IDLIST				{addVariable($1);}

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

	NameOfVariable[countVariable] = strdup(name);
	value[countVariable] = 0;
	countVariable++;
}
 
int getvalue(char * name){
	int i =0;
	for(i=0;i<countVariable;i++){
		if(strcmp(name,NameOfVariable[i] )==0 ){
			return value[i];
		}
	}

	yyerror(strcat(name, ": Does not exist!!"));	
	
}

void setvalue(char * name,int val){
	int i =0;
	for(i=0;i<countVariable;i++){
		if(strcmp(name,NameOfVariable[i] )==0 ){
			value[i] = val;
			return ;
		}
	}

	yyerror(strcat(name, ": Does not exist!!"));	
	
}
