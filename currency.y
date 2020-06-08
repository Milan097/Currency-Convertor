%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<math.h>
	int yylex(void);
	void yyerror(const char *s);
	extern char *yytext;
	
	void calcAns();
	void appInfo();
	float convertToINR(float num);
	float convertFromINR(float num);
	
	char* fromCurrency;
	char* toCurrency;
	int isAns = 0;
	float num;
	float ans = 0.0;
%}

%union {
	char* c1;
	char* c2;
	float d;
}

%token AMOUNT CURRENCY EQ QUE NEWLINE SPACE

%%
	START: conversion NEWLINE 			{	
											calcAns();
											return 0;
										}
										
	conversion: AMOUNT SPACE 			{
											num = yylval.d;
										}
				expr
	
	expr: 		CURRENCY SPACE 			{
											fromCurrency = yylval.c1;
										}
				op

	op: 		EQ SPACE QUE SPACE second {}
	
	second:		CURRENCY				{
											toCurrency = yylval.c2;
										}
	
%%

void calcAns() {
	if(num == 0.0) {
		printf("0.000000");
		ans = convertToINR(1.0);
		ans = convertFromINR(ans);
		printf("\n 1 %s = %f %s\n",fromCurrency,ans / 1.0,toCurrency);
	}
	ans = convertToINR(num);
	ans = convertFromINR(ans);
		
	printf("\n-->  %f  <--",ans);
	printf("\n 1 %s = %f %s\n",fromCurrency,ans / num,toCurrency);
}

float convertToINR(float num) {
	if(strcmp(fromCurrency, "AUD")==0) {
		num = num * 50.36;
	}
	else if(strcmp(fromCurrency, "EUR")==0) {
		num = num * 83.87;
	}
	else if(strcmp(fromCurrency, "CAD")==0) {
		num = num * 54.85;
	}
	else if(strcmp(fromCurrency, "JPY")==0) {
		num = num * 0.70;
	}
	else if(strcmp(fromCurrency, "USD")==0) {
		num = num * 75.52;
	}
	else if(strcmp(fromCurrency, "PKR")==0) {
		num = num * 0.47; 
	}
	else if(strcmp(fromCurrency, "PHP")==0) {
		num = num * 1.50;
	}
	else if(strcmp(fromCurrency, "ZWD")==0) {
		num = num * 0.2085;
	}
	else if(strcmp(fromCurrency, "RUB")==0) {
		num = num * 1.08;
	} 
	return num;
}

float convertFromINR(float num) {
	if(strcmp(toCurrency, "AUD")==0) {
		num = num / 50.36;
	}
	else if(strcmp(toCurrency, "EUR")==0) {
		num = num / 83.87;
	}
	else if(strcmp(toCurrency, "CAD")==0) {
		num = num / 54.85;
	}
	else if(strcmp(toCurrency, "JPY")==0) {
		num = num / 0.70;
	}
	else if(strcmp(toCurrency, "USD")==0) {
		num = num / 75.52;
	}
	else if(strcmp(toCurrency, "PKR")==0) {
		num = num / 0.47; 
	}
	else if(strcmp(toCurrency, "PHP")==0) {
		num = num / 1.50;
	}
	else if(strcmp(toCurrency, "ZWD")==0) {
		num = num / 0.2085;
	}
	else if(strcmp(toCurrency, "RUB")==0) {
		num = num / 1.08;
	} 
	return num;
}

void appInfo() {
	printf("\n\n##################\tCURRENCY CONVERTER\t##################\n");
	printf("\t     Developer : Milan Thummar , Jay Thanki\n\n");
	printf("Input format:\n");
	printf("\t  Amount Currency1 = ? Currency2\n\n");
	printf("Amount --> Amount to be convert from Currency1 to Currency2\n");
	printf("\n\nAmount --> Integer or Float\n");
	printf("Currency :\n");
	printf("\t\tINR -> Indian Ruppee \n");
	printf("\t\tAUD -> Australian Dollar\n");
	printf("\t\tEUR -> Euro:\n");
	printf("\t\tCAD -> Canadian Dollar\n");
	printf("\t\tJPY -> Japanese Yen\n");
	printf("\t\tUSD -> United States Dollar\n");
	printf("\t\tPKR -> Pakistani Ruppee\n");
	printf("\t\tPHP -> Philippine Peso\n");
	printf("\t\tRUB -> Russian Ruble\n");
	printf("\t\tZWD -> Zimbabwean Dollar\n\n");	
}

int main() {
	appInfo();
	yyparse();
    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "%s\n", s);
    return;
}