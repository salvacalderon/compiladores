%{
#include <stdio.h>
#include "y.tab.h"
%}

OPEN_PARENTHESIS "("
CLOSED_PARENTHESIS ")"

%%
program                       return TOKEN_PROGAM;
principal                     return TOKEN_MAIN;
vacio                         return TOKEN_VOID;
end                           return TOKEN_END;

var                           return TOKEN_VAR;
si                            return TOKEN_IF;
sino                          return TOKEN_ELSE;
mientras                      return TOKEN_WHILE;
hacer                         return TOKEN_DO;
print                         return TOKEN_PRINT;

=                             return TOKEN_ASSIGNMENT;
;                             return TOKEN_SEMICOLON;
:                             return TOKEN_COLON;
,                             return TOKEN_COMMA;

int                           return TOKEN_INT;
float                         return TOKEN_FLOAT;

{OPEN_PARENTHESIS}            return TOKEN_OPEN_PARENTHESIS;
{CLOSED_PARENTHESIS}          return TOKEN_CLOSED_PARENTHESIS;

\[                            return TOKEN_OPEN_BRACKET;
\]                            return TOKEN_CLOSED_BRACKET;

\{                            return TOKEN_OPEN_BRACE;
\}                            return TOKEN_CLOSED_BRACE;

\+                            return TOKEN_PLUS;
\-                            return TOKEN_MINUS;
\*                            return TOKEN_MULTIPLICATION;
\/                            return TOKEN_DIVISION;

\<                            return TOKEN_LESS_THAN;
\>                            return TOKEN_GREATER_THAN;
\!=                           return TOKEN_NOT_EQUAL;

[[:lower:]][[:alnum:]_]*      return TOKEN_IDENTIFIER;
\".*\"                        return TOKEN_CONST_STRING;
[[:digit:]]+                  return TOKEN_CONST_INT;
[[:digit:]]+\.[[:digit:]]*    return TOKEN_CONST_FLOAT;

\n                            /* ignore whitespace */
[ \t]+                        /* ignore whitespace */

%%