%{

#include <stdio.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
int yyparse();
 
void yyerror(const char *str) {
  fprintf(stderr, "error: %s\n",str);
}
 
int yywrap() {
  return 1;
} 
  
int main() {
  return yyparse();
} 

%}

%token TOKEN_PROGAM TOKEN_MAIN TOKEN_VOID TOKEN_END TOKEN_VAR TOKEN_IF TOKEN_ELSE TOKEN_WHILE TOKEN_DO TOKEN_PRINT TOKEN_ASSIGNMENT TOKEN_SEMICOLON TOKEN_COLON TOKEN_COMMA TOKEN_INT TOKEN_FLOAT TOKEN_OPEN_PARENTHESIS TOKEN_CLOSED_PARENTHESIS TOKEN_OPEN_BRACKET TOKEN_CLOSED_BRACKET TOKEN_OPEN_BRACE TOKEN_CLOSED_BRACE TOKEN_PLUS TOKEN_MINUS TOKEN_MULTIPLICATION TOKEN_DIVISION TOKEN_LESS_THAN TOKEN_GREATER_THAN TOKEN_NOT_EQUAL TOKEN_IDENTIFIER TOKEN_CONST_STRING TOKEN_CONST_INT TOKEN_CONST_FLOAT

%%
program: 
	TOKEN_PROGAM TOKEN_IDENTIFIER TOKEN_SEMICOLON program_aux TOKEN_MAIN body TOKEN_END

program_aux: 
    vars program_funcs_aux
	| program_funcs_aux
    | /*epsilon*/

program_funcs_aux: 
    funcs program_funcs_aux
    | /*epsilon*/

vars: 
	TOKEN_VAR vars_aux

vars_aux: 
    TOKEN_IDENTIFIER vars_id_aux TOKEN_COLON type TOKEN_SEMICOLON vars_loop

vars_loop: 
    vars_aux
    | /*epsilon*/

vars_id_aux: 
    TOKEN_COMMA TOKEN_IDENTIFIER vars_id_aux
    | /*epsilon*/

type: 
	TOKEN_INT
	| TOKEN_FLOAT

body: 
	TOKEN_OPEN_BRACE body_aux TOKEN_CLOSED_BRACE

body_aux: 
	statement body_aux
	| /*epsilon*/

statement: 
	assign
	| condition
	| cycle
    | f_call
	| print

assign: 
	TOKEN_IDENTIFIER TOKEN_ASSIGNMENT expression TOKEN_SEMICOLON

condition: 
	TOKEN_IF TOKEN_OPEN_PARENTHESIS expression TOKEN_CLOSED_PARENTHESIS body condition_aux TOKEN_SEMICOLON

condition_aux: 
	TOKEN_ELSE body
    | /*epsilon*/

cycle: 
	TOKEN_WHILE body TOKEN_DO TOKEN_OPEN_PARENTHESIS expression TOKEN_CLOSED_PARENTHESIS TOKEN_SEMICOLON

f_call: 
    TOKEN_IDENTIFIER TOKEN_OPEN_PARENTHESIS f_call_aux TOKEN_CLOSED_PARENTHESIS TOKEN_SEMICOLON

f_call_aux: 
    expression f_call_comma
    | /*epsilon*/

f_call_comma: 
    TOKEN_COMMA expression f_call_comma
    | /*epsilon*/

print: 
	TOKEN_PRINT TOKEN_OPEN_PARENTHESIS print_aux TOKEN_CLOSED_PARENTHESIS TOKEN_SEMICOLON

print_aux: 
    TOKEN_CONST_STRING print_comma
    | expression print_comma

print_comma:
    TOKEN_COMMA expression print_comma
    | TOKEN_COMMA TOKEN_CONST_STRING print_comma
    | /*epsilon*/

expression: 
	exp expression_aux

expression_aux: 
	expression_operator exp
    | /*epsilon*/

expression_operator: 
	TOKEN_GREATER_THAN
	| TOKEN_LESS_THAN
	| TOKEN_NOT_EQUAL

exp: 
	term exp_aux

exp_aux: 
    exp_operator exp
	| /*epsilon*/

exp_operator: 
	TOKEN_PLUS
	| TOKEN_MINUS

term: 
	factor term_aux

term_aux: 
	term_operator term
    | /*epsilon*/

term_operator: 
	TOKEN_MULTIPLICATION
	| TOKEN_DIVISION

factor: 
	TOKEN_OPEN_PARENTHESIS expression TOKEN_CLOSED_PARENTHESIS
	| factor_operator factor_symbol

factor_operator: 
    TOKEN_PLUS
    | TOKEN_MINUS
    | /*epsilon*/

factor_symbol: 
    TOKEN_IDENTIFIER
    | cte

cte: 
	TOKEN_CONST_INT
	| TOKEN_CONST_FLOAT

funcs: 
    TOKEN_VOID TOKEN_IDENTIFIER TOKEN_OPEN_PARENTHESIS funcs_aux TOKEN_CLOSED_PARENTHESIS TOKEN_OPEN_BRACKET funcs_bracket_aux body TOKEN_CLOSED_BRACKET TOKEN_SEMICOLON

funcs_aux: 
    TOKEN_IDENTIFIER TOKEN_COLON type funcs_comma
    | /*epsilon*/

funcs_comma: 
    TOKEN_COMMA TOKEN_IDENTIFIER TOKEN_COLON type funcs_comma
    | /*epsilon*/

funcs_bracket_aux: 
    vars
    | /*epsilon*/
%%