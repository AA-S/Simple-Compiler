%{
	#include "a.tab.h"
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
%}

header					"hashcover<"[a-zA-Z]+".header>"
keyWord					number|string|IC|OW|give
function				[a-zA-Z_]+[0-9]*!
operator				"GT"|"LT"|"++"|"--"|"<-"|"**"|"md"|"//"|"pow"|"sin"|"cos"|"tan"|"log"
v						[a-z]
identifier				[a-zA-Z_]+[0-9]*
num	    				[+-]?[0-9]+
DOUBLE					[0-9]*[.]?[0-9]*
punctuationSymbol		LB|RB|LP|RP|cm|sm
singleLineComment		[ ]*[!][!][a-zA-Z0-9!@#$%^&*(){}_+-,.:\|?>< ]*
multipleLineComment		[ ]*[%][&][a-zA-Z0-9!@#$*(){}_+-,.:\|?><\n\t ]*[&][%]
		
%%
{header}				{}

{singleLineComment}		{}
{multipleLineComment}	{}
{operator}				{
							
							if(strcmp(yytext,"++")==0)  return PLUS;
						 	else if(strcmp(yytext,"--")==0)  return MINUS;
						 	else if(strcmp(yytext,"//")==0)  return DIVISION;
						 	else if(strcmp(yytext,"**")==0)  return MULTIPLICATION;
						 	else if(strcmp(yytext,"GT")==0)  return GT;
						 	else if(strcmp(yytext,"LT")==0)  return LT;
						 	else if(strcmp(yytext,"<-")==0)  return ASSIGN;
						 	else if(strcmp(yytext,"md")==0)  return MOD;
						 	else if(strcmp(yytext,"pow")==0)  return POW;
						 	else if(strcmp(yytext,"sin")==0)  return SIN;
						 	else if(strcmp(yytext,"cos")==0)  return COS;
						 	else if(strcmp(yytext,"tan")==0)  return TAN;
						 	else if(strcmp(yytext,"log")==0)  return LOG;
						 
						}

"\n"					{return NEWLINE;}
"("						{return LPA;}
")"						{return RPA;}
{num}					{
							sscanf(yytext, "%d", &yylval);
							return NUMBER;
						}
{DOUBLE}				{
							sscanf(yytext, "%lf", &yylval);
							return DOUBLE;
						}

{keyWord}				{
							if(strcmp(yytext,"number")==0)  return NUMBER;
						 	else if(strcmp(yytext,"string")==0)  return STRING;
						 	else if(strcmp(yytext,"IC")==0)  return IF;
						 	else if(strcmp(yytext,"OW")==0)  return ELSE;
						 	
						}


{punctuationSymbol}		{
							if(strcmp(yytext,"cm")==0)  return CM;
						 	else if(strcmp(yytext,"sm")==0)  return SMC;
						 	else if(strcmp(yytext,"LP")==0)  return LP;
						 	else if(strcmp(yytext,"RP")==0)  return RP;
						 	else if(strcmp(yytext,"LB")==0)  return LB;
						 	else if(strcmp(yytext,"RB")==0)  return RB;

						}

{v}      			    {
                			yylval = *yytext - 'a';
                			return IDENTIFIER1;
            			}

{identifier}			{return IDENTIFIER;}
{function}				{}
.						{}
%%
int yywrap()
{
	return 1;
}
