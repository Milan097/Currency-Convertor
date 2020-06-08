/*** Declaration ***/
%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include "y.tab.h"
	char* p;
	int isFirst = 0;
%}

DIGIT	[0-9]

/* Rules Section Starts */


{DIGIT}+									{ 
												yylval.d = atof(yytext);
												return AMOUNT;
											}

{DIGIT}*.{DIGIT}+							{ 
												yylval.d = atof(yytext); 
												return AMOUNT;
											}

[=]											{ 	return EQ;	}

[?]											{ 	return QUE;	}

AUD|EUR|INR|CAD|JPY|USD|PKR|PHP|RUB|ZWD		{   
												p=(char *)calloc(strlen(yytext)+1,sizeof(char));
												strcpy(p,yytext);
												if(isFirst == 0)
													yylval.c1 = p;
												else
													yylval.c2 = p;
												isFirst = 1;
												return CURRENCY;
											}

[ \t]										{ 	return SPACE;	}

[\n] 										{	return NEWLINE;	}

.											{ 	
												printf("Unrecognized : %s\n",yytext);
												yyerror("Invalid Command");
											}

%%

int yywrap() {
	return 1;
}

/*
int main(int argc, char **argv) {
	if(argc > 1) {
		yyin = fopen(argv[1],"r");
	}
	else {
		yyin = stdin;
	}
	yylex();
	return 0;
}
*/